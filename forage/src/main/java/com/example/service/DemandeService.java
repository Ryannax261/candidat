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
    private final TimeService timeService;

    public DemandeService(DemandeDAO demandeDAO, DemandeStatutDAO demandeStatutDAO, StatutDAO statutDAO, TimeService timeService) {
        this.demandeDAO = demandeDAO;
        this.demandeStatutDAO = demandeStatutDAO;
        this.statutDAO = statutDAO;
        this.timeService = timeService;
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
            ds.setEcartTotal("-");
            ds.setEcartOuvre("-");
            demandeStatutDAO.save(ds);

            return de;
        }

    public Demande update(Demande demande, int statutId) {
        return update(demande, statutId, null, null);
    }

    public Demande update(Demande demande, int statutId, String observation) {
        return update(demande, statutId, observation, null);
    }

    public Demande update(Demande demande, int statutId, String observation, java.time.LocalDateTime dateStatut) {
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
                if (dateStatut != null) {
                    last.setDateStatut(dateStatut);
                } else {
                    last.setDateStatut(java.time.LocalDateTime.now());
                }

                // Recalcul des écarts par rapport au statut précédent
                List<DemandeStatut> history = updated.getDemandeStatuts();
                if (history.size() > 1) {
                    // history.get(0) est 'last' car trié par dateStatut DESC
                    DemandeStatut previous = history.get(1);
                    last.setEcartTotal(timeService.formatDuration(previous.getDateStatut(), last.getDateStatut()));
                    last.setEcartOuvre(timeService.formatWorkDuration(previous.getDateStatut(), last.getDateStatut()));
                } else {
                    last.setEcartTotal("-");
                    last.setEcartOuvre("-");
                }

                demandeStatutDAO.save(last);
                return updated;
            }
        }

        // Création d'une nouvelle ligne dans l'historique
        DemandeStatut ds = new DemandeStatut();
        ds.setDemande(updated);
        ds.setStatut(statut);
        ds.setObservation(observation);
        if (dateStatut != null) {
            ds.setDateStatut(dateStatut);
        }
        
        // Calcul des écarts par rapport au statut précédent
        if (last != null) {
            ds.setEcartTotal(timeService.formatDuration(last.getDateStatut(), ds.getDateStatut()));
            ds.setEcartOuvre(timeService.formatWorkDuration(last.getDateStatut(), ds.getDateStatut()));
        } else {
            ds.setEcartTotal("-");
            ds.setEcartOuvre("-");
        }
        
        demandeStatutDAO.save(ds);

        return updated;
    }

    public void delete(int id) {
        demandeDAO.deleteById(id);
    }

    public DemandeStatut getStatusEntryById(int id) {
        return demandeStatutDAO.findById(id).orElseThrow(() -> new RuntimeException("Entrée d'historique introuvable : " + id));
    }

    @org.springframework.transaction.annotation.Transactional
    public DemandeStatut updateStatusEntry(int statusEntryId, int statutId, String observation, java.time.LocalDateTime dateStatut) {
        DemandeStatut current = getStatusEntryById(statusEntryId);
        Statut newStatut = statutDAO.findById(statutId).orElseThrow(() -> new RuntimeException("Statut introuvable"));
        
        current.setStatut(newStatut);
        current.setObservation(observation);
        current.setDateStatut(dateStatut);
        demandeStatutDAO.save(current);
        
        // Recalculer l'historique complet pour cette demande pour maintenir la cohérence des durées
        Demande demande = current.getDemande();
        List<DemandeStatut> history = demandeStatutDAO.findByDemandeIdOrderByDateStatutAsc(demande.getId());
            
        for (int i = 0; i < history.size(); i++) {
            DemandeStatut ds = history.get(i);
            if (i == 0) {
                ds.setEcartTotal("-");
                ds.setEcartOuvre("-");
            } else {
                DemandeStatut prev = history.get(i - 1);
                ds.setEcartTotal(timeService.formatDuration(prev.getDateStatut(), ds.getDateStatut()));
                ds.setEcartOuvre(timeService.formatWorkDuration(prev.getDateStatut(), ds.getDateStatut()));
            }
            demandeStatutDAO.save(ds);
        }
        
        return current;
    }
}