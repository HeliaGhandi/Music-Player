import java.sql.Time;
import java.time.LocalDateTime;
import java.time.LocalTime;

class Main{
    public static void main(String[] args) {
        LocalTime time = LocalTime.now();
        LocalDateTime ldt = LocalDateTime.now();
        System.out.println(ldt);
    }
}