package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

public class AlzheimerRequest extends Request {
    //Properties :
    private String email;

    //Default Getter And Setters :
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
