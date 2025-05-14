/**
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since 0.0.3
 */
// sarde ;) (daneshkade jeloye namaz khoone neeshastim:) )
import java.sql.Time;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@SuppressWarnings("unused")
public class Music {
    //Properties :
    private String name ;
    private String icon ;
    private String QRCode ;
    private String lyrics ; //change to a file if possible later


    private boolean isPaused = true;

    private LocalTime duration ;

    private int likedCount = 0 ;

    private List<Genre> genreList ;
    private List<User> Artists ;

    private Map<User,List<String>> comments ;







    //Constructors :




    //Methods :


    //Equals and HashCode :



    //Default Getter And Setters :

    public Map<User, List<String>> getComments() {
        return comments;
    }

}
