package com.example.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "t_detail_devis")
public class DetailDevis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "devis_id", nullable = false)
    private Devis devis;

    @Column(nullable = false)
    private String libelle;

    @Column(name = "prix", nullable = false)
    private double prix; 

    @Column(name = "pu", nullable = false)
    private double pu;

    @Column(name = "quantite", nullable = false)
    private int quantite;

    public DetailDevis() {}

    public double getPrix() { return prix; }
    public void setPrix(double prix) { this.prix = prix; }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Devis getDevis() { return devis; }
    public void setDevis(Devis devis) { this.devis = devis; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
    
    public double getPu() { return pu; }
    public void setPu(double pu) { this.pu = pu; }
    public int getQuantite() { return quantite; }
    public void setQuantite(int quantite) { this.quantite = quantite; }
}
