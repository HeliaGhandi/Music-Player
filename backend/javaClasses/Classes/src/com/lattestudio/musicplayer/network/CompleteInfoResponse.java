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
 * @since v0.0.10
 * @see ClientHandler
 * @see Request
 * @see Server
 */

public class CompleteInfoResponse extends Response{

    //Properties :
    private String firstname;
    private String lastname;
    private String username;
    private String email;
//Constructors :

    public CompleteInfoResponse(){}

    public CompleteInfoResponse(boolean success , String email, String username, String lastname, String firstname) {
        super(success);
        this.email = email;
        this.username = username;
        this.lastname = lastname;
        this.firstname = firstname;
    }

//Default Getter And Setters :

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}


