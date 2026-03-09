package com.example.dao;

import com.example.model.Matiere;
import com.example.model.Parametre;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ParametreDAO extends JpaRepository<Parametre, Integer> {
    List<Parametre> findByMatiere(Matiere matiereId);
}
