package com.example.dao;

import com.example.model.Operateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OperateurDAO extends JpaRepository<Operateur, Integer> {
}
