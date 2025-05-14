import java.time.LocalTime;

class Main{
    public static void main(String[] args) {
        LocalTime time = LocalTime.ofSecondOfDay(120);
        //LocalTime time2 = LocalTime.of(120);

        System.out.println(time.getMinute());
        System.out.println(time);

    }
}