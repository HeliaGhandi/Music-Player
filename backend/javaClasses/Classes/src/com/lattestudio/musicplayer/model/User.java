package com.lattestudio.musicplayer.model;
/*
    saat 9 , 22 ordibehesht , miz tabar shorooe proje :)
 */

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since 0.0.1
 */
@SuppressWarnings("unused")
public class User  implements Serializable {
    //Properties :
    private String username;
    private String firstname ;
    private String lastname;
    private String email;
    private String password;
    private String profilePictureURL;

    private boolean isVerified = false;
    private boolean canShareSongWithUser = true;
    private boolean is2faVerified = false;
    private boolean isAccountPrivate = false;

    private Set<Music> musics;
    private List<Playlist> playlists;
    private List<Music> likedSongs;
    private List<Playlist> likedPlayLists;
    private List<Music> queue;
    private List<User> followers;
    private List<User> followings;
    private List<Music> playedSongs; // اونایی که اینبار گوش داده
    //TO-DO playedSongs
    private List<Genre> likedGenres;

    private Theme theme;

    private LocalDateTime lastUsernameChangeTime ;
    private final LocalDateTime joinedDate ;
    private LocalTime totalListeningDuration ;


    private static final int MINIMUM_USERNAME_LENGTH = 4 ;
    private static final  String DEFAULT_PASSWORD = "1234";
    private static final String INVALID_USERNAME = "Invalid Username" ;
    private static final String INVALID_PASSWORD = "Invalid Password" ;
    private static final String INVALID_EMAIL = "Invalid Email" ;


