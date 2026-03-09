package com.example.service;

import com.example.dao.CorrecteurDAO;
import com.example.model.Correcteur;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CorrecteurService {

    @Autowired
    private CorrecteurDAO correcteurDAO;

    public List<Correcteur> getAllCorrecteurs() {
        return correcteurDAO.findAll();
    }

    public Correcteur getCorrecteurById(Integer id) {
        return correcteurDAO.findById(id).orElse(null);
    }

    public void saveCorrecteur(Correcteur correcteur) {
        correcteurDAO.save(correcteur);
    }

    public void deleteCorrecteurById(Integer id) {
        correcteurDAO.deleteById(id);
    }
}
