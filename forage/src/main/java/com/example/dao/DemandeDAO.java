package com.example.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.model.Demande;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public interface DemandeDAO extends JpaRepository<Demande, Integer> {

    List<Demande> findByClientId(int clientId);

    @Query(value = "SELECT * FROM client_demande WHERE id_demande = :id", nativeQuery = true)
    Optional<Map<String, Object>> getInfoFromView(@Param("id") int id);
}