    //private File log ;

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", firstname='" + firstname + '\'' +
                ", lastname='" + lastname + '\'' +
                ", email='" + email + '\'' +
                '}';
    }


    //Constructors :

    private User(){
        this.firstname = "FIRST NAME NOT SET YET";
        this.lastname = "LAST NAME NOT SET YET";
        this.profilePictureURL = "PROFILE PICTURE NOT SET YET";
        this.theme = Theme.LIGHT;
        this.joinedDate = LocalDateTime.now();
        this.lastUsernameChangeTime = LocalDateTime.now();
        this.totalListeningDuration = LocalTime.of(0,0,0);

        this.playlists = new ArrayList<>();
        this.likedSongs = new ArrayList<>();
        this.likedPlayLists = new ArrayList<>();
        this.followers = new ArrayList<>();
        this.followings = new ArrayList<>();
        this.likedGenres = new ArrayList<>();
        this.playedSongs = new LinkedList<>();
        this.queue = new LinkedList<>();
        this.musics = new TreeSet<>();
    }

    /**
     *
     * @param username (see isUsernameValid)
     * @param password must be more than 8 chars - lowercase and uppercase chars and also letters (see isPasswordValid)
     * @param email the domain must contain 2 or more letters (see isEmailValid)
     */
    public User(String username , String password , String email){
        this();
        if (!isUsernameValid(username)) {
            throw new IllegalArgumentException(INVALID_USERNAME);
        }
        this.username = username ;

        if (!isPasswordValid(password)) {
            throw new IllegalArgumentException(INVALID_PASSWORD);
        }
        if (!isEmailValid(email)) {
            throw new IllegalArgumentException(INVALID_EMAIL);
        }
        //LOGGGGGG


        this.password = password ;
        this.email = email ;
    }
    /**
     *
     * @param username (see isUsernameValid)
     * @param password must be more than 8 chars - lowercase and uppercase chars and also letters (see isPasswordValid)
     */
    public User(String username , String password){
        this();
        if (!isUsernameValid(username)) {
            throw new IllegalArgumentException(INVALID_USERNAME);
        }
        if (!isPasswordValid(password)) {
            throw new IllegalArgumentException(INVALID_PASSWORD);
        }
        this.username = username ;
        this.password = password;
        this.email = "NO EMAIL FOUND" ;
    }
    /**
     *
     * @param username (see isUsernameValid)
     */
    public User(String username){
        this();
        if (!isUsernameValid(username)) {
            throw new IllegalArgumentException(INVALID_USERNAME);
        }
        this.username = username ;
        this.password = DEFAULT_PASSWORD;
        this.email = "NO EMAIL FOUND" ;
    }



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

    private boolean isPasswordValid(String password) {
        String passwordPattern = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$"; //mersi az arian seydi
        Pattern pattern = Pattern.compile(passwordPattern);
        Matcher matcher = pattern.matcher(password);
        return (matcher.find() && !password.contains(this.username));
    }

    private boolean isEmailValid(String email){
        String emailPattern = "^(\\w*|\\d*|.*|_*|)@(\\w*|\\d*).([a-zA-Z0-9.]{2,})$" ;
        Pattern pattern = Pattern.compile(emailPattern) ;
        Matcher matcher = pattern.matcher(email);
        return matcher.find();
    }

    private boolean isUsernameValid(String username){ //!name.trim().isEmpty() removes leading white space and then checks
        return (!username.startsWith(".") && username.length() >= MINIMUM_USERNAME_LENGTH && !username.trim().isEmpty());
    }

    public boolean follow(User user) {
        if (user == null || user.isAccountPrivate()) return false;
        else {
            followings.add(user);
            user.getFollowers().add(this);
            return true;
        }
    }

    public boolean unfollow(User user){
        if(user == null || !this.getFollowings().contains(user)) return false;
        else {
            this.getFollowings().remove(user);
            user.getFollowers().remove(this);
            return true;
        }
    }

    public boolean removeFollower(User user){
        if(user == null || !this.getFollowers().contains(user)) return false;
        else{
            this.getFollowers().remove(user);
            user.getFollowings().remove(this);
            return true;
        }
    }

    public boolean addToMusics(Music music){
        if(music == null) return false;
        else {
            musics.add(music);
            return true;
        }
    }

    public boolean removeFromMusics(Music music){
        if(music == null || !musics.contains(music)) return false ;
        else {
            musics.remove(music);
            return true ;
        }
    }

    public boolean likeSong(Music music){
        if(music == null || this.getLikedSongs().contains(music)){
            this.getLikedSongs().remove(music);
            return false;
        } else {
            likedSongs.add(music);
            return true;
        }
    }

    public boolean createPlayList(String name , Music... musics){
        if(name == null ||name.isEmpty()) return false ;
        try{
            Playlist playlist = new Playlist(name , this , musics) ;
            playlists.add(playlist);
            return true;
        }catch (IllegalArgumentException iae){
            return false ;
        }
    }
    public boolean addPlaylist(Playlist playlist){
        if(playlist == null || playlists.contains(playlist)) return false ;
        else {
            playlists.add(playlist);
            return true;
        }
    }
    public boolean deletePlaylist(Playlist playlist){
        if(playlist == null || !playlists.contains(playlist)) return false ;
        else {
            playlists.remove(playlist) ;
            return true ;
        }
    }

    /*
    public downloadMusic(com.lattestudio.musicplayer.model.Music music){
    //TO-DO
    // hamchenin hamin baraye playlist
    }
     */

    public boolean comment(Music music , String message){
        if(music == null || message.isEmpty()){
            return false ;
        }else {
            Set<User> usersThatCommentedOnThisMusic = music.getComments().keySet();
            List<String> comments ;
            if(usersThatCommentedOnThisMusic.contains(this)){
                comments = music.getComments().get(this);
            }else{
                comments = new ArrayList<>() ;
            }
            comments.add(message);
            music.getComments().put(this , comments) ;
            return true ;
        }
    } // ghavi

    public boolean likePlaylist(Playlist playlist){
        if(playlist == null) return false;
        if(this.getLikedPlayLists().contains(playlist)){
            this.getLikedPlayLists().remove(playlist);
            return false;
        } else {
            this.getLikedPlayLists().add(playlist);
            playlist.setLikeCount(playlist.getLikeCount()+1);
            return true;
        }
    }
    public boolean likeMusic(Music music){
        if(music == null) return false;
        if(this.getLikedSongs().contains(music)){
            this.getLikedSongs().remove(music);
            return false;
        } else {
            this.getLikedSongs().add(music);
            music.setLikedCount(music.getLikedCount()+1);
            return true;
        }
    }

    public boolean likedGenres(List<Genre> genres){
        if(genres== null || genres.isEmpty()) return false ;
        else{
            likedGenres.addAll(genres) ;
            return true ;
        }
    }
    public boolean likedGenres(Genre... genres){
        if(genres.length == 0 ) return false ;
        else{
            likedGenres.addAll(List.of(genres)) ;
            return true ;
        }
    }

    public boolean addToQueue(Music music){
        if(music == null) return false;
        else {
            queue.add(music);
            return true;
        }
    }

    //Equals and HashCode :

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof User user)) return false;
        return Objects.equals(username, user.username) && Objects.equals(email, user.email) && Objects.equals(password, user.password);
    }

    @Override
    public int hashCode() {
        return Objects.hash(username, email, password);
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


    public LocalTime getTotalListeningDuration() {
        return totalListeningDuration;
    }

    public void setTotalListeningDuration(LocalTime totalListeningDuration) {
        this.totalListeningDuration = totalListeningDuration;
    }

    public boolean isAccountPrivate() {
        return isAccountPrivate;
    }

    public void setAccountPrivate(boolean accountPrivate) {
        isAccountPrivate = accountPrivate;
    }

    public List<Playlist> getPlaylists() {
        return playlists;
    }

    public Set<Music> getMusics() {
        return musics;
    }

    public List<Music> getQueue() {
        return queue;
    }

    public List<User> getFollowers() {
        return followers;
    }

    public List<User> getFollowings() {
        return followings;
    }

    public List<Music> getPlayedSongs() {
        return playedSongs;
    }

    public List<Genre> getLikedGenres() {
        return likedGenres;
    }

    public List<Music> getLikedSongs() {
        return likedSongs;
    }

    public List<Playlist> getLikedPlayLists() {
        return likedPlayLists;
    }
}
