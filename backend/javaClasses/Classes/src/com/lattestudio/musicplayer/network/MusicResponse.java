package com.lattestudio.musicplayer.network;

/**
 * <p>
 *     json response from server to contain music(binary-based 64) to give it to flutter
 * </p>
 * <p>
 *     if music data is not sent its because the user wanted the name and meta data only
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since v0.0.16
 * @see ClientHandler
 * @see Request
 * @see Server
 */
public class MusicResponse extends Response {
    //Properties :
        private int chunkNum ;
        private String base64Data ;

    //Constructors :
    /**
     * <p>
     *     default no param constructor required for JSON
     * </p>
     * @see Request
     * @see ClientHandler
     * @see Server
     */
    public MusicResponse(){
        super();
    }

    /**
     * @param success whether if the operation was successful or not
     * @see Request
     * @see ClientHandler
     * @see Server
     */
    public MusicResponse(boolean success){
        super(success);
    }

    /**
     *
     * @param success whether if the operation was successful or not
     * @param message the exclusive message
     * <p>
     *       message is almost always required if the success bool is false because flutter probably needs to get info why the request's response is false
     * </p>
     * <p>
     *       but sometimes it's good to have a message also for the true form
     * </p>
     * @see Request
     * @see ClientHandler
     * @see Server
     */
    public MusicResponse(boolean success, String message) {
        super(success , message);
    }


    /**
     *
     * @param success whether if the operation was successful or not
     * @param message the exclusive message
     * @param base64Data base 64 form of the music
     * <p>
     *       message is almost always required if the success bool is false because flutter probably needs to get info why the request's response is false
     * </p>
     * <p>
     *       but sometimes it's good to have a message also for the true form
     * </p>
     * @see Request
     * @see ClientHandler
     * @see Server
     */
    public MusicResponse(boolean success, String message , String base64Data) {
        super(success , message);
        this.base64Data = base64Data ;
    }



    public MusicResponse(int chunkNum, String base64Data) {
        this.chunkNum = chunkNum;
        this.base64Data = base64Data;
    }
    public MusicResponse(int chunkNum, String base64Data , boolean success) {
        super(success);
        this.chunkNum = chunkNum;
        this.base64Data = base64Data;
    }
    //Methods :

    //Equals and HashCode :

    //Default Getter And Setters :

}
