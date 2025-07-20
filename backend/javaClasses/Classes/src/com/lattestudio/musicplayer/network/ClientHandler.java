/*
TO-DO-LIST :
    2.exception haye dorost -> javadoc esh ham dorost she
    5.baraye dashtan throw ha va hamchenin response ha ya pak kardan yekish
 */

package com.lattestudio.musicplayer.network;


import java.io.*;
import java.net.Socket;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.LocalTime;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.network.blueprints.LoginRequest;
import com.lattestudio.musicplayer.network.blueprints.SignUpRequest;
import com.lattestudio.musicplayer.util.Message;
import com.lattestudio.musicplayer.util.adapter.LocalDateTimeAdapter;
import com.lattestudio.musicplayer.util.adapter.LocalTimeAdapter;

/**
 * <p>
 *     Handles jsons with switch-case and creates response for the Server class to send it to front end(flutter music player)
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @see com.lattestudio.musicplayer.network.Server
 * @see Response
 * @see Request
 * @see LoginRequest
 * @see SignUpRequest
 * @since v0.0.16
 */

public class ClientHandler implements Runnable {

    //Properties :
    private Socket socket;
    private String requestMessage;
    private String jsonRequest ;
    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .registerTypeAdapter(LocalTime.class, new LocalTimeAdapter())
            .setPrettyPrinting()
            .create();//GPT


    private static final String LOGIN = "LOGIN" ;
    private static final String SIGN_UP = "SIGN_UP" ;
    private static final String FORGOT_PASSWORD = "FORGOT_PASSWORD" ;


    //Constructors :

    public ClientHandler(Socket socket) {
        this.socket = socket;
    }

    public ClientHandler(Socket socket, String request) {
        this.socket = socket;
        this.requestMessage = request;
    }
    //Methods :

    /**
     * <p>
     *     receives a json -> creates a request object from json -> passes the request object to handler method -> stores the response that handler created in a response object -> creates a json from response -> sends out the response
     * </p>
     * <p>
     *     also logs the important data with Message util class
     * </p>
     * @author Helia Ghandi
     * @author Iliya Esmaeili   
     */
    @Override
    public void run() {
        try (BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             BufferedWriter output = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()))) {

            while ((jsonRequest = input.readLine()) != null){
            Message.jsonReceived("JSON RECEIVED:" , jsonRequest);

            Request request = gson.fromJson(jsonRequest, Request.class);
            Response response = handleRequest(request);
            String jsonResponse = gson.toJson(response);

            output.write(jsonResponse);
            Message.jsonSent("JSON SENT : " , jsonResponse);
            output.newLine(); //GPT
            output.flush();
        }
        } catch (IOException e) {
            throw new RuntimeException("Socket throws IO Exception");
        }
    }

    /**
     *
     * @param request gets a request that was created from the json sent by frontend(flutter)
     * @return returns a response based on the request - whether it was successful or not - also provides a message if needed 0_0
     * @throws IOException
     * @author Helia Ghandi
     * @author Iliya Esmaeili
     * @see Response
     * @see Request
     * @see ClientHandler
     */
    private Response handleRequest(Request request) throws IOException {
        String command =  request.getCommand().toUpperCase();
        switch (command){
            case LOGIN :{
                return loginHandler();

            }// =D
            case SIGN_UP:{
                return signupHandler();
            }
            case FORGOT_PASSWORD:{
                return alzheimerHandler();
            }
            default : {
                return new Response(false , "WRONG JSON SYNTAX");
            }

        }

    }

    private static Response alzheimerHandler() {
        return new Response(true);
    }

    private Response signupHandler() throws IOException {
        SignUpRequest signUpRequest ;
        try {
            signUpRequest = gson.fromJson(jsonRequest , SignUpRequest.class);
        }catch (IllegalArgumentException iae){
            throw new IllegalArgumentException("Bad argument for sign up");
        }

        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
        RandomAccessFile output = new RandomAccessFile(path.toFile() , "rw");

        if (DataBase.getUsernames().contains(signUpRequest.getUsername()))
            return new Response(false, "username already exists.");
        if (DataBase.getEmails().contains(signUpRequest.getEmail()))
            return new Response(false, "email already exists.");
        User user = new User(signUpRequest.getUsername() , signUpRequest.getPassword() , signUpRequest.getEmail()); //handles illegal argument excepton itslef ;)))
        user.setFirstname(signUpRequest.getFirstname());
        user.setLastname(signUpRequest.getLastname());
        try {
            String userJson = gson.toJson(user);
            if(output.length() == 0){
                output.writeBytes("[\n");
                output.writeBytes(userJson);
                output.writeBytes("\n]");
            }else {
                output.seek(output.length() - 1);
                output.writeBytes(",\n");
                output.writeBytes(userJson);
                output.writeBytes("\n]");
            }
            DataBase.getUsers().add(user);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }finally {
            output.close();
        }

        return alzheimerHandler();
    }

    private Response loginHandler() {
        LoginRequest loginRequest ;
        try {
            loginRequest = gson.fromJson(jsonRequest , LoginRequest.class);
        }catch (Exception e){
            throw new IllegalArgumentException("Bad argument for login");
        }
        if(loginRequest.isLoginCreditEmail()){ //LOGIN WITH EMAIL
            int indexOfUser = DataBase.getEmails().indexOf(loginRequest.getLoginCredit());

            if(indexOfUser != -1){
                User user = DataBase.getUsers().get(indexOfUser) ;
                if (user.getPassword().equals(loginRequest.getPassword())){
                    user.setNumberOfFailLoginAttempts(0);
                    if(user.isIs2faVerified()){
                        return new Response(true, "Login successfully with Email (2FA)");
                    }else {
                        if(loginRequest.isRememberMe()){
                            user.setRememberMe(true);
                            return new Response(true, "Login successfully with Email(Remember)");
                        }else {
                            return new Response(true, "Login successfully with Email");
                        }
                    }
                }else {
                    user.failedLoginAttempt();
                    if(user.getNumberOfFailLoginAttempts() >= 3){
                        return new Response(false, "Wrong password and total attempts more than 3");
                    }else {
                        return new Response(false, "Wrong password");
                    }
                }
            }else {
                return new Response(false, "email not found");
            }
        }else { //LOGIN WITH USERNAME
            int indexOfUser = DataBase.getUsernames().indexOf(loginRequest.getLoginCredit());
            if(indexOfUser != -1){
                User user = DataBase.getUsers().get(indexOfUser) ;
                if (user.getPassword().equals(loginRequest.getPassword())){
                    user.setNumberOfFailLoginAttempts(0);
                    if(user.isIs2faVerified()){
                        return new Response(true, "Login successfully with Username (2FA)");
                    }else {
                        if(loginRequest.isRememberMe()){
                            user.setRememberMe(true);
                            return new Response(true, "Login successfully with Username(Remember)");
                        }else {
                            return new Response(true, "Login successfully with Username");
                        }
                    }
                }else {
                    user.failedLoginAttempt();
                    if(user.getNumberOfFailLoginAttempts() >= 3){
                        return new Response(false, "Wrong password and total attempts more than 3");
                    }else {
                        return new Response(false, "Wrong password");
                    }

                }
            }else {
                return new Response(false, "username not found");
            }
        }
    }

    //Default Getter And Setters :
    public Socket getSocket() {
        return socket;
    }

    public void setSocket(Socket socket) {
        this.socket = socket;
    }

    public String getRequest() {
        return requestMessage;
    }

    public void setRequest(String request) {
        this.requestMessage = request;
    }
}
