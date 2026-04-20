package com.example.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.model.TypeDevis;

@Repository
public interface TypeDevisDAO extends JpaRepository<TypeDevis, Integer> {
}
