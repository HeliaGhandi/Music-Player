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
 * @since 0.0.1
 */
@SuppressWarnings("unused")
public class User {
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
    private List<Genre> likedGenres;

    private Theme theme;

    private LocalDateTime lastUsernameChangeTime ;
    private LocalDateTime joinedDate ;
    private LocalTime totalListeningDuration ;


    private final int MINIMUM_USERNAME_LENGTH = 4 ;
    private final String DEFAULT_PASSWORD = "1234";
    //private File log ;


    //Constructors
    private User(){
        firstname = "NO FIRST NAME FOUND!" ;
        lastname = "NO LAST NAME FOUND!" ;
        profilePictureURL = "NO PROFILE PICTURE FOUND!" ;

        theme = Theme.LIGHT ;
        joinedDate = LocalDateTime.now();
        lastUsernameChangeTime = LocalDateTime.now();
        totalListeningDuration = LocalTime.of(0,0,0);

        playlists = new ArrayList<>();
        likedSongs = new ArrayList<>();
        likedPlayLists = new ArrayList<>();
        followers = new ArrayList<>();
        followings = new ArrayList<>();
        likedGenres = new ArrayList<>();
        playedSongs = new LinkedList<>();
        queue = new LinkedList<>();
        musics = new TreeSet<>();
    }
    public User(String username , String password , String email){
        this();
        if (!isUsernameValid(username)) {
            throw new IllegalArgumentException("Invalid Username");
        }
        if (!isPasswordValid(password)) {
            throw new IllegalArgumentException("Invalid Password");
        }
        if (!isEmailValid(email)) {
            throw new IllegalArgumentException("Invalid Email");
        }
        //LOGGGGGG

        this.username = username ;
        this.password = password ;
        this.email = email ;
    }
    protected User(String username , String password){
        this();
        if (!isUsernameValid(username)) {
            throw new IllegalArgumentException("Invalid Username");
        }
        if (!isPasswordValid(password)) {
            throw new IllegalArgumentException("Invalid Password");
        }
        this.username = username ;
        this.password = password;
        this.email = "NO EMAIL FOUND" ;
    }
    protected User(String username){
        this();
        if (!isUsernameValid(username)) {
            throw new IllegalArgumentException("Invalid Username");
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
        String emailPattern = "^(\\w*|\\d*|.*|_*|)@(\\w*|\\d*).(\\w{2,})$" ;
        Pattern pattern = Pattern.compile(emailPattern) ;
        Matcher matcher = pattern.matcher(email);
        return matcher.find();
    }

    private boolean isUsernameValid(String username){
        return (!username.startsWith(".") && username.length() >= MINIMUM_USERNAME_LENGTH);
    }

    public boolean follow(User user) {
        if (user.isAccountPrivate()) return false;
        else {
            followings.add(user);
            user.getFollowers().add(this);
            return true;
        }
    }

    public boolean unfollow(User user){
        if(!this.getFollowings().contains(user)) return false;
        else {
            this.getFollowings().remove(user);
            user.getFollowers().remove(this);
            return true;
        }
    }

    public boolean removeFollower(User user){
        if(!this.getFollowers().contains(user)) return false;
        else{
            this.getFollowers().remove(user);
            user.getFollowings().remove(user);
            return true;
        }
    }

    public void addToMusics(Music music){
        musics.add(music);
    }

    public void removeFromMusics(Music music){
        musics.remove(music);
    }

    public boolean likeSong(Music music){
        if(this.getLikedSongs().contains(music)){
            this.getLikedSongs().remove(music);
            return false;
        } else {
            likedSongs.add(music);
            return true;
        }
    }

    /*public boolean createPlayList(){
    }*/

    public boolean likePlayList(Playlist playlist){
        if(this.getLikedPlayLists().contains(playlist)){
            this.getLikedPlayLists().remove(playlist);
            return false;
        } else {
            this.getLikedPlayLists().add(playlist);
            return true;
        }
    }


    //Equals and HashCode

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof User user)) return false;
        return Objects.equals(username, user.username);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(username);
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
