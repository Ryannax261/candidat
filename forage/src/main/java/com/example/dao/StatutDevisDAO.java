package com.example.dao;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.model.StatutDevis;
import com.example.model.TypeDevis;

@Repository
public interface StatutDevisDAO extends JpaRepository<StatutDevis, Integer> {
    Optional<StatutDevis> findByNom(String nom);
    List<StatutDevis> findByTypeDevisOrderByIdAsc(TypeDevis typeDevis);
}
