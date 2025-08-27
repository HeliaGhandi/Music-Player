package com.lattestudio.musicplayer.model;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.util.adapter.LocalDateTimeAdapter;
import com.lattestudio.musicplayer.util.adapter.LocalTimeAdapter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * The User Class That Stores a ADMIN and its data
 * </p>
 *
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @see Playlist
 * @see Music
 * @see User
 * @see com.lattestudio.musicplayer.Tests.UserTest
 * @since v0.1.10
 */
public class Admin extends User {

    //Properties :
    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .registerTypeAdapter(LocalTime.class, new LocalTimeAdapter())
            .setPrettyPrinting()
            .create();//GPT

    //Constructors :
    public Admin(String username, String password, String email) {
        super(username, password, email);
    }

    public Admin(String username, String password) {
        super(username, password);
    }

    public Admin(String username) {
        super(username);
    }
    //Methods :

    /**
     * allows the ADMINISTRATOR to add a user to the DATA BASE
     * @param username the new user's username
     * @return true if the operation is Successful
     */
    public boolean addUser(String username) {
        try {
            User user = new User(username);
            DataBase.writeToUsersJson(user, gson, true);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    /**
     * allows the ADMINISTRATOR to add a user to the DATA BASE
     * @param username the new user's username
     * @return true if the operation is Successful
     */
    public boolean addUser(String username, String password) {
        try {
            User user = new User(username, password);
            DataBase.writeToUsersJson(user, gson, true);
            return true;
        } catch (IOException e) {
            return false;
        }
    }
    public boolean addUser(String username, String password , String email) {
        try {
            User user = new User(username , password , email);
            DataBase.writeToUsersJson(user, gson, true);
            return true;
        } catch (IOException e) {
            return false;
        }
    }
    public boolean addUser(String username, String password , String email , String firstName , String lastName) {
        try {
            User user = new User(username , password , email);
            user.setFirstname(firstName);
            user.setLastname(lastName);
            DataBase.writeToUsersJson(user, gson, true);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    public List<User> getUsersList(){
        return DataBase.getUsers();
    }
    public List<String> getUsernames(){
        return DataBase.getUsernames();
    }
    public List<String> getEmails(){
        return DataBase.getEmails();
    }
    public boolean changeUsersUsername(User user , String username){
        if(getUsernames().contains(username)){
            //message
            return false ;
        }
        user.setUsername(username);
        return true ;
    }
    public boolean changeUsersPassword(User user , String password){
        if(user.isPasswordValid(password)){
            user.setPassword(password);
            return true;
        }
        return false ;
    }
    public boolean changeUsersFirstName(User user , String firstName){
        user.setFirstname(firstName);
        return true;
    }
    public boolean changeUsersLastName(User user , String lastName){
        user.setLastname(lastName);
        return true ;
    }
    public boolean changeUsersEmail(User user , String email){
        user.setEmail(email);
        return true;
    }
    public Map<String , String> getUsersInfo(User user){
        Map<String , String> userInfo = new HashMap<>();
        userInfo.put("username" , user.getUsername());
        userInfo.put("firstName" , user.getFirstname());
        userInfo.put("lastName" , user.getLastname());
        userInfo.put("email" , user.getEmail());
        return userInfo;
    }
//    public List<Music> getMostLikedMusics(){
//        List<Music> mostLikedMusics = new ArrayList<>();
//        try{
//            List<String> songNames = DataBase.loadSongsNames();
//        }catch (IOException ioe){
//
//        }
//        return mostLikedMusics;//TODO
//    }
    //Equals and HashCode :


    //Default Getter And Setters :

}
