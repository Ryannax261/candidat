package com.example.service;

import com.example.dao.CandidatDAO;
import com.example.model.Candidat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CandidatService {

    @Autowired
    private CandidatDAO candidatDAO;

    public List<Candidat> getAllCandidats() {
        return candidatDAO.findAll();
    }

    public Candidat getCandidatById(Integer id) {
        return candidatDAO.findById(id).orElse(null);
    }

    public void saveCandidat(Candidat candidat) {
        candidatDAO.save(candidat);
    }

    public void deleteCandidatById(Integer id) {
        candidatDAO.deleteById(id);
    }
}
