/*
    saat 9 , 22 ordibehesht , miz tabar shorooe proje :)
 */

import java.sql.Time;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 */
@SuppressWarnings("unused")
public class User {
    //Properties :
    private String username;
    private String firstname;
    private String lastname;
    private String email;
    private String password;
    private String profilePictureURL;

    private boolean isVerified = false;
    private boolean canShareSongWithUser = true;
    private boolean is2faVerified = false;

    private List<Playlist> playlists;
    private List<Music> musics;
    private List<Music> queue ;
    private List<User> follower;
    private List<User> following;
    private List<Music> playedSongs; // اونایی که اینبار گوش داده
    private List<Genre> likedGenres ;

    private Theme theme;

    private LocalDateTime lastUsernameChangeTime ;
    private LocalDateTime joinedDate ;
    private LocalTime totalListeningDuration ;

    //private File log ;



    //Methods :
    public boolean changePassword(String password) {
        // baadan to code dart dorost she
        if(isPasswordValid(password)) {
            setPassword(password);
            return true;
        } else return false;
    }
    public boolean checkPassword(String password){
        if(!isPasswordValid(password)) return false ;
        String correctPassword = null ;
        //BACK END STUFF : get password from server and store it to correctPassword variable ;
        return password.equals(correctPassword) ;
    }

    boolean isPasswordValid(String password) {
        String passwordPattern = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$"; //mersi az arian seydi
        Pattern pattern = Pattern.compile(passwordPattern);
        Matcher matcher = pattern.matcher(password);
        return matcher.find();
    }




    //Default Getter And Setters :


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password){
        this.password = password;
    }

    public String getProfilePictureURL() {
        return profilePictureURL;
    }

    public void setProfilePictureURL(String profilePictureURL) {
        this.profilePictureURL = profilePictureURL;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    public boolean isCanShareSongWithUser() {
        return canShareSongWithUser;
    }

    public void setCanShareSongWithUser(boolean canShareSongWithUser) {
        this.canShareSongWithUser = canShareSongWithUser;
    }

    public boolean isIs2faVerified() {
        return is2faVerified;
    }

    public void setIs2faVerified(boolean is2faVerified) {
        this.is2faVerified = is2faVerified;
    }

    public Theme getTheme() {
        return theme;
    }

    public void setTheme(Theme theme) {
        this.theme = theme;
    }

    public LocalDateTime getLastUsernameChangeTime() {
        return lastUsernameChangeTime;
    }

    public void setLastUsernameChangeTime(LocalDateTime lastUsernameChangeTime) {
        this.lastUsernameChangeTime = lastUsernameChangeTime;
    }

    public LocalDateTime getJoinedDate() {
        return joinedDate;
    }

    public void setJoinedDate(LocalDateTime joinedDate) {
        this.joinedDate = joinedDate;
    }

    public LocalTime getTotalListeningDuration() {
        return totalListeningDuration;
    }

    public void setTotalListeningDuration(LocalTime totalListeningDuration) {
        this.totalListeningDuration = totalListeningDuration;
    }
}
