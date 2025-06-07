import com.lattestudio.musicplayer.network.Server;
import com.lattestudio.musicplayer.util.Colors;

import java.lang.reflect.Array;
import java.time.LocalTime;
import java.util.Arrays;

class Main{
    public static void main(String[] args) {
        System.out.println(Colors.jsonReceived("JSON RECEIEVED :" , "{\n" +
                "  \"command\": \"login\",\n" +
                "  \"args\": [\"iliya\", \"123456\"]\n" +
                "}\n"));
        Server server = new Server();
        server.start();

    }
}