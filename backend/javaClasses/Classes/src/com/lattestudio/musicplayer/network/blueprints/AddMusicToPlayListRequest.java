package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.model.Music;
import com.lattestudio.musicplayer.network.Request;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AddMusicToPlayListRequest extends Request {
    //Properties :
    String username ;
    String musicURL ;
    String playListName ;
    Music music ;
    //Constructors :

    public AddMusicToPlayListRequest(){
        super();
    }

    public AddMusicToPlayListRequest(String username, String musicURL, String playListName) {
        this.username = username;
        this.musicURL = musicURL;
        this.playListName = playListName;
        this.music = AddMusicToPlayListRequest.fromUrl(this.musicURL);
    }




    //Methods :

    public static Music fromUrl(String url) {
        final Pattern pattern = Pattern.compile("(.*)!(.*)\\.mp3");
        final Matcher matcher = pattern.matcher(url.trim());

        if (matcher.find() && matcher.groupCount() >= 2) {
            String name = matcher.group(1);
            String artist = matcher.group(2);

            // Replace hyphens with spaces
            name = name.replaceAll("-", " ");
            artist = artist.replaceAll("-", " ");
            Music music = new Music(name);
            music.setUrl(url);
            music.setArtist(artist);
            return music;
        }
        return null;
    }

    //Equals and HashCode :

    //Default Getter And Setters :


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMusicURL() {
        return musicURL;
    }

    public void setMusicURL(String musicURL) {
        this.musicURL = musicURL;
    }

    public String getPlayListName() {
        return playListName;
    }

    public void setPlayListName(String playListName) {
        this.playListName = playListName;
    }

    public Music getMusic() {
        return music;
    }

    public void setMusic(Music music) {
        this.music = music;
    }
}
