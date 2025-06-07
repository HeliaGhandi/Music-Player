import com.lattestudio.musicplayer.network.Server;

import java.lang.reflect.Array;
import java.time.LocalTime;
import java.util.Arrays;

class Main{
    public static void main(String[] args) {
        Server server = new Server();
        server.start();
    }
}