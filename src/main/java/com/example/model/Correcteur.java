package com.example.model;

import jakarta.persistence.*;

@Entity
@Table(name = "t_correcteur")
public class Correcteur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "nom", nullable = false)
    private String nom;

    @Column(name = "prenom", nullable = false)
    private String prenom;

    @Column(name = "numtel", nullable = false, unique = true)
    private String numtel;

    public Correcteur() {
    }

    public Correcteur(String nom, String prenom, String numtel) {
        this.nom = nom;
        this.prenom = prenom;
        this.numtel = numtel;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getNumtel() {
        return numtel;
    }

    public void setNumtel(String numtel) {
        this.numtel = numtel;
    }
}
