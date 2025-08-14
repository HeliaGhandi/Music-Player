package com.lattestudio.musicplayer.db;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.util.adapter.LocalDateTimeAdapter;
import com.lattestudio.musicplayer.util.adapter.LocalTimeAdapter;

import java.io.FileReader;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.lang.reflect.Type;
import java.util.ArrayList;
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
        usernames.clear();
        for (User user : users) {
            usernames.add(user.getUsername());
        }
        return usernames;
    }

    //goes through the users list that were taken from users.json and put the emails to another list
    public static List<String> getEmails() {
        emails.clear();
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
        if (users.size() != 0) {
            users.clear();
        }

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

    public static List<Path> loadSongs() throws IOException {
        List<Path> contect;
        contect = Files.list(Paths.get("src/com/lattestudio/musicplayer/db/musics")).toList();

        return contect;
    }

    public static List<String> loadSongsNames() throws IOException {
        List<Path> contect = DataBase.loadSongs();
        List<String> songNames = new LinkedList<>();
        for (Path path : contect) {
            songNames.add(path.getFileName().toString());
        }
        return songNames;
    }

    /**
     * @throws IOException if users.json fails to open or closed
     * @author GPT & ILIYA
     * <p>
     * opens the users.json file and writes the user that is provided in the params
     * </p>
     * <p>
     * if you want to add multiple users just use a loop yourself:_)
     * </p>
     */
    public static boolean writeToUsersJson(User user, Gson gson , boolean addToList) throws IOException {
        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
        RandomAccessFile output = new RandomAccessFile(path.toFile(), "rw");
        try {
            String userJson = gson.toJson(user);
            if (output.length() == 2) {
                output.writeBytes("[\n");
                output.writeBytes(userJson);
                output.writeBytes("\n]");
            } else {
                output.seek(output.length() - 1);
                output.writeBytes(",\n");
                output.writeBytes(userJson);
                output.writeBytes("\n]");

            }
            if(addToList)DataBase.getUsers().add(user);
        } catch (IOException e) {
            return false;
        } finally {
            output.close();
        }
        return true;
    }

    public static boolean clearUsersJson() {
        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
        try {
            Files.write(path, "[]".getBytes());//override
            usernames.clear();
            emails.clear();
            return true;
        } catch (IOException e) {
            throw new RuntimeException("UNABLE TO CLEAR THE USERS JSON" + e.getMessage());
        }
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
