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
    private String loginCredit;


    //Default Getter And Setters :
    public String getLoginCredit() {
        return loginCredit;
    }

    public void setLoginCredit(String loginCredit) {
        this.loginCredit = loginCredit;
    }
}
