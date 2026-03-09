package com.example.model;

import jakarta.persistence.*;

@Entity
@Table(name = "t_parametre")
public class Parametre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_matiere", nullable = false)
    private Matiere matiere;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_resolution", nullable = false)
    private Resolution resolution;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_operateur", nullable = false)
    private Operateur operateur;

    @Column(name = "seuil", nullable = false)
    private Double seuil;

    public Parametre() {
    }

    public Parametre(Matiere matiere, Resolution resolution, Operateur operateur, Double seuil) {
        this.matiere = matiere;
        this.resolution = resolution;
        this.operateur = operateur;
        this.seuil = seuil;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Matiere getMatiere() {
        return matiere;
    }

    public void setMatiere(Matiere matiere) {
        this.matiere = matiere;
    }

    public Resolution getResolution() {
        return resolution;
    }

    public void setResolution(Resolution resolution) {
        this.resolution = resolution;
    }

    public Operateur getOperateur() {
        return operateur;
    }

    public void setOperateur(Operateur operateur) {
        this.operateur = operateur;
    }

    public Double getSeuil() {
        return seuil;
    }

    public void setSeuil(Double seuil) {
        this.seuil = seuil;
    }
}
