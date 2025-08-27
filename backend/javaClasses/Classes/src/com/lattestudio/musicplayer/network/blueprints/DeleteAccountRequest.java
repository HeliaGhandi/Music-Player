package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.network.Request;

public class DeleteAccountRequest extends Request {
    //Properties :
    String username ;
    //Constructors :

    public DeleteAccountRequest(){
        super();
    }
    public DeleteAccountRequest(String username) {
        super();
        this.username = username;
    }

    //Methods :
    //Equals and HashCode :
    //Default Getter And Setters :


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
