package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

public class CreatePlaylistRequest extends Request {
    //Properties :
    String playlistName ;
    String username ;


    //Constructors :
    public CreatePlaylistRequest(){
        super();
    }
    public CreatePlaylistRequest(String playlistName) {
        this.playlistName = playlistName;
    }

    //Methods :
    //Equals and HashCode :
    //Default Getter And Setters :

    public String getPlaylistName() {
        return playlistName;
    }

    public void setPlaylistName(String playlistName) {
        this.playlistName = playlistName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
