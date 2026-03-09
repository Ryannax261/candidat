package com.example.dao;

import com.example.model.Candidat;
import com.example.model.Matiere;
import com.example.model.Note;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NoteDAO extends JpaRepository<Note, Integer> {
    List<Note> findByCandidatAndMatiere(Candidat candidatId, Matiere matiereId);
}
