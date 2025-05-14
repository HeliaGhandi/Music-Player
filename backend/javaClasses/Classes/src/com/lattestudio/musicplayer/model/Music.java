package com.lattestudio.musicplayer.model;

// sarde ;) (daneshkade jeloye namaz khoone neeshastim:) )
//hanooz sarde
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;
/**
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since 0.0.3
 */
@SuppressWarnings("unused")
public class Music {
    //Properties :
    private String name ;
    private String icon ;
    private String QRCode ;
    private String lyrics ; //change to a file if possible later


    private boolean isPaused = true;

    private LocalTime duration ;
    private final LocalDateTime dateSongAddedToDataBase ; // va

    private int likedCount = 0 ;


    private List<Genre> genres ;
    private List<User> artists ;

    private Map<User,List<String>> comments ;

    private static final String INVALID_NAME = "Invalid Name" ;
    private static final String INVALID_DURATION = "Invalid Duration" ;
    private static final int HOUR_TO_MINUTES_COEFFICIENT = 60 ;
    private static final int MINUTES_TO_SECONDS_COEFFICIENT = 60 ;
    private static final int HOUR_TO_SECONDS_COEFFICIENT = 60 * 60 ;




    //Constructors :

    private Music() {
        this.name = "NAME NOT SET!";
        this.icon = "ICON NOT SET YET!";
        this.QRCode = "QR Code NOT SET YET";
        this.lyrics = "LYRICS NOT SET YET";

        this.duration = LocalTime.of(0, 0, 0);

        this.genres = new ArrayList<>();
        this.artists = new ArrayList<>();
        this.comments = new HashMap<>();

        this.dateSongAddedToDataBase = LocalDateTime.now();
    }
    public Music(String name , LocalTime duration){
        this() ;
        if(!isMusicNameValid(name)){
            throw new IllegalArgumentException(INVALID_NAME) ;
        }
        if(duration == null || ( duration.getHour() == 0 && duration.getMinute() == 0 && duration.getSecond() == 0  )){
            throw new IllegalArgumentException(INVALID_DURATION) ;
        }
        this.name = name ;
        this.duration = duration ;
    }
    public Music(String name , int hour , int minutes , int seconds){
        this();
        if(!isMusicNameValid(name)){
            throw new IllegalArgumentException(INVALID_NAME) ;
        }
        if(minutes >= 60 || seconds >= 60){
            throw new IllegalArgumentException(INVALID_DURATION) ;
        }
        this.name = name ;
        this.duration = LocalTime.of(hour , minutes , seconds) ;
    }
    public Music(String name , int minutes){
        this();
        if(!isMusicNameValid(name)){
            throw new IllegalArgumentException(INVALID_NAME) ;
        }
        if(minutes < 0){
            throw new IllegalArgumentException(INVALID_DURATION) ;
        }
        this.name = name ;
        this.duration = LocalTime.ofSecondOfDay(((long)minutes * (long)HOUR_TO_MINUTES_COEFFICIENT)) ;
    }
    public Music(String name){
        this();
        if(!isMusicNameValid(name)){
            throw new IllegalArgumentException(INVALID_NAME) ;
        }
        this.duration = LocalTime.of(0,0,0);
    }
    public Music(String name , User... artists){
        this(name);
        this.artists = new ArrayList<>(List.of(artists));
    }
    public Music(String name , int minutes , User... artists){
        this(name , minutes);
        this.artists = new ArrayList<>(List.of(artists));
    }
    public Music(String name , int hour , int minutes , int seconds , User... artists) {
        this(name , hour , minutes , seconds);
        this.artists = new ArrayList<>(List.of(artists));
    }
    public Music(String name , LocalTime duration , User... artists) {
        this(name , duration);
        this.artists = new ArrayList<>(List.of(artists));
    }

    //Methods :

    public boolean isMusicNameValid(String name){ //!name.trim().isEmpty() removes leading white space and then checks
        return (!name.isEmpty() && !name.trim().isEmpty()) ;
    }
    public boolean play(){
        if(!isPaused) return false ;
        else {
            isPaused = false ;
            return true ;
        }
    }

    public boolean pause(){
        if(isPaused) return false ;
        else {
            isPaused = true ;
            return true ;
        }
    }
    public void addGenres(Genre... genres){
        this.genres.addAll(List.of(genres));
    }

    //Equals and HashCode :

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Music music)) return false;
        return likedCount == music.likedCount && Objects.equals(name, music.name) && Objects.equals(duration, music.duration) && Objects.equals(genres, music.genres) && Objects.equals(artists, music.artists);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, duration, likedCount, genres, artists);
    }


    //Default Getter And Setters :

    public Map<User, List<String>> getComments() {
        return comments;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getQRCode() {
        return QRCode;
    }

    public void setQRCode(String QRCode) {
        this.QRCode = QRCode;
    }

    public String getLyrics() {
        return lyrics;
    }

    public void setLyrics(String lyrics) {
        this.lyrics = lyrics;
    }

    public boolean isPaused() {
        return isPaused;
    }

    public void setPaused(boolean paused) {
        isPaused = paused;
    }

    public LocalTime getDuration() {
        return duration;
    }

    public void setDuration(LocalTime duration) {
        this.duration = duration;
    }

    public int getLikedCount() {
        return likedCount;
    }

    public void setLikedCount(int likedCount) {
        this.likedCount = likedCount;
    }

    public List<Genre> getGenres() {
        return genres;
    }

    public List<User> getArtists() {
        return artists;
    }

}
