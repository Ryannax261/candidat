package com.example.model;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "t_devis_statut")
public class DevisStatut {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "devis_id", nullable = false)
    private Devis devis;

    @ManyToOne
    @JoinColumn(name = "statut_devis_id", nullable = false)
    private StatutDevis statutDevis;

    @Column(name = "date_statut")
    private LocalDateTime dateStatut = LocalDateTime.now();

    public DevisStatut() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Devis getDevis() { return devis; }
    public void setDevis(Devis devis) { this.devis = devis; }

    public StatutDevis getStatutDevis() { return statutDevis; }
    public void setStatutDevis(StatutDevis statutDevis) { this.statutDevis = statutDevis; }

    public LocalDateTime getDateStatut() { return dateStatut; }
    public void setDateStatut(LocalDateTime dateStatut) { this.dateStatut = dateStatut; }
}
