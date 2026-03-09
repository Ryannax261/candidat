package com.example.service;

import com.example.dao.ParametreDAO;
import com.example.model.Matiere;
import com.example.model.Parametre;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ParametreService {

    @Autowired
    private ParametreDAO parametreDAO;

    public List<Parametre> getAllParametres() {
        return parametreDAO.findAll();
    }

    public Parametre getParametreById(Integer id) {
        return parametreDAO.findById(id).orElse(null);
    }

    public void saveParametre(Parametre parametre) {
        parametreDAO.save(parametre);
    }

    public void deleteParametreById(Integer id) {
        parametreDAO.deleteById(id);
    }
    public List<Parametre> getParametresByMatiere(Matiere matiereId) {
        return parametreDAO.findByMatiere(matiereId);
    }
    public boolean isBonParametre(double diff, Parametre parametre) {
        boolean isBon = false;
        switch(parametre.getOperateur().getOperateur()) {
            case "<":
                if (diff < parametre.getSeuil()) {
                    isBon = true;
                }
                break;

            case ">":
                if (diff > parametre.getSeuil()) {
                    isBon = true;
                }
                break;

            case "=":
                if (diff == parametre.getSeuil()) {
                    isBon = true;
                }
                break;
        }
        return isBon;
    }
    public Parametre getBonParametre(double diff, List<Parametre> parametres) {
        Parametre parametre = new Parametre(); 
        for (Parametre parametre1 : parametres) {
            if (isBonParametre(diff, parametre1)) {
                return parametre1;
            }
        }
        return parametre;
    }
}
