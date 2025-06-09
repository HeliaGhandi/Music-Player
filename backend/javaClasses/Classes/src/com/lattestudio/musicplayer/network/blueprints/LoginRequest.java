package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class LoginRequest extends Request {
    private String loginCredit;
    private String password;
    private boolean rememberMe;


    public String getLoginCredit() {
        return loginCredit;
    }

    public String getPassword() {
        return password;
    }

    public boolean isRememberMe() {
        return rememberMe;
    }

    public void setRememberMe(boolean rememberMe) {
        this.rememberMe = rememberMe;
    }

    public boolean isLoginCreditEmail(){
        String emailPattern = "^(\\w*|\\d*|.*|_*|)@(\\w*|\\d*).([a-zA-Z0-9.]{2,})$" ;
        Pattern pattern = Pattern.compile(emailPattern);
        Matcher matcher = pattern.matcher(loginCredit);
        return matcher.find();
    }
}
