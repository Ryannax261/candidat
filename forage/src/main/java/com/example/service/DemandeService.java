package com.example.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.example.dao.DemandeDAO;
import com.example.dao.DemandeStatutDAO;
import com.example.dao.StatutDAO;
import com.example.model.Demande;
import com.example.model.DemandeStatut;
import com.example.model.Statut;

@Service
public class DemandeService {

    private final DemandeDAO demandeDAO;
    private final DemandeStatutDAO demandeStatutDAO;
    private final StatutDAO statutDAO;

    public DemandeService(DemandeDAO demandeDAO, DemandeStatutDAO demandeStatutDAO, StatutDAO statutDAO) {
        this.demandeDAO = demandeDAO;
        this.demandeStatutDAO = demandeStatutDAO;
        this.statutDAO = statutDAO;
    }

    public List<Demande> getAll() {
        return demandeDAO.findAll();
    }

    public List<Demande> getByStatut(int statutId) {
        return demandeDAO.findAll().stream()
            .filter(d -> d.getDernierStatut() != null && d.getDernierStatut().getStatut().getId() == statutId)
            .collect(Collectors.toList());
    }

    public List<Demande> getByClient(int clientId) {
        return demandeDAO.findByClientId(clientId);
    }

    public Map<Statut, Long> getDemandeCountsByStatut() {
        List<Statut> allStatuts = statutDAO.findAll();
        List<Demande> allDemandes = demandeDAO.findAll();

        Map<Integer, Long> countsMap = allDemandes.stream()
            .filter(d -> d.getDernierStatut() != null)
            .collect(Collectors.groupingBy(d -> d.getDernierStatut().getStatut().getId(), Collectors.counting()));

        Map<Statut, Long> result = new HashMap<>();
        for (Statut s : allStatuts) {
            result.put(s, countsMap.getOrDefault(s.getId(), 0L));
        }
        return result;
    }

    public Demande getById(int id) {
        return demandeDAO.findById(id).orElse(null);
    }

    public java.util.Map<String, Object> getInfoDemande(int id) {
        return demandeDAO.getInfoFromView(id).orElse(null);
    }

    public Demande creer(Demande demande) {
            Demande de = demandeDAO.save(demande);
            Statut statut = statutDAO.findByNom("Creer")
                .orElseThrow(() -> new RuntimeException("Statut 'Creer' introuvable en base"));

            DemandeStatut ds = new DemandeStatut();
            ds.setDemande(de);
            ds.setStatut(statut);
            demandeStatutDAO.save(ds);

            return de;
        }

    public Demande update(Demande demande, int statutId) {
        return update(demande, statutId, null);
    }

    public Demande update(Demande demande, int statutId, String observation) {
        Demande updated = demandeDAO.save(demande);

        Statut statut = statutDAO.findById(statutId)
            .orElseThrow(() -> new RuntimeException("Statut introuvable : " + statutId));

        DemandeStatut last = updated.getDernierStatut();

        if (last != null) {
            int lastId = last.getStatut().getId();

            // Règle de progression linéaire
            if (statutId < lastId) {
                // Exception : Suspendu (4) -> En cours (3) est autorisé
                if (!(lastId == 4 && statutId == 3)) {
                    throw new RuntimeException("Mouvement de statut invalide (progression linéaire requise sauf pour Suspendu -> En cours).");
                }
                // Si c'est l'exception, on continue vers la création d'une nouvelle ligne
            } else if (statutId == lastId) {
                // Même statut : on met à jour la ligne existante
                last.setObservation(observation);
                last.setDateStatut(java.time.LocalDateTime.now());
                demandeStatutDAO.save(last);
                return updated;
            }
        }

        // Création d'une nouvelle ligne dans l'historique
        DemandeStatut ds = new DemandeStatut();
        ds.setDemande(updated);
        ds.setStatut(statut);
        ds.setObservation(observation);
        demandeStatutDAO.save(ds);

        return updated;
    }

    public void delete(int id) {
        demandeDAO.deleteById(id);
    }
}