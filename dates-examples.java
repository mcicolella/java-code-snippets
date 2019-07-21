import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.temporal.ChronoUnit;


public class MyClass {
    public static void main(String args[]) {
        Instant instant = Instant.now();
        System.out.println("Instant: " + instant);
        LocalDateTime ldt = LocalDateTime.ofInstant(instant, ZoneOffset.UTC);
        System.out.println("Day: " + ldt.getDayOfWeek());
        
        Instant start = Instant.parse("2019-07-21T15:24:57.239Z");  
        Instant end = Instant.parse("2019-07-21T15:35:19.385Z");  
        System.out.println(ChronoUnit.MINUTES.between(start, end));

    }
}
