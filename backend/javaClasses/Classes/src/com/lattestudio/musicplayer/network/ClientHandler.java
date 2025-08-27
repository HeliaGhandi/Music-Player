/*
TO-DO-LIST :
    2.exception haye dorost -> javadoc esh ham dorost she
    5.baraye dashtan throw ha va hamchenin response ha ya pak kardan yekish
 */

package com.lattestudio.musicplayer.network;


import java.io.*;
import java.net.Socket;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.Base64;
import java.util.LinkedList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.model.Music;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.network.blueprints.*;
import com.lattestudio.musicplayer.util.Mail;
import com.lattestudio.musicplayer.util.Message;
import com.lattestudio.musicplayer.util.adapter.LocalDateTimeAdapter;
import com.lattestudio.musicplayer.util.adapter.LocalTimeAdapter;
import com.sun.javafx.geom.AreaOp;

import javax.xml.crypto.Data;

/**
 * <p>
 * Handles jsons with switch-case and creates response for the Server class to send it to front end(flutter music player)
 * </p>
 *
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
    private String jsonRequest;
    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .registerTypeAdapter(LocalTime.class, new LocalTimeAdapter())
            .setPrettyPrinting()
            .create();//GPT


    private static final String LOGIN = "LOGIN";
    private static final String SIGN_UP = "SIGN_UP";
    private static final String FORGOT_PASSWORD = "FORGOT_PASSWORD";
    private static final String MUSIC_REQUEST = "MUSIC_REQUEST";
    private static final String TWO_AUTHENTICATION = "TWO_AUTHENTICATION";
    private static final String TWO_AUTHENTICATION_RECOVERY = "TWO_AUTHENTICATION_RECOVERY";
    private static final String ALZHEIMER = "ALZHEIMER";
    private static final String COMPLETE_INFO = "COMPLETE_INFO";
    private static final String DELETE_ACCOUNT = "DELETE_ACCOUNT";
    private static final String USER_LIST = "USER_LIST";
    private static final String GET_ALL_MUSICS = "GET_ALL_MUSICS";
    private static final String LIKE_MUSIC = "LIKE_MUSIC";
    private static final String GET_LIKED_MUSICS = "GET_LIKED_MUSICS";
    private static final String SHARE_MUSIC = "SHARE_MUSIC";
    private static final String GET_QUEUE = "GET_QUEUE" ;
    private static final String PRIVATE_ACCOUNT = "PRIVATE_ACCOUNT" ;


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
     * receives a json -> creates a request object from json -> passes the request object to handler method -> stores the response that handler created in a response object -> creates a json from response -> sends out the response
     * </p>
     * <p>
     * also logs the important data with Message util class
     * </p>
     *
     * @author Helia Ghandi
     * @author Iliya Esmaeili
     */
