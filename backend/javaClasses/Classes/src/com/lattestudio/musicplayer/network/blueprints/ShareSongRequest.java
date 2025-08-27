package com.lattestudio.musicplayer.network.blueprints;

public class ShareSongRequest {
    //Properties :
    String fromUsername ;
    String toUsername ;
    String musicURL ;

    //Default Getter And Setters :
    public String getFromUsername() {
        return fromUsername;
    }

    public void setFromUsername(String fromUsername) {
        this.fromUsername = fromUsername;
    }

    public String getToUsername() {
        return toUsername;
    }

    public void setToUsername(String toUsername) {
        toUsername = toUsername;
    }

    public String getMusicURL() {
        return musicURL;
    }

    public void setMusicURL(String musicURL) {
        this.musicURL = musicURL;
    }
}
