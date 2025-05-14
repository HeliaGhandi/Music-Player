import java.sql.Time;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class Main{
    public static void main(String[] args) {
        LocalTime time = LocalTime.now();
        LocalDateTime ldt = LocalDateTime.now();
        System.out.println(ldt);

        //System.out.println(matcher.find());
        User user = new User("iliya");
    }
}