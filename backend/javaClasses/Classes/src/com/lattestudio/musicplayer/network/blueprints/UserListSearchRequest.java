package com.lattestudio.musicplayer.network.blueprints;

import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.network.Request;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class UserListSearchRequest extends Request {
//Properties :
    private String filter ;
    public static List<User> publicUsers = new LinkedList<>();


//Constructors :

    public UserListSearchRequest(){
        super();
    }
    public UserListSearchRequest(String filter) {
        this.filter = filter;
    }

//Methods :
    public static List<User> searchUsers(String filter){
        List<User> filteredUsers = new LinkedList<>();
        for(User user : DataBase.getUsers()){
            if(user.isAccountPrivate()){
                publicUsers.add(user);
            }
        }

        for(User user : publicUsers){
            if(user.getUsername().toUpperCase().contains(filter.toUpperCase())){//ignore case
                filteredUsers.add(user);
            }
        }
        return filteredUsers;
    }
//Equals and HashCode :
//Default Getter And Setters :


    public String getFilter() {
        return filter;
    }

    public void setFilter(String filter) {
        this.filter = filter;
    }

}
