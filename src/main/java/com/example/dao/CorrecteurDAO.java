package com.example.dao;

import com.example.model.Correcteur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CorrecteurDAO extends JpaRepository<Correcteur, Integer> {
}
