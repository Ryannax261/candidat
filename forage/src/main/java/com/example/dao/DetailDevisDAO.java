package com.example.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import com.example.model.DetailDevis;
import java.util.List;

public interface DetailDevisDAO extends JpaRepository<DetailDevis, Integer> {
    List<DetailDevis> findByDevisId(int devisId);

    @Query(value = "SELECT total_ca FROM v_chiffre_affaire", nativeQuery = true)
    Double getTotalTurnover();
}
