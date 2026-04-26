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

    @Column(name = "ecart_total")
    private String ecartTotal;

    @Column(name = "ecart_ouvre")
    private String ecartOuvre;

    public DevisStatut() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Devis getDevis() { return devis; }
    public void setDevis(Devis devis) { this.devis = devis; }

    public StatutDevis getStatutDevis() { return statutDevis; }
    public void setStatutDevis(StatutDevis statutDevis) { this.statutDevis = statutDevis; }

    public LocalDateTime getDateStatut() { return dateStatut; }
    public void setDateStatut(LocalDateTime dateStatut) { this.dateStatut = dateStatut; }

    public String getEcartTotal() { return ecartTotal; }
    public void setEcartTotal(String ecartTotal) { this.ecartTotal = ecartTotal; }

    public String getEcartOuvre() { return ecartOuvre; }
    public void setEcartOuvre(String ecartOuvre) { this.ecartOuvre = ecartOuvre; }
}
