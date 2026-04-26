import java.time.LocalDateTime;

public class TestTime {
    public static void main(String[] args) {
        // Mocking logic of TimeService
        LocalDateTime start = LocalDateTime.of(2026, 4, 17, 16, 0); // Vendredi 16h
        LocalDateTime end = LocalDateTime.of(2026, 4, 20, 10, 0);   // Lundi 10h
        
        // Expected Work: 1h (vendredi) + 2h (lundi) = 3h.
        
        System.out.println("Start: " + start);
        System.out.println("End: " + end);
        
        // Simulating the loop
        long totalMinutes = 0;
        LocalDateTime current = start;
        while (current.isBefore(end)) {
            if (current.getDayOfWeek().getValue() >= 6) { // SAT, SUN
                current = current.plusDays(1).withHour(8).withMinute(0);
                continue;
            }
            if (current.getHour() < 8) {
                current = current.withHour(8).withMinute(0);
                continue;
            }
            if (current.getHour() >= 17) {
                current = current.plusDays(1).withHour(8).withMinute(0);
                continue;
            }

            LocalDateTime endOfWorkDay = current.withHour(17).withMinute(0);
            LocalDateTime actualEnd = end.isBefore(endOfWorkDay) ? end : endOfWorkDay;

            totalMinutes += java.time.Duration.between(current, actualEnd).toMinutes();
            current = current.plusDays(1).withHour(8).withMinute(0);
        }
        
        System.out.println("Total Minutes Work: " + totalMinutes);
        System.out.println("Total Hours Work: " + (totalMinutes / 60.0));
    }
}
