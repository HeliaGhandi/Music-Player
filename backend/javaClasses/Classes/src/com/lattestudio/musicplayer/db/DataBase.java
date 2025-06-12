/*
TO-DO-LIST :
    1.commented code
    2.private constructor
 */
package com.lattestudio.musicplayer.db;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.util.adapter.LocalDateTimeAdapter;
import com.lattestudio.musicplayer.util.adapter.LocalTimeAdapter;
import java.io.FileReader;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.lang.reflect.Type;
import java.util.LinkedList;
import java.util.List;

/**
 * @author Iliya Esmaeili
 * @author Helia Ghandi
 * @since v0.0.19
 * <p>
 *     handles DataBase stuff
 * </p>
 * <p>
 *     is a util class that stores list of users / usernames / emails / etc...
 * </p>
 * @see User
 */
public class DataBase {
    //Properties :
    private static List<User> users = new LinkedList<>();
    private static List<String> usernames = new LinkedList<>();
    private static List<String> emails = new LinkedList<>();

//Constructors :



//Methods :



//    public static List<String> getUsernames() {
//        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
//        RandomAccessFile output = null;
//        try {
//            output = new RandomAccessFile(path.toFile() , "rw");
//        } catch (FileNotFoundException e) {
//            throw new RuntimeException(e);
//        }
//        String line;
//        while (true){
//            try {
//                if ((line = output.readLine()) == null) break;
//            } catch (IOException e) {
//                throw new RuntimeException(e);
//            }
//            if(line.contains("username")){
//                usernames.add(line.substring(15,line.length()-2)); //15 for json fommating to easily access the user name :)
//            }
//        }
//        try {
//            output.close();
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }
//        return usernames;
//    }
//    public static List<String> getEmails() { //sath payin tar az estefadeh az user ha ama sari tar ;)
//        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
//        RandomAccessFile output = null;
//        try {
//            output = new RandomAccessFile(path.toFile() , "rw");
//        } catch (FileNotFoundException e) {
//            throw new RuntimeException(e);
//        }
//        String line;
//        while (true){
//            try {
//                if ((line = output.readLine()) == null) break;
//            } catch (IOException e) {
//                throw new RuntimeException(e);
//            }
//            if(line.contains("email")){
//                emails.add(line.substring(11,line.length()-2)); //15 for json fommating to easily access the user name :)
//            }
//        }
//        try {
//            output.close();
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }
//        return emails;
//    }


//NOT Default Getter And Setters :
    //goes through the users list that were taken from users.json and put the usernames to another list
    public static List<String> getUsernames(){
        for(User user : users){
            usernames.add(user.getUsername());
        }
        return usernames;
    }
    //goes through the users list that were taken from users.json and put the emails to another list
    public static List<String> getEmails(){
        for(User user : users){
            emails.add(user.getEmail());
        }
        return emails;
    }


    /**
     * @author GPT & HELIA
     * <p>
     *     opens the users.json file and extract users from the JSON list and put them in a list of users
     * </p>
     * <p>
     *     for the app to work properly you have to call this every time before starting the server
     * </p>
     * @throws Exception
     */
    public static List<User> loadUsers() throws Exception {
        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .registerTypeAdapter(LocalTime.class, new LocalTimeAdapter())
                .setPrettyPrinting()
                .create();//GPT
        FileReader reader = new FileReader(path.toFile());
        Type userListType = new TypeToken<List<User>>() {}.getType();
        List<User> users = gson.fromJson(reader, userListType);
        DataBase.users = users ;
        reader.close();
        return users;
    }
    //Default Getter And Setters :
    public static List<User> getUsers() {
        return DataBase.users;
    }

    //if we ever needed to set the lists ourselves (we probably shouldn't;))
    public static void setUsers(List<User> users) {
        DataBase.users = users;
    }

    public static void setUsernames(List<String> usernames) {
        DataBase.usernames = usernames;
    }

    public static void setEmails(List<String> emails) {
        DataBase.emails = emails;
    }
}
