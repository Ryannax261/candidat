package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.dao.TypeDevisDAO;
import com.example.model.TypeDevis;

@Service
public class TypeDevisService {

    private final TypeDevisDAO typeDevisDAO;

    public TypeDevisService(TypeDevisDAO typeDevisDAO) {
        this.typeDevisDAO = typeDevisDAO;
    }

    public List<TypeDevis> getAll() {
        return typeDevisDAO.findAll();
    }

    public TypeDevis save(TypeDevis typeDevis) {
        return typeDevisDAO.save(typeDevis);
    }

    public TypeDevis getById(int id) {
        return typeDevisDAO.findById(id).orElse(null);
    }

    public void delete(int id) {
        typeDevisDAO.deleteById(id);
    }
}
