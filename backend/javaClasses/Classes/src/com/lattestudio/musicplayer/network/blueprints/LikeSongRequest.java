package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

/**
 * <p>
 *     blueprint for like songs request json
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since v0.2.0
 * @see Request
 * @see com.lattestudio.musicplayer.network.Server
 * @see com.lattestudio.musicplayer.network.ClientHandler
 */
public class LikeSongRequest extends Request {

    //Properties :
    String musicUrl;
    String username ;


    //Default Getter And Setters :

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMusicUrl() {
        return musicUrl;
    }

    public void setMusicUrl(String musicUrl) {
        this.musicUrl = musicUrl;
    }


}
