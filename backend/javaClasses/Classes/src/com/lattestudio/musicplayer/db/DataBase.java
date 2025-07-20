package com.lattestudio.musicplayer.db;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.util.adapter.LocalDateTimeAdapter;
import com.lattestudio.musicplayer.util.adapter.LocalTimeAdapter;
import java.io.FileReader;
import java.io.IOException;
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
 * @see User
 * @since v0.0.19
 * <p>
 * handles DataBase stuff
 * </p>
 * <p>
 * is a util class that stores list of users / usernames / emails / etc...
 * </p>
 */
public class DataBase {
    //Properties :
    private static List<User> users = new LinkedList<>();
    private static List<String> usernames = new LinkedList<>();
    private static List<String> emails = new LinkedList<>();

    //Constructors :

    private DataBase() {

    }//util class ;)

    //Methods :


    //NOT Default Getter And Setters :
    //goes through the users list that were taken from users.json and put the usernames to another list
    public static List<String> getUsernames() {
        for (User user : users) {
            usernames.add(user.getUsername());
        }
        return usernames;
    }

    //goes through the users list that were taken from users.json and put the emails to another list
    public static List<String> getEmails() {
        for (User user : users) {
            emails.add(user.getEmail());
        }
        return emails;
    }


    /**
     * @throws IOException if users.txt fails to open
     * @author GPT & HELIA
     * <p>
     * opens the users.json file and extract users from the JSON list and put them in a list of users
     * </p>
     * <p>
     * for the app to work properly you have to call this every time before starting the server
     * </p>
     */
    public static List<User> loadUsers() throws IOException {
        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .registerTypeAdapter(LocalTime.class, new LocalTimeAdapter())
                .setPrettyPrinting()
                .create();//GPT
        FileReader reader = new FileReader(path.toFile());
        Type userListType = new TypeToken<List<User>>() {
        }.getType();
        List<User> users = gson.fromJson(reader, userListType);
        DataBase.users = users;
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
