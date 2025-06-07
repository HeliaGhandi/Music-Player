package com.lattestudio.musicplayer.network;

import java.io.*;
import java.net.*;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;

/**
 * @author Helia Ghandi
 * @author ILiya Esmaeili
 * @see com.lattestudio.musicplayer.network.Server
 * @since 0.0.16
 */
public class ClientHandler implements Runnable {
    private Socket socket;
    private String request ;
    public ClientHandler(Socket socket) {
        this.socket = socket;
    }

    public ClientHandler(Socket socket, String request) {
        this.socket = socket;
        this.request = request;
    }

    @Override
    public void run() {
        try (BufferedInputStream input = new BufferedInputStream(socket.getInputStream());
             BufferedOutputStream output = new BufferedOutputStream(socket.getOutputStream());
             ObjectInputStream objectInput = new ObjectInputStream(input);
             ObjectOutputStream objectOutput = new ObjectOutputStream(output)) {


        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }






    public Socket getSocket() {
        return socket;
    }

    public void setSocket(Socket socket) {
        this.socket = socket;
    }

    public String getRequest() {
        return request;
    }

    public void setRequest(String request) {
        this.request = request;
    }
}
