package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.StatutDAO;
import com.example.dao.DemandeStatutDAO;
import com.example.model.Statut;

@Service
public class StatutService {
    private final StatutDAO StatutDAO;
    private final DemandeStatutDAO demandeStatutDAO;

    public StatutService(StatutDAO StatutDAO, DemandeStatutDAO demandeStatutDAO) {
        this.StatutDAO = StatutDAO;
        this.demandeStatutDAO = demandeStatutDAO;
    }

    public List<Statut> getAll() {
        return StatutDAO.findAll();
    }

    public Statut save(Statut statut) {
        return StatutDAO.save(statut);
    }

    public Statut getById(int id) {
        return StatutDAO.findById(id).orElse(null);
    }

    @Transactional
    public void delete(int id) {
        Statut statut = StatutDAO.findById(id).orElse(null);
        if (statut != null) {
            demandeStatutDAO.deleteByStatut(statut);
            StatutDAO.delete(statut);
        }
    }
}
