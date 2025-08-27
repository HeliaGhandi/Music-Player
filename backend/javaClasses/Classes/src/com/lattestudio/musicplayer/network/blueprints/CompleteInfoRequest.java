package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CompleteInfoRequest extends Request {
    //Properties :
    private String auth;


    //methods :

    /**
     * <p>
     *     uses regular expression(RegEx) to determine if the auth credit is username or email
     * </p>
     * @return a boolean that is true if the login credit is an email and false if the login credit is a username
     * @see java.util.regex
     * @see java.util.regex.Matcher
     * @see java.util.regex.Pattern
     */
    public boolean isLoginCreditEmail(){
        String emailPattern = "^(\\w*|\\d*|.*|_*|)@(\\w*|\\d*).([a-zA-Z0-9.]{2,})$" ;
        Pattern pattern = Pattern.compile(emailPattern);
        Matcher matcher = pattern.matcher(auth);
        return matcher.find();
    }

    //Default Getter And Setters :

    public String getAuth() {
        return auth;
    }

    public void setAuth(String auth) {
        this.auth = auth;
    }
}
