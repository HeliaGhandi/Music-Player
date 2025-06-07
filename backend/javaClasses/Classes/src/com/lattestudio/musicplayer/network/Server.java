package com.lattestudio.musicplayer.network;
/*
harfi baraye goftan nadaram (helia)
dar hal majara jooyi (iliya)
 */

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;


import com.lattestudio.musicplayer.model.*;
import com.lattestudio.musicplayer.util.Colors;

import javax.swing.*;

/**
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @since 0.0.16
 * @see com.lattestudio.musicplayer.network.ClientHandler
 */
public class Server {
    private static final int PORT = 9090;


    private Socket socket;


    public void start (){
        try(ServerSocket serverSocket = new ServerSocket(PORT)){
            System.out.println(Colors.cyanServerMessage("Music Server is running on port"));

            while (true){
                socket = serverSocket.accept();
                System.out.println(Colors.cyanServerMessage("New client connected: " + socket.getInetAddress()));

                ClientHandler handler = new ClientHandler(socket);
                Thread clientThread = new Thread(handler);
                clientThread.start();
            }
        } catch (IOException e) {
            System.out.println(Colors.redServerMessage("IO EXCEPTION ON CREATING SERVER SOCKET"));
            System.out.println(Colors.redServerMessage("YOU ARE COOKED!"));//so as we:)
            throw new RuntimeException(e);
        }

    }

}
