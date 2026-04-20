package com.example.model;

import jakarta.persistence.*;

@Entity
@Table(name = "t_statut_devis")
public class StatutDevis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String nom;

    @ManyToOne
    @JoinColumn(name = "type_devis_id", nullable = true)
    private TypeDevis typeDevis;

    public StatutDevis() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public TypeDevis getTypeDevis() { return typeDevis; }
    public void setTypeDevis(TypeDevis typeDevis) { this.typeDevis = typeDevis; }
}
