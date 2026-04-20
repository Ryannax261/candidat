package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.dao.StatutDAO;
import com.example.model.Statut;

@Service
public class StatutService {
    private final StatutDAO StatutDAO;

    public StatutService(StatutDAO StatutDAO) {
        this.StatutDAO = StatutDAO;
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

    public void delete(int id) {
        StatutDAO.deleteById(id);
    }
}
