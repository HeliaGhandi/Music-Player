import java.lang.reflect.Array;
import java.time.LocalTime;
import java.util.Arrays;

class Main{
    public static void main(String[] args) {
        LocalTime time = LocalTime.ofSecondOfDay(120);
        //LocalTime time2 = LocalTime.of(120);

        System.out.println(time.getMinute());
        System.out.println(time);
        sum();

    }
    public static void sum(int... a){
        System.out.println(Arrays.toString(a));
    }

}