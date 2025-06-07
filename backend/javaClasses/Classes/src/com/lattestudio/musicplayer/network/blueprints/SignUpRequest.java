package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

public class SignUpRequest extends Request {
    private String firstname;
    private String lastname;
    private String username;
    private String email;
    private String password;

    public String getFirstname() {
        return firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }
}
