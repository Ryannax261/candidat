package com.example.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.model.DemandeStatut;
import com.example.model.Statut;

@Repository
public interface DemandeStatutDAO extends JpaRepository<DemandeStatut, Integer> {
    void deleteByStatut(Statut statut);
}
