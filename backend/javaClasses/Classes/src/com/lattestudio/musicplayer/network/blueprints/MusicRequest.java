package com.lattestudio.musicplayer.network.blueprints;
import com.lattestudio.musicplayer.network.Request;
// 14 mordad -> be soye upload ahang va badbakhti
//dar majara neshestim bargh ham nadarim ;)

/**
 * <p>
 *     blueprint for music request json
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since v0.1.8
 * @see Request
 * @see com.lattestudio.musicplayer.network.Server
 * @see com.lattestudio.musicplayer.network.ClientHandler
 */
public class MusicRequest extends Request {
    //Properties :

    private String musicName;
    private String singerName;
    private String duration;

    //Methods :

    //Default Getter And Setters :


    public String getMusicName() {
        return musicName;
    }

    public void setMusicName(String musicName) {
        this.musicName = musicName;
    }

    public String getSingerName() {
        return singerName;
    }

    public void setSingerName(String singerName) {
        this.singerName = singerName;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }
}
