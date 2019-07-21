import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;

public class MyClass {
    public static void main(String args[]) {
        Instant instant = Instant.now();
        System.out.println("Instant: " + instant);
        LocalDateTime ldt = LocalDateTime.ofInstant(instant, ZoneOffset.UTC);
        System.out.println("Day: " + ldt.getDayOfWeek());
    }
}
