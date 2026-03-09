package com.example.dao;

import com.example.model.Resolution;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ResolutionDAO extends JpaRepository<Resolution, Integer> {
}
