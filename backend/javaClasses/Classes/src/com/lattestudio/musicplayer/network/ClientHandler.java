package com.lattestudio.musicplayer.network;

import java.io.*;
import java.net.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.network.blueprints.LoginRequest;
import com.lattestudio.musicplayer.network.blueprints.SignUpRequest;
import com.lattestudio.musicplayer.util.Colors;
import com.lattestudio.musicplayer.util.Message;

/**
 * @author Helia Ghandi
 * @author ILiya Esmaeili
 * @see com.lattestudio.musicplayer.network.Server
 * @since 0.0.16
 */
public class ClientHandler implements Runnable {
    private Socket socket;
    private String request;
    private final Gson gson = new Gson();
    private static final String LOGIN = "LOGIN" ;
    private static final String SIGN_UP = "SIGN_UP" ;
    private static final String FORGOT_PASSWORD = "FORGOT_PASSWORD" ;

    public ClientHandler(Socket socket) {
        this.socket = socket;
    }

    public ClientHandler(Socket socket, String request) {
        this.socket = socket;
        this.request = request;
    }

    @Override
    public void run() {
        try (BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             BufferedWriter output = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()))) {
            String jsonRequest ;
            while ((jsonRequest = input.readLine()) != null){
            Message.jsonReceived("JSON RECEIVED:" , jsonRequest);

            Request request = gson.fromJson(jsonRequest, Request.class);
            Response response = handleRequest(request);
            String jsonResponse = gson.toJson(response);

            output.write(jsonResponse);
            output.newLine(); //GPT
            output.flush();
        }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private Response handleRequest(Request request) {
        String command =  request.getCommand();
        switch (command){
            case LOGIN :{
                LoginRequest loginRequest ;
                try {
                    loginRequest = (LoginRequest)request;
                }catch (Exception e){
                    throw new IllegalArgumentException("Bad argument for login");
                }
                if(loginRequest.isLoginCreditEmail()){

                }
            } break;
            case SIGN_UP:{
                SignUpRequest signUpRequest ;
                ObjectOutputStream output ;
                try {
                    signUpRequest = (SignUpRequest)request;

                    Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
                    OutputStream outputStream = Files.newOutputStream(path);
                     output = new ObjectOutputStream(outputStream);

                }catch (Exception e){
                    throw new IllegalArgumentException("Bad argument for sign up");
                }
                User user = new User(signUpRequest.getUsername() , signUpRequest.getPassword() , signUpRequest.getEmail());
                try {
                    output.writeObject(new Gson().toJson(user));
                    DataBase.getUsers().add(user);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }

                new Response(true);
            } break ;
            case FORGOT_PASSWORD:{

            }break ;
            default : {
                throw new JsonSyntaxException("WRONG JSON SYNTAX");

            }

        }
        return new Response(false , "WRONG JSON SYNTAX");
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
