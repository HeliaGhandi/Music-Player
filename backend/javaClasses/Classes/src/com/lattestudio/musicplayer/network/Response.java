package com.lattestudio.musicplayer.network;
/**
 * <p>
 *     contains a boolean to say if the operation (answer to the received json was successful) and also a message so we can use to tell flutter what exactly was wrong or in some cases if we have multiple scenarios that the answer is successful we can say which successfull scenario happened exactly
 * </p>
 * <p>
 *     for example if user sends correct username and password the operation is successful but if the user has 2FA enabled we want the user to go to another screen to verify their identity with sent email but if the 2fa is off we want the user to go to the app straight forward (enable 2fa for your own security please ;))
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since v0.0.16
 * @see ClientHandler
 * @see Request
 * @see Server
 */
public class Response {
    //Properties :
    private boolean success;
    private String message;



    //Constructors :

    /**
     * <p>
     *     default no param constructor required for JSON
     * </p>
     * @see Request
     * @see ClientHandler
     * @see Server
     */
    public Response() {} //json needs

    /**
     * @param success whether if the operation was successful or not
     * @see Request
     * @see ClientHandler
     * @see Server
     */
    public Response(boolean success) {
        this.success = success;
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
    public Response(boolean success, String message) {
        this.success = success;
        this.message = message;
    }




    //Default Getter And Setters :

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
