package com.example.dao;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.model.DevisStatut;

@Repository
public interface DevisStatutDAO extends JpaRepository<DevisStatut, Integer> {
    List<DevisStatut> findAllByOrderByIdDesc();
    List<DevisStatut> findByDevisDemandeIdOrderByIdDesc(int demandeId);
}
