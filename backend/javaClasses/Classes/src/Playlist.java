import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * //since vaghti ke man theme download kardam va baroonam miad :)  24 ordibehesht (tavalod arian)
 * @see Music
 */


@SuppressWarnings("unused")
public class Playlist {
    //Properties :
    private String name ;
    private String QRCode;
    private String playlistCoverURL;
    private String description;

    private int likeCount = 0;
    private User author;
    private boolean isPrivate = false;
    private LocalTime totalDuration;
    private final LocalDateTime creationDate;

    private List<Music> musicList;

    private static final String INVALID_NAME = "Invalid Name" ;
    private static final String INVALID_DURATION = "Invalid Duration" ;

    //Constructors :

    private Playlist(){
        this.name = "NAME NOT SET YET";
        this.QRCode = "QR Code NOT SET YET";
        this.playlistCoverURL = "NOT SET YET";
        this.description = "WRITE DESCRIPTION HERE";

        this.author = null;

        this.totalDuration = LocalTime.of(0,0,0);
        this.creationDate = LocalDateTime.now();

        musicList = new ArrayList<>();
    }

    public Playlist(String name , User author , Music... musics){
        this();

        if(!isPlaylistNameValid(name)){
            throw new IllegalArgumentException(INVALID_NAME);
        }

        this.name = name;
        this.author = author;
        this.QRCode = "";//baada QRCode dade she

        this.musicList = List.of(musics);
    }

    protected Playlist(String name , Music... musics){
        this();

        if(!isPlaylistNameValid(name)){
            throw new IllegalArgumentException(INVALID_NAME);
        }

        this.name = name;
        this.musicList = List.of(musics);
    }



    //Methods :

    public boolean isPlaylistNameValid(String name){
        return (!name.isEmpty()) ;
    }

    public boolean appendFromPlaylist(Playlist playlist){
        if (playlist == null || playlist.isPrivate()) return false;
        else{
            this.addMusicToPlaylist(playlist.getMusicList());
            return true;
        }
    }

    public boolean addMusicToPlaylist(Music... musics){
        if(musics.length == 0) return false;
        else{
            musicList.addAll(List.of(musics));
            return true;
        }
    }

    public boolean addMusicToPlaylist(List<Music> musics){
        if(musics.isEmpty()) return false;
        else{
            musicList.addAll(musics);
            return true;
        }
    }

    public boolean removeMusicFromPlaylist(Music music){
        if(!musicList.contains(music) || music == null) return false;
        else{
            musicList.remove(music);
            return true;
        }
    }

    public boolean setPrivate(){
        if(this.isPrivate()) return false;
        else {
            setPrivacy(true);
            return true;
        }
    }
    public boolean setPublic(){
        if(!this.isPrivate()) return false;
        else {
            setPrivacy(false);
            return true;
        }
    }

    //Equals and HashCode :

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Playlist playlist)) return false;
        return isPrivate == playlist.isPrivate && Objects.equals(name, playlist.name) && Objects.equals(author, playlist.author) && Objects.equals(totalDuration, playlist.totalDuration);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, author, isPrivate, totalDuration);
    }

    //Default Getter And Setters :

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getQRCode() {
        return QRCode;
    }

    public void setQRCode(String QRCode) {
        this.QRCode = QRCode;
    }

    public String getPlaylistCoverURL() {
        return playlistCoverURL;
    }

    public void setPlaylistCoverURL(String playlistCoverURL) {
        this.playlistCoverURL = playlistCoverURL;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public boolean isPrivate() {
        return isPrivate;
    }

    public void setPrivacy(boolean aPrivate) {
        isPrivate = aPrivate;
    }

    public LocalTime getTotalDuration() {
        return totalDuration;
    }

    public void setTotalDuration(LocalTime totalDuration) {
        this.totalDuration = totalDuration;
    }

    public List<Music> getMusicList() {
        return musicList;
    }

    public LocalDateTime getCreationDate() {
        return creationDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
