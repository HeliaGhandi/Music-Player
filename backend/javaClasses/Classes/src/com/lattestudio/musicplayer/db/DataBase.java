package com.lattestudio.musicplayer.db;

import com.lattestudio.musicplayer.model.User;

import java.util.ArrayList;
import java.util.List;

public class DataBase {
    private static List<User> users = new ArrayList<>();

    public static List<User> getUsers() {
        return users;
    }
}
