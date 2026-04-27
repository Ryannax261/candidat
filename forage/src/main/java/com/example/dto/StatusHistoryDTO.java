package com.example.dto;

import java.time.LocalDateTime;

public class StatusHistoryDTO {
    private int id;
    private String statutNom;
    private LocalDateTime dateStatut;
    private String observation;
    private String durationTotal;
    private String durationWork;
    private boolean isCurrent;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public StatusHistoryDTO() {}

    
    public String getStatutNom() { return statutNom; }
    public void setStatutNom(String statutNom) { this.statutNom = statutNom; }

    public LocalDateTime getDateStatut() { return dateStatut; }
    public void setDateStatut(LocalDateTime dateStatut) { this.dateStatut = dateStatut; }

    public String getObservation() { return observation; }
    public void setObservation(String observation) { this.observation = observation; }

    public String getDurationTotal() { return durationTotal; }
    public void setDurationTotal(String durationTotal) { this.durationTotal = durationTotal; }

    public String getDurationWork() { return durationWork; }
    public void setDurationWork(String durationWork) { this.durationWork = durationWork; }

    public boolean isCurrent() { return isCurrent; }
    public void setCurrent(boolean current) { isCurrent = current; }
    
    public String getDateStatutFormatee() {
        if (dateStatut == null) return "";
        return dateStatut.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }
}
