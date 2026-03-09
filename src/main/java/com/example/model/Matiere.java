package com.example.model;

import jakarta.persistence.*;

@Entity
@Table(name = "t_matiere")
public class Matiere {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "nom", nullable = false, unique = true)
    private String nom;

    @Column(name = "coefficient", nullable = false)
    private Integer coefficient;

    public Matiere() {
    }

    public Matiere(String nom, Integer coefficient) {
        this.nom = nom;
        this.coefficient = coefficient;
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

    public Integer getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(Integer coefficient) {
        this.coefficient = coefficient;
    }
}
