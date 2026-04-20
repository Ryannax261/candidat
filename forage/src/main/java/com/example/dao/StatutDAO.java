package com.example.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.model.Statut;

@Repository
public interface StatutDAO extends JpaRepository<Statut, Integer> {
    Optional<Statut> findByNom(String nom);
}
