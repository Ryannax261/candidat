package com.example.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "t_demande")
public class Demande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "client_id", nullable = false)
    private Client client;

    @Column(nullable = false)
    private String description;

    @Column(name = "date_demande")
    private LocalDateTime dateDemande = LocalDateTime.now();

    @Column(nullable = false)
    private String district;

    @OneToMany(mappedBy = "demande", fetch = FetchType.EAGER)
    @OrderBy("dateStatut DESC")
    private List<DemandeStatut> demandeStatuts = new ArrayList<>();

    public String getDateDemandeFormatee() {
        if (dateDemande == null) return "";
        return dateDemande.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }

    public DemandeStatut getDernierStatut() {
        if (demandeStatuts == null || demandeStatuts.isEmpty()) return null;
        return demandeStatuts.get(0);
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Client getClient() { return client; }
    public void setClient(Client client) { this.client = client; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDateTime getDateDemande() { return dateDemande; }
    public void setDateDemande(LocalDateTime dateDemande) { this.dateDemande = dateDemande; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public List<DemandeStatut> getDemandeStatuts() { return demandeStatuts; }
    public void setDemandeStatuts(List<DemandeStatut> demandeStatuts) { this.demandeStatuts = demandeStatuts; }
}