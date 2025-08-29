package com.lattestudio.musicplayer.network;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PlaylistResponse extends Response {
    //Properties :
    Map<String , List<String>> playlists = new HashMap<>();
    //Constructors :
    public PlaylistResponse() {
        super();
    }

    public PlaylistResponse(Map<String, List<String>> playlists) {
        this.playlists = playlists;
    }

    public PlaylistResponse(boolean success, Map<String, List<String>> playlists) {
        super(success);
        this.playlists = playlists;
    }
    //Methods :



    //Equals and HashCode :


    //Default Getter And Setters :


    public Map<String, List<String>> getPlaylists() {
        return playlists;
    }

    public void setPlaylists(Map<String, List<String>> playlists) {
        this.playlists = playlists;
    }
}
