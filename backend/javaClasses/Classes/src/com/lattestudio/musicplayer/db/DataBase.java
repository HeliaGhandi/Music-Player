package com.lattestudio.musicplayer.db;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.util.adapter.LocalDateTimeAdapter;
import com.lattestudio.musicplayer.util.adapter.LocalTimeAdapter;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.lang.reflect.Type;
import java.util.LinkedList;
import java.util.List;

/**
 * @author Iliya Esmaeili
 * @author Helia Ghandi
 * @since 0.0.19
 */

public class DataBase {
    private static List<User> users = new LinkedList<>();
    private static List<String> usernames = new LinkedList<>();
    private static List<String> emails = new LinkedList<>();

    public static List<User> getUsers() {
        return users;
    }

    public static List<String> getUsernames() {
        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
        RandomAccessFile output = null;
        try {
            output = new RandomAccessFile(path.toFile() , "rw");
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
        String line;
        while (true){
            try {
                if ((line = output.readLine()) == null) break;
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            if(line.contains("username")){
                usernames.add(line.substring(15,line.length()-2)); //15 for json fommating to easily access the user name :)
            }
        }
        try {
            output.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return usernames;
    }

    public static List<String> getEmails() { //sath payin tar az estefadeh az user ha ama sari tar ;)
        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
        RandomAccessFile output = null;
        try {
            output = new RandomAccessFile(path.toFile() , "rw");
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
        String line;
        while (true){
            try {
                if ((line = output.readLine()) == null) break;
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            if(line.contains("email")){
                emails.add(line.substring(11,line.length()-2)); //15 for json fommating to easily access the user name :)
            }
        }
        try {
            output.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return emails;
    }

    /**
     * @author GPT & HELIA
     * @throws Exception
     */
    public static List<User> loadUsers() throws Exception {
        Path path = Paths.get("src/com/lattestudio/musicplayer/db/users.json");
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .registerTypeAdapter(LocalTime.class, new LocalTimeAdapter())
                .setPrettyPrinting()
                .create();
        FileReader reader = new FileReader(path.toFile());
        Type userListType = new TypeToken<List<User>>() {}.getType();
        List<User> users = gson.fromJson(reader, userListType);
        DataBase.users = users ;
        reader.close();
        return users;
    }

}
