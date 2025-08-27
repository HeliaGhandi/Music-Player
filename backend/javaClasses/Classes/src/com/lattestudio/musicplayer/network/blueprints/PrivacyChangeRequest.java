package com.lattestudio.musicplayer.network.blueprints;

public class PrivacyChangeRequest {
    //properties :
    String username ;
    boolean makePrivate ;
    //Default Getter And Setters :
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isPrivate() {
        return makePrivate;
    }

    public void setMakePrivate(boolean makePrivate) {
        this.makePrivate = makePrivate;
    }
}
