import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.network.Server;
import com.lattestudio.musicplayer.util.Colors;
import com.lattestudio.musicplayer.util.Message;

import java.io.*;
import java.lang.reflect.Array;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalTime;
import java.util.Arrays;

class Main{
    public static void main(String[] args) throws Exception {
        Message.cyanServerMessage("USERS RESTORED : " + DataBase.loadUsers());
        Message.cyanServerMessage("USERNAMES RESTORED : "+ DataBase.getUsernames());
        Message.cyanServerMessage("EMAILS RESTORED :" + DataBase.getEmails());

        Server server = new Server();
        server.start();

    }
}