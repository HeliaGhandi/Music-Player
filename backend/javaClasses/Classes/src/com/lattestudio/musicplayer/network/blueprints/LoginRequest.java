/*
TO-DO-LIST:

 */
package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 * <p>
 *     blueprint for Login request json
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since v0.0.16
 * @see Request
 * @see com.lattestudio.musicplayer.network.Server
 * @see com.lattestudio.musicplayer.network.ClientHandler
 */
public class LoginRequest extends Request {
    //Properties :
    private String loginCredit;
    private String password;
    private boolean rememberMe;

    //Methods :

    /**
     * <p>
     *     uses regular expression(RegEx) to determine if the login credit is username or email
     * </p>
     * @return a boolean that is true if the login credit is an email and false if the login credit is a username
     * @see java.util.regex
     * @see java.util.regex.Matcher
     * @see java.util.regex.Pattern
     */
    public boolean isLoginCreditEmail(){
        String emailPattern = "^(\\w*|\\d*|.*|_*|)@(\\w*|\\d*).([a-zA-Z0-9.]{2,})$" ;
        Pattern pattern = Pattern.compile(emailPattern);
        Matcher matcher = pattern.matcher(loginCredit);
        return matcher.find();
    }


    //Default Getter And Setters
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

    public void setLoginCredit(String loginCredit) {
        this.loginCredit = loginCredit;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
