package com.example.model;

import jakarta.persistence.*;

@Entity
@Table(name = "t_note")
public class Note {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_candidat", nullable = false)
    private Candidat candidat;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_matiere", nullable = false)
    private Matiere matiere;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_correcteur", nullable = false)
    private Correcteur correcteur;

    @Column(name = "note", nullable = false)
    private Double note;

    public Note() {
    }

    public Note(Candidat candidat, Matiere matiere, Correcteur correcteur, Double note) {
        this.candidat = candidat;
        this.matiere = matiere;
        this.correcteur = correcteur;
        this.note = note;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Candidat getCandidat() {
        return candidat;
    }

    public void setCandidat(Candidat candidat) {
        this.candidat = candidat;
    }

    public Matiere getMatiere() {
        return matiere;
    }

    public void setMatiere(Matiere matiere) {
        this.matiere = matiere;
    }

    public Correcteur getCorrecteur() {
        return correcteur;
    }

    public void setCorrecteur(Correcteur correcteur) {
        this.correcteur = correcteur;
    }

    public Double getNote() {
        return note;
    }

    public void setNote(Double note) {
        this.note = note;
    }
}
