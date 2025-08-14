/*
TO-DO-LIST :
    1.implementation
 */
package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;
/**
 * <p>
 *     blueprint for forgotPassword request json
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since v0.0.16
 * @see Request
 * @see com.lattestudio.musicplayer.network.Server
 * @see com.lattestudio.musicplayer.network.ClientHandler
 */
public class ForgotPasswordRequest extends Request {
    //Properties :
    private String email;
    private String newPassword;
    private String reEnteredNewPassword;


    //Default Getter And Setters :
    public String getEmail() {
        return email;
    }

    public void setEmail(String loginCredit) {
        this.email = loginCredit;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getReEnteredNewPassword() {
        return reEnteredNewPassword;
    }

    public void setReEnteredNewPassword(String reEnteredNewPassword) {
        this.reEnteredNewPassword = reEnteredNewPassword;
    }
}
