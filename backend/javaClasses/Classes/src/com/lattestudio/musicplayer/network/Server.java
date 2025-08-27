/*
TO-DO-LIST :
    3.better exception handling and messages and try-catch -> more specific;)
 */

package com.lattestudio.musicplayer.network;
/*
harfi baraye goftan nadaram (helia)
dar hal majara jooyi (iliya)
 */

import java.io.IOException;
import java.net.Inet4Address;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;
import java.time.LocalTime;
import java.util.Objects;
import com.lattestudio.musicplayer.util.Message;



/**
 * <p>
 *  API Implementation using java socket and {@code JSON}({@link com.google.gson.Gson} library)
 * </p>
 * <p>
 *  waits for a client to connect and send a {@code JSON} file
 * </p>
 * <p>
 *  handles {@code JSON} with {@code GSON} and switch-case and creates a response and sends it with help of {@link ClientHandler} Class
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since v0.0.16
 * @see ClientHandler
 * @see Response
 * @see Request
 * @see com.lattestudio.musicplayer.network.blueprints.SignUpRequest
 * @see com.lattestudio.musicplayer.network.blueprints.LoginRequest
 */
public class Server {
    //Properties :
    private int PORT = 9090;
    private final String IP = Inet4Address.getLocalHost().getHostAddress();
    private Socket socket;
    public static int USED_PORT  ;
    public static String USED_IP ;
    public static int numberOfConnectedUsers ;
    public static LocalTime serverRunningStartTime ;

    //Constructors :

    public Server() throws UnknownHostException {
    }

    public Server(int PORT) throws UnknownHostException {
        this.PORT = PORT;
    }



    //Methods :

    /**
     * <p>
     *     creates a server socket and waits for a client
     * </p>
     * <p>
     *     then creates a ClientHandler for eachClient and Also starts a thread for it ;)
     * </p>
     * @see Server
     * @see ClientHandler
     */
    public void start (){
        try(ServerSocket serverSocket = new ServerSocket(PORT)){
            serverSocket.setSoTimeout(0);// 0 = infinite wait for connections
            Message.cyanServerMessage("Music Server is running on :" + IP +":" +PORT);
            serverRunningStartTime = LocalTime.now();
            USED_IP = IP;
            USED_PORT = PORT;

            while (true){
                socket = serverSocket.accept();
                socket.setSoTimeout(0);// Keep connection alive forever unless manually closed
                socket.setKeepAlive(true);
                Message.cyanServerMessage("New client connected: " + socket.getInetAddress());
                numberOfConnectedUsers++ ;
                ClientHandler handler = new ClientHandler(socket);
                Thread clientThread = new Thread(handler);
                clientThread.start();
            }//bayad hamishe montazer bashe :)

        } catch (IOException e) {
            Message.redServerMessage("IO EXCEPTION ON CREATING SERVER SOCKET");
            Message.redServerMessage("YOU ARE COOKED!");//so as we:)
            throw new RuntimeException(e);
        }

    }


    //Equals and HashCode :

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Server server)) return false;
        return PORT == server.PORT;
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(PORT);
    }

    //Default Getter And Setters :

    public int getPORT() {
        return PORT;
    }

    public Socket getSocket() {
        return socket;
    }

    public String getIP() {
        return IP;
    }
}
