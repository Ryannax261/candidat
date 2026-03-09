package com.example.dao;

import com.example.model.Matiere;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MatiereDAO extends JpaRepository<Matiere, Integer> {
}