//    @Override
//    public void run() {
//        try (BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
//             BufferedWriter output = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()))) {
//
//            while ((jsonRequest = input.readLine()) != null) {
//                Message.jsonReceived("JSON RECEIVED:", jsonRequest);
//                try {
//
//                    Request request = gson.fromJson(jsonRequest, Request.class);
//                    Response response = handleRequest(request);
//                    String jsonResponse = gson.toJson(response);
//
//                    output.write(jsonResponse);
//                    Message.jsonSent("JSON SENT : ", jsonResponse);
//                    output.newLine(); //GPT
//                    output.flush();
//                } catch (IOException e) {
//                    // This catch block handles the Broken Pipe specifically
//                    Message.redServerMessage("Client disconnected prematurely: " + e.getLocalizedMessage());
//                    break; // Exit the loop and close the socket
//                } catch (IllegalArgumentException e) {
//                    // Existing exception handling for business logic errors
//                    Response errorResponse = new Response(false, e.getMessage());
//                    String errorJsonResponse = gson.toJson(errorResponse);
//                    output.write(errorJsonResponse);
//                    output.newLine();
//                    output.flush();
//                    Message.jsonSent("ERROR JSON SENT : ", errorJsonResponse);
//                }
//
//            }
//        } catch (IOException e) {
//            throw new RuntimeException("Socket throws IO Exception:" + e.getLocalizedMessage());
//        }
//    }
    @Override
    public void run() {
        try (BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             BufferedWriter output = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()))) {

            while ((jsonRequest = input.readLine()) != null) {
                Message.jsonReceived("JSON RECEIVED:", jsonRequest);
                try {
                    Request request = gson.fromJson(jsonRequest, Request.class);

                    // Check if this is a music request that needs streaming
                    if (request.getCommand().toUpperCase().equals(MUSIC_REQUEST)) {
                        handleMusicStreaming(request, output);
                    } else {
                        // Handle other requests normally
                        Response response = handleRequest(request);
                        String jsonResponse = gson.toJson(response);
                        output.write(jsonResponse);
                        Message.jsonSent("JSON SENT : ", jsonResponse);
                        output.newLine();
                        output.flush();
                    }

                } catch (IOException e) {
                    Message.redServerMessage("Client disconnected prematurely: " + e.getLocalizedMessage());
                    break;
                } catch (IllegalArgumentException e) {
                    Response errorResponse = new Response(false, e.getMessage());
                    String errorJsonResponse = gson.toJson(errorResponse);
                    output.write(errorJsonResponse);
                    output.newLine();
                    output.flush();
                    Message.jsonSent("ERROR JSON SENT : ", errorJsonResponse);
                }
            }
        } catch (IOException e) {
            throw new RuntimeException("Socket throws IO Exception:" + e.getLocalizedMessage());
        }
    }




    private void handleMusicStreaming(Request request, BufferedWriter output) throws IOException {
        MusicRequest musicRequest = gson.fromJson(jsonRequest, MusicRequest.class);

        try {
            if (!DataBase.loadSongsNames().contains(musicRequest.getMusicName())) {
                throw new NoSuchFieldException("SONG NOT FOUND IN OUR DATA BASE");
            } else {
                String filePath = "src/com/lattestudio/musicplayer/db/musics/" + musicRequest.getMusicName();
                Path path = Paths.get(filePath);
                byte[] mp3Bytes = Files.readAllBytes(path);
                String base64Data = Base64.getEncoder().encodeToString(mp3Bytes);
                int chunkSize = 40000;
                int totalChunks = (int) Math.ceil((double) base64Data.length() / chunkSize);

                // Send chunks using the main output stream
                for (int i = 0; i < totalChunks; i++) {
                    int start = i * chunkSize;
                    int end = Math.min(start + chunkSize, base64Data.length());
                    String chunk = base64Data.substring(start, end);

                    // Send raw Base64 chunk
                    output.write(chunk);
                    output.newLine();
                    output.flush();

                    Message.jsonSent("CHUNK SENT : ", chunk.substring(0, Math.min(100, chunk.length())) + "...");

                    try {
                        Thread.sleep(10);
                    } catch (Exception e) {
                        throw new RuntimeException(e.getLocalizedMessage());
                    }
                }
            }
        } catch (IOException ie) {
            throw new RuntimeException("LOADING SONG NAMES FAILED:" + ie.getLocalizedMessage());
        } catch (NoSuchFieldException nsfe) {
            throw new RuntimeException(nsfe.getMessage());
        }
    }

    /**
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
        String command = request.getCommand().toUpperCase();
        switch (command) {
            case LOGIN: {
                return loginHandler();

            }// =D
            case SIGN_UP: {
                return signupHandler();
            }
            case FORGOT_PASSWORD: {
                return forgotPassHandler();
            }
            case MUSIC_REQUEST: {
                return musicRequestHandler();
            }
            case TWO_AUTHENTICATION: {
                return twoAuthenticationHandler();
            }
            case TWO_AUTHENTICATION_RECOVERY :{
                return twoAuthenticationHanderRecoveryMode();
            }
            case ALZHEIMER :{
                return alzheimerHandler();
            }
            case COMPLETE_INFO:{
                return completeInfoHandler();
            }
            case DELETE_ACCOUNT: {
                return deleteAccount();
            }
            case USER_LIST: {
                return userListHandler();
            }
            case GET_ALL_MUSICS: {
                return musicListSendHandler();
            }
            case LIKE_MUSIC:{
                return likeMusicHandler();
            }
            case GET_LIKED_MUSICS:{
                return likeListSendHandler();
            }
            case SHARE_MUSIC:{
                return shareMusicHandler();
            }
            case GET_QUEUE:{
                return queueListSendHandler();
            }
            case PRIVATE_ACCOUNT:{
                return privacyAccountHandler();
            }
            default: {
                return new Response(false, "WRONG JSON SYNTAX");
            }

        }

    }

    private Response privacyAccountHandler(){
        PrivacyChangeRequest privacyChangeRequest;
        try {
            privacyChangeRequest = gson.fromJson(jsonRequest, PrivacyChangeRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for PRIVACY REQUEST");
        }
        int indexOfUser = DataBase.getUsernames().indexOf(privacyChangeRequest.getUsername());
        if(indexOfUser == -1){
            return new Response(false);
        }
        User user = DataBase.getUsers().get(indexOfUser);
        user.setAccountPrivate(privacyChangeRequest.isPrivate());
        return new Response(true , "USER:" + user.getUsername() + "Successfully changed their privacy status to " + privacyChangeRequest.isPrivate());

    }

    private Response queueListSendHandler(){
        GetQueueListRequest getQueueListRequest;
        try {
            getQueueListRequest = gson.fromJson(jsonRequest, GetQueueListRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for GET QUEUE LIST REQUEST");
        }
        int indexOfUser = DataBase.getUsernames().indexOf(getQueueListRequest.getUsername());
        if(indexOfUser == -1){
            return new Response(false);
        }
        User user = DataBase.getUsers().get(indexOfUser);
        List<String> sharedMusicURLS = new LinkedList<>();
        for(Music music : user.getQueue()){
            sharedMusicURLS.add(music.getUrl());
        }
        return new Response(true , sharedMusicURLS.toString());
    }

    private Response shareMusicHandler(){
        ShareSongRequest shareSongRequest;
        try {
            shareSongRequest = gson.fromJson(jsonRequest , ShareSongRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for SHARE SONG REQUEST");
        }
        int indexOfFromUser = DataBase.getUsernames().indexOf(shareSongRequest.getFromUsername());
        User fromUser = DataBase.getUsers().get(indexOfFromUser);
        int indexOfToUser = DataBase.getUsernames().indexOf(shareSongRequest.getToUsername());
        User toUser = DataBase.getUsers().get(indexOfToUser);
        int index = DataBase.getMusics().indexOf(new Music("temp" ,  shareSongRequest.getMusicURL()));//create a temp music to use indexOf
        Music music = DataBase.getMusics().get(index);
        //fromUser.follow(toUser);
        toUser.getQueue().add(music);
        DataBase.clearUsersJson();
        try{
            for(int i = 0 ; i < DataBase.getUsers().size() ; i++){
                try{
                    DataBase.writeToUsersJson(DataBase.getUsers().get(i) , gson , false);
                }catch (Exception e){
                    throw new RuntimeException(e.getMessage());
                }
            }

//            for(int i = 0 ; i < DataBase.getMusics().size() ; i++){
//                try{
//                    DataBase.writeToMusicsJson(DataBase.getMusics().get(i) , gson , false);
//                }catch (Exception e){
//                    throw new RuntimeException(e.getMessage());
//                }
//
//            }

        }catch (Exception e){
            return new Response(false);
        }
        return new Response(true);


    }
    private Response likeMusicHandler(){
        LikeSongRequest likeSongRequest;
        try {
            likeSongRequest = gson.fromJson(jsonRequest , LikeSongRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for LIKE SONG REQUEST");
        }
        String URL = likeSongRequest.getMusicUrl();
        int index = DataBase.getMusics().indexOf(new Music("temp" ,  URL));//create a temp music to use indexOf
        Music music = DataBase.getMusics().get(index);
        int indexOfUser = DataBase.getUsernames().indexOf(likeSongRequest.getUsername());
        User user = DataBase.getUsers().get(indexOfUser);
        boolean success = user.likeMusic(music);
        int newCount = DataBase.computeLikeCountFor(music);
        music.setLikedCount(Math.max(0, newCount)); // guard against negatives
        //DataBase.clearMusicsJson();
        DataBase.clearUsersJson();
        try{
            for(int i = 0 ; i < DataBase.getUsers().size() ; i++){
                try{
                    DataBase.writeToUsersJson(DataBase.getUsers().get(i) , gson , false);
                }catch (Exception e){
                    throw new RuntimeException(e.getMessage());
                }
            }

//            for(int i = 0 ; i < DataBase.getMusics().size() ; i++){
//                try{
//                    DataBase.writeToMusicsJson(DataBase.getMusics().get(i) , gson , false);
//                }catch (Exception e){
//                    throw new RuntimeException(e.getMessage());
//                }
//
//            }

        }catch (Exception e){
            return new Response(false);
        }
        return new Response(success , "new like count : " + music.getLikedCount());
    }

    private Response likeListSendHandler(){
        GetLikeListRequest getlikeListRequest;
        try {
            getlikeListRequest = gson.fromJson(jsonRequest, GetLikeListRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for GET LIKE LIST REQUEST");
        }
        int indexOfUser = DataBase.getUsernames().indexOf(getlikeListRequest.getUsername());
        if(indexOfUser == -1){
            return new Response(false);
        }
        User user = DataBase.getUsers().get(indexOfUser);
        List<String> likedMusicURLS = new LinkedList<>();
        for(Music music : user.getLikedSongs()){
            likedMusicURLS.add(music.getUrl());
        }
        return new Response(true , likedMusicURLS.toString());
    }

    private Response musicListSendHandler(){
        GetMusicListRequest getMusicListRequest;
        try {
            getMusicListRequest = gson.fromJson(jsonRequest, GetMusicListRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for GET MUSIC LIST REQUEST");
        }
        try {
            return new Response(true , DataBase.loadSongsNames().toString());
        }catch (IOException ioe){
            return new Response(false);
        }
    }

    private Response userListHandler(){
        List<User> usersToSend;
        List<String> usernamesToSend ;
        UserListSearchRequest userListSearchRequest;
        try {
            userListSearchRequest = gson.fromJson(jsonRequest, UserListSearchRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for USER LIST");
        }
        if(userListSearchRequest.getFilter().equals("")){
            return new Response(true , DataBase.getUsernames().toString());
            //UserListSearchRequest.publicUsers.toString()
        }else {
            usersToSend = UserListSearchRequest.searchUsers(userListSearchRequest.getFilter());
            System.out.println(usersToSend.toString());
            if (usersToSend.size() == 0) return new Response(false, "User not found");
            else return new Response(true, usersToSend.toString());
        }
    }


    private Response deleteAccount(){
        DeleteAccountRequest deleteAccountRequest;
        try {
            deleteAccountRequest = gson.fromJson(jsonRequest, DeleteAccountRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for Delete Account");
        }
        if (!DataBase.getUsernames().contains(deleteAccountRequest.getUsername()))
            return new Response(false, "username doesn`t exist.");
        int index = DataBase.getUsernames().indexOf(deleteAccountRequest.getUsername());
        DataBase.removeUserFromServer(DataBase.getUsers().get(index));
        return new Response(true);
    }
private Response completeInfoHandler() {
    CompleteInfoRequest completeInfoRequest;
    try {
        completeInfoRequest = gson.fromJson(jsonRequest, CompleteInfoRequest.class);
    } catch (IllegalArgumentException iae) {
        return new Response(false, "Bad argument for completeInfo");
    }
    if (completeInfoRequest.isLoginCreditEmail()) {
        int index = DataBase.getEmails().indexOf(completeInfoRequest.getAuth());
        if (index != -1) {
            User user = DataBase.getUsers().get(index);
            return new CompleteInfoResponse(true, user.getEmail(), user.getUsername(), user.getLastname(), user.getFirstname());
        }else return new Response(false , "User not found!");

    }
    else {
        int index = DataBase.getUsernames().indexOf(completeInfoRequest.getAuth());
        if (index != -1) {
            User user = DataBase.getUsers().get(index);
            return new CompleteInfoResponse(true, user.getEmail(), user.getUsername(), user.getLastname(), user.getFirstname());
        }
        else return new Response(false , "User not found!");
    }
}

    private Response alzheimerHandler(){
        AlzheimerRequest alzheimerRequest;
        try {
            alzheimerRequest = gson.fromJson(jsonRequest, AlzheimerRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for 2Auth");
        }
        if (!DataBase.getEmails().contains(alzheimerRequest.getEmail()))
            return new Response(false, "Email does not exist");
        else {
            return new Response(true);
        }
    }


    private Response musicRequestHandler() {
        MusicRequest musicRequest;
        try {
            musicRequest = gson.fromJson(jsonRequest, MusicRequest.class);
        } catch (IllegalArgumentException iae) {
            throw new IllegalArgumentException("Bad argument for music request");
        }

        try {
            if (!DataBase.loadSongsNames().contains(musicRequest.getMusicName())) {
                throw new NoSuchFieldException("SONG NOT FOUND IN OUR DATA BASE");
            } else {
                // Instead of sending chunks here, return a response that indicates
                // the client should start streaming
                return new Response(true, "STREAM_READY:" + musicRequest.getMusicName());
            }
        } catch (IOException ie) {
            throw new RuntimeException("LOADING SONG NAMES FAILED:" + ie.getLocalizedMessage());
        } catch (NoSuchFieldException nsfe) {
            throw new RuntimeException(nsfe.getMessage());
        }
    }


    private Response twoAuthenticationHandler() {
        TwoAuthRequest twoAuthRequest;
        try {
            twoAuthRequest = gson.fromJson(jsonRequest, TwoAuthRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for 2Auth");
        }
        if (!DataBase.getEmails().contains(twoAuthRequest.getEmail()))
            return new Response(false, "Email does not exist");
        String code;
        try {
            code = Mail.sendVerificationEmail(twoAuthRequest.getEmail());
        } catch (Exception e) {
            return new Response(false , e.getMessage());
        }
        return new Response(true, code);
    }

    private Response twoAuthenticationHanderRecoveryMode() {
        TwoAuthRequest twoAuthRequest;
        try {
            twoAuthRequest = gson.fromJson(jsonRequest, TwoAuthRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for 2Auth");
        }
        if (!DataBase.getEmails().contains(twoAuthRequest.getEmail()))
            return new Response(false, "Email does not exist");
        String code;
        try {
            code = Mail.sendRecoveryEmail(twoAuthRequest.getEmail());
        } catch (Exception e) {
            return new Response(false , e.getMessage());
        }
        return new Response(true, code);
    }

    private Response signupHandler() throws IOException {
        SignUpRequest signUpRequest;
        try {
            signUpRequest = gson.fromJson(jsonRequest, SignUpRequest.class);
        } catch (IllegalArgumentException iae) {
            throw new IllegalArgumentException("Bad argument for sign up");
        }
        if (DataBase.getEmails().contains(signUpRequest.getEmail()))
            return new Response(false, "Email already  exist");

        if (DataBase.getUsernames().contains(signUpRequest.getUsername()))
            return new Response(false, "username already exists.");

        User user = new User(signUpRequest.getUsername(), signUpRequest.getPassword(), signUpRequest.getEmail()); //handles illegal argument excepton itslef ;)))
        user.setFirstname(signUpRequest.getFirstname());
        user.setLastname(signUpRequest.getLastname());
        DataBase.writeToUsersJson(user , gson , true);

        return new Response(true);
    }


    private Response forgotPassHandler(){
        ForgotPasswordRequest forgotPasswordRequest;
        try {
            forgotPasswordRequest = gson.fromJson(jsonRequest, ForgotPasswordRequest.class);
        } catch (IllegalArgumentException iae) {
            return new Response(false , "Bad argument for 2Auth");
        }
        if (!DataBase.getEmails().contains(forgotPasswordRequest.getEmail()))//only reseting pass with email :)
            return new Response(false, "Email does not exist");
        if(!forgotPasswordRequest.getNewPassword().equals(forgotPasswordRequest.getReEnteredNewPassword()))
            return new Response(false , "passwords don't match");
        else {
            int indexOfUser = DataBase.getEmails().indexOf(forgotPasswordRequest.getEmail());
            if(indexOfUser != -1){
                User user = DataBase.getUsers().get(indexOfUser);
                if(!user.isPasswordValid(forgotPasswordRequest.getNewPassword())){
                    return new Response(false , "password not valid");
                }
                user.setPassword(forgotPasswordRequest.getNewPassword());
                DataBase.getUsers().set(indexOfUser , user);
                DataBase.clearUsersJson();
                for(int i = 0 ; i < DataBase.getUsers().size() ; i++){
                    try{
                        DataBase.writeToUsersJson(DataBase.getUsers().get(i) , gson , false);
                    }catch (Exception e){
                        throw new RuntimeException(e.getMessage());
                    }
                }
                try{
                    DataBase.loadUsers();
                }catch (Exception e){
                    Message.redServerMessage("ERR Reloading Users\n" + e.getLocalizedMessage());
                    throw new RuntimeException("ERR Reloading Users\n" + e.getLocalizedMessage());
                }
                Message.cyanServerMessage("User:" + user + "\nSuccessfully changed their password to : "+ forgotPasswordRequest.getNewPassword());
                return new Response(true , "password successfully change");
            }else {
                return new Response(false , "Could not find the user");
            }

        }
    }

    private Response loginHandler() {
        LoginRequest loginRequest;
        try {
            loginRequest = gson.fromJson(jsonRequest, LoginRequest.class);
        } catch (Exception e) {
            throw new IllegalArgumentException("Bad argument for login");
        }
        if (loginRequest.isLoginCreditEmail()) { //LOGIN WITH EMAIL
            int indexOfUser = DataBase.getEmails().indexOf(loginRequest.getLoginCredit());

            if (indexOfUser != -1) {
                User user = DataBase.getUsers().get(indexOfUser);
                if (user.getPassword().equals(loginRequest.getPassword())) {
                    user.setNumberOfFailLoginAttempts(0);
                    if (user.isIs2faVerified()) {
                        return new Response(true, "Login successfully with Email (2FA)");
                    } else {
                        if (loginRequest.isRememberMe()) {
                            user.setRememberMe(true);
                            return new Response(true, "Login successfully with Email(Remember)");
                        } else {
                            return new Response(true, "Login successfully with Email");
                        }
                    }
                } else {
                    user.failedLoginAttempt();
                    if (user.getNumberOfFailLoginAttempts() >= 3) {
                        return new Response(false, "Wrong password and total attempts more than 3");
                    } else {
                        return new Response(false, "Wrong password");
                    }
                }
            } else {
                return new Response(false, "email not found");
            }
        } else { //LOGIN WITH USERNAME
            int indexOfUser = DataBase.getUsernames().indexOf(loginRequest.getLoginCredit());
            if (indexOfUser != -1) {
                User user = DataBase.getUsers().get(indexOfUser);
                if (user.getPassword().equals(loginRequest.getPassword())) {
                    user.setNumberOfFailLoginAttempts(0);
                    if (user.isIs2faVerified()) {
                        return new Response(true, "Login successfully with Username (2FA)");
                    } else {
                        if (loginRequest.isRememberMe()) {
                            user.setRememberMe(true);
                            return new Response(true, "Login successfully with Username(Remember)");
                        } else {
                            return new Response(true, "Login successfully with Username");
                        }
                    }
                } else {
                    user.failedLoginAttempt();
                    if (user.getNumberOfFailLoginAttempts() >= 3) {
                        return new Response(false, "Wrong password and total attempts more than 3");
                    } else {
                        return new Response(false, "Wrong password");
                    }

                }
            } else {
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
