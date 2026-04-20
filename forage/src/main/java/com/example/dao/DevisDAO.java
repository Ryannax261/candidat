package com.example.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.model.Devis;

@Repository
public interface DevisDAO extends JpaRepository<Devis, Integer> {
}
