package com.lattestudio.musicplayer.network;

/**
 * <p>
 *     blueprint for json requests
 * </p>
 * <p>
 *     contains a command for the switch-case to do the job properly based on the received command
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since v0.0.16
 * @see ClientHandler
 * @see Response
 * @see Server
 * @see com.lattestudio.musicplayer.network.blueprints.LoginRequest
 * @see com.lattestudio.musicplayer.network.blueprints.SignUpRequest
 * @see com.lattestudio.musicplayer.network.blueprints.ForgotPasswordRequest
 */
public class Request {
    //Properties :
    private String command;


    //Constructors :
    /**
     * <p>
     *     default no param constructor required for JSON
     * </p>
     * @see Response
     * @see ClientHandler
     * @see Server
     */
    public Request() {} //for gson


    //Default Getter And Setters :

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }

}
