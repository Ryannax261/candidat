package com.example.dao;

import com.example.model.Candidat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CandidatDAO extends JpaRepository<Candidat, Integer> {
}
