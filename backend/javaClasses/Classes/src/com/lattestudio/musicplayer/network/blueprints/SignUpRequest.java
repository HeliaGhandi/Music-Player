/*
TO-Do-LIST :

 */
package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

/**
 * <p>
 *     blueprint for SignUp request json
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since v0.0.16
 * @see Request
 * @see com.lattestudio.musicplayer.network.Server
 * @see com.lattestudio.musicplayer.network.ClientHandler
 */
public class SignUpRequest extends Request {
    //Properties :
    private String firstname;
    private String lastname;
    private String username;
    private String email;
    private String password;



    //Default Getter And Setters :
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

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
