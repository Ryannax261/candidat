package com.example.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.example.dao.StatutDevisDAO;
import com.example.model.StatutDevis;
import com.example.model.TypeDevis;

@Service
public class StatutDevisService {

    private final StatutDevisDAO statutDevisDAO;

    public StatutDevisService(StatutDevisDAO statutDevisDAO) {
        this.statutDevisDAO = statutDevisDAO;
    }

    public List<StatutDevis> getAll() {
        return statutDevisDAO.findAll();
    }

    public StatutDevis save(StatutDevis statutDevis) {
        return statutDevisDAO.save(statutDevis);
    }

    public StatutDevis getById(int id) {
        return statutDevisDAO.findById(id).orElse(null);
    }

    public void delete(int id) {
        statutDevisDAO.deleteById(id);
    }

    /** Retourne uniquement les statuts correspondant au type de devis donné */
    public List<StatutDevis> getByTypeDevis(TypeDevis typeDevis) {
        return statutDevisDAO.findByTypeDevisOrderByIdAsc(typeDevis);
    }
}
