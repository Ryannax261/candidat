package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.DetailDevisDAO;
import com.example.dao.DevisDAO;
import com.example.dao.DevisStatutDAO;
import com.example.dao.StatutDevisDAO;
import com.example.model.DetailDevis;
import com.example.model.Devis;
import com.example.model.DevisStatut;
import com.example.model.StatutDevis;

@Service
public class DevisService {

    private final DevisDAO devisDAO;
    private final DetailDevisDAO detailDevisDAO;
    private final DevisStatutDAO devisStatutDAO;
    private final StatutDevisDAO statutDevisDAO;

    public DevisService(DevisDAO devisDAO, DetailDevisDAO detailDevisDAO,
                        DevisStatutDAO devisStatutDAO, StatutDevisDAO statutDevisDAO) {
        this.devisDAO = devisDAO;
        this.detailDevisDAO = detailDevisDAO;
        this.devisStatutDAO = devisStatutDAO;
        this.statutDevisDAO = statutDevisDAO;
    }

    public List<Devis> getAll() {
        return devisDAO.findAll();
    }

    public Devis save(Devis devis) {
        return devisDAO.save(devis);
    }

    @Transactional
    public void saveDevis(Devis devis, List<DetailDevis> details) {
        if (details == null || details.isEmpty()) {
            throw new RuntimeException("Un devis doit avoir au moins une ligne de détail.");
        }

        Devis savedDevis = devisDAO.save(devis);
        double totalGlobal = 0;

        for (DetailDevis detail : details) {
            double pu  = detail.getPu();
            double qtt = detail.getQuantite();

            if (pu <= 0 || qtt <= 0) {
                throw new RuntimeException("Le prix unitaire et la quantité doivent être supérieurs à 0.");
            }
             if (pu >= 1000000) {
                pu = pu * 0.9;
            }


            detail.setDevis(savedDevis);
            double prix_total = pu * qtt;     

            
            

            detail.setPrix(prix_total);         
            detailDevisDAO.save(detail);

            totalGlobal += prix_total;       
            
        }

        savedDevis.setMontantTotal(totalGlobal);

        // Assignation automatique du 1er statut correspondant au type du devis
        List<StatutDevis> statutsPourType = statutDevisDAO.findByTypeDevisOrderByIdAsc(savedDevis.getTypeDevis());
        if (statutsPourType.isEmpty()) {
            throw new RuntimeException(
                "Aucun statut défini pour le type de devis : " + savedDevis.getTypeDevis().getNom()
                + ". Veuillez créer au moins un statut pour ce type dans 'Statuts Devis'."
            );
        }
        DevisStatut ds = new DevisStatut();
        ds.setDevis(savedDevis);
        ds.setStatutDevis(statutsPourType.get(0)); // premier statut = statut initial
        devisStatutDAO.save(ds);
        
    }

    public Devis getById(int id) {
        return devisDAO.findById(id).orElse(null);
    }

    public void updateStatut(int devisId, int statutDevisId) {
        Devis devis = devisDAO.findById(devisId)
            .orElseThrow(() -> new RuntimeException("Devis introuvable : " + devisId));
        StatutDevis statut = statutDevisDAO.findById(statutDevisId)
            .orElseThrow(() -> new RuntimeException("StatutDevis introuvable : " + statutDevisId));
        DevisStatut ds = new DevisStatut();
        ds.setDevis(devis);
        ds.setStatutDevis(statut);
        devisStatutDAO.save(ds);
    }

    public List<DevisStatut> getAllStatusHistory() {
        return devisStatutDAO.findAllByOrderByIdDesc();
    }

    public List<DevisStatut> getStatusHistoryByDemande(int demandeId) {
        return devisStatutDAO.findByDevisDemandeIdOrderByIdDesc(demandeId);
    }

    public Double getTotalTurnover() {
        Double total = detailDevisDAO.getTotalTurnover();
        return total != null ? total : 0.0;
    }

    public long countDevis() {
        return devisDAO.count();
    }

    public void delete(int id) {
        devisDAO.deleteById(id);
    }
}

