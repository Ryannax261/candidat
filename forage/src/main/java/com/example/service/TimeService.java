package com.example.service;

import org.springframework.stereotype.Service;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.DayOfWeek;

@Service
public class TimeService {

    private static final LocalTime WORK_START = LocalTime.of(8, 0);
    private static final LocalTime WORK_END = LocalTime.of(17, 0);

    /**
     * Calcule la durée totale calendaire (24h/24).
     */
    public String formatDuration(LocalDateTime start, LocalDateTime end) {
        if (start == null || end == null || start.isAfter(end)) return "-";
        
        Duration duration = Duration.between(start, end);
        long days = duration.toDays();
        long hours = duration.toHoursPart();
        long minutes = duration.toMinutesPart();
        
        StringBuilder sb = new StringBuilder();
        if (days > 0) sb.append(days).append("j ");
        if (hours > 0 || days > 0) sb.append(hours).append("h ");
        sb.append(minutes).append("m");
        
        return sb.toString();
    }

    /**
     * Calcule la durée en heures ouvrées (Lun-Ven, 08h-17h).
     */
    public String formatWorkDuration(LocalDateTime start, LocalDateTime end) {
        if (start == null || end == null || start.isAfter(end)) return "-";

        long totalMinutes = 0;
        LocalDateTime current = start;

        // On avance minute par minute ou heure par heure ? 
        // Pour être précis sans trop boucler, on peut itérer par jour.
        
        while (current.isBefore(end)) {
            // Si c'est un jour de week-end, on saute au début du lundi 8h
            if (current.getDayOfWeek() == DayOfWeek.SATURDAY || current.getDayOfWeek() == DayOfWeek.SUNDAY) {
                current = current.plusDays(1).with(WORK_START);
                continue;
            }

            // Si on est avant 8h, on saute à 8h
            if (current.toLocalTime().isBefore(WORK_START)) {
                current = current.with(WORK_START);
                continue;
            }

            // Si on est après 17h, on saute au lendemain 8h
            if (current.toLocalTime().isAfter(WORK_END) || current.toLocalTime().equals(WORK_END)) {
                current = current.plusDays(1).with(WORK_START);
                continue;
            }

            // On calcule la fin de la période travaillée pour CE jour
            LocalDateTime endOfWorkDay = current.with(WORK_END);
            LocalDateTime actualEnd = end.isBefore(endOfWorkDay) ? end : endOfWorkDay;

            // On ajoute les minutes entre current et actualEnd
            totalMinutes += Duration.between(current, actualEnd).toMinutes();

            // On passe au lendemain 8h pour continuer la boucle
            current = current.plusDays(1).with(WORK_START);
        }

        long days = totalMinutes / (9 * 60); // Une journée de travail = 9h
        long hours = (totalMinutes % (9 * 60)) / 60;
        long minutes = totalMinutes % 60;

        StringBuilder sb = new StringBuilder();
        if (days > 0) sb.append(days).append("j ");
        if (hours > 0 || days > 0) sb.append(hours).append("h ");
        sb.append(minutes).append("m");

        return sb.toString();
    }
}
