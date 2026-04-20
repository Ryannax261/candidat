package com.example.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "t_devis")
public class Devis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "demande_id", nullable = false)
    private Demande demande;

    @ManyToOne
    @JoinColumn(name = "type_devis_id", nullable = false)
    private TypeDevis typeDevis;

    @Column(name = "date_devis", insertable = false, updatable = false)
    private LocalDateTime dateDevis;

    @Transient
    private double montantTotal;

    @PostLoad
    public void calculateTotal() {
        if (details != null) {
            this.montantTotal = details.stream().mapToDouble(DetailDevis::getPrix).sum();
        }
    }

    @OneToMany(mappedBy = "devis", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<DetailDevis> details;

    @OneToMany(mappedBy = "devis", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @OrderBy("dateStatut DESC")
    private List<DevisStatut> devisStatuts = new ArrayList<>();

    public DevisStatut getDernierStatut() {
        if (devisStatuts == null || devisStatuts.isEmpty()) return null;
        return devisStatuts.get(0);
    }

    public Devis() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Demande getDemande() { return demande; }
    public void setDemande(Demande demande) { this.demande = demande; }
    public TypeDevis getTypeDevis() { return typeDevis; }
    public void setTypeDevis(TypeDevis typeDevis) { this.typeDevis = typeDevis; }
    public LocalDateTime getDateDevis() { return dateDevis; }
    public void setDateDevis(LocalDateTime dateDevis) { this.dateDevis = dateDevis; }
    public double getMontantTotal() { return montantTotal; }
    public void setMontantTotal(double montantTotal) { this.montantTotal = montantTotal; }
    public List<DetailDevis> getDetails() { return details; }
    public void setDetails(List<DetailDevis> details) { this.details = details; }

    public List<DevisStatut> getDevisStatuts() { return devisStatuts; }
    public void setDevisStatuts(List<DevisStatut> devisStatuts) { this.devisStatuts = devisStatuts; }
}
