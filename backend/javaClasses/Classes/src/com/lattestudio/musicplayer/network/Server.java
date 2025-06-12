/*
TO-DO-LIST :
    1.constructor
    2.start()
    3.better exception handling and messages and try-catch -> more specific;)
    4.commenting why we need an always true and disabling the rule
    5.suppressing unused
 */

package com.lattestudio.musicplayer.network;
/*
harfi baraye goftan nadaram (helia)
dar hal majara jooyi (iliya)
 */

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
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
    private final int PORT = 9090;

    private Socket socket;

    //Constructors :
    // ye constructor khali
    // ye constructor ke PORT set kone


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

            Message.cyanServerMessage("Music Server is running on port : " + PORT);

            while (true){
                socket = serverSocket.accept();
                Message.cyanServerMessage("New client connected: " + socket.getInetAddress());
                ClientHandler handler = new ClientHandler(socket);
                Thread clientThread = new Thread(handler);
                clientThread.start();
            }

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

}
