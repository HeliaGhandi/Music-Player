package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

/**
 * <p>
 *     blueprint for SignUp request json
 * </p>
 * @author Iliya Esmaeili
 * @since v0.1.8
 * @see Request
 * @see com.lattestudio.musicplayer.network.Server
 * @see com.lattestudio.musicplayer.network.ClientHandler
 */
public class TwoAuthRequest extends Request {
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
