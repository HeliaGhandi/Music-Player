package com.lattestudio.musicplayer.fx;

import com.lattestudio.musicplayer.fx.scenes.*;
import javafx.application.Application;
import javafx.stage.Stage;

public class MainFx extends Application {
    // Stage dimensions, consistent with your scene definitions
    public static final double STAGE_WIDTH = 1366;
    public static final double STAGE_HEIGHT = 768;

    // The primary stage of the application
    public static Stage stage;

    // Static scene instances to avoid re-instantiating them on every navigation
    private static HomeFxScene homeScene;
    private static MusicsFxScene musicScene;
    private static UserSettingFxScene userScene;
    private static ServerSettingsFxScene serverScene;
    private static LogFxScene logFxScene;
    private static AdminLogFxScene adminLogFxScene;
    private static ServerLogFxScene serverLogFxScene;

    /**
     * The main method is the entry point for the JavaFX application.
     *
     * @param args Command line arguments.
     */
    public static void main(String[] args) {
        launch(args);
    }

    /**
     * The start method is called after the main method. It's where you
     * set up the primary stage and scenes.
     *
     * @param primaryStage The primary stage for this application.
     */
    @Override
    public void start(Stage primaryStage) {
        MainFx.stage = primaryStage;

        // Initialize all scene instances once at the start of the application
        homeScene = new HomeFxScene(stage);
        musicScene = new MusicsFxScene(stage) ;
        userScene = new UserSettingFxScene(stage ) ;
        serverScene = new ServerSettingsFxScene(stage );
        logFxScene = new LogFxScene(stage );
        adminLogFxScene = new AdminLogFxScene(stage );
        serverLogFxScene = new ServerLogFxScene(stage ) ;

        // Set the stage title
        stage.setTitle("ADMINISTRATOR");

        // Set stage dimensions and properties
        stage.setWidth(STAGE_WIDTH);
        stage.setHeight(STAGE_HEIGHT);
        stage.setResizable(false);

        // Set the initial scene to the Home scene
        stage.setScene(homeScene);

        // Show the stage
        stage.show();
    }

    /**
     * Navigates to the Home scene.
     */
    public static void goToHome() {
        stage.setScene(homeScene);
    }

    /**
     * Navigates to the Musics scene.
     */
    public static void goToMusic() {
        stage.setScene(musicScene);
    }

    /**
     * Navigates to the User Settings scene.
     */
    public static void goToUser() {
        stage.setScene(userScene);
    }

    /**
     * Navigates to the Server Settings scene.
     */
    public static void goToServer() {
        stage.setScene(serverScene);
    }

    /**
     * Navigates to the Log menu scene.
     */
    public static void goToLog() {
        stage.setScene(logFxScene);
    }

    /**
     * Navigates to the Admin Log scene.
     */
    public static void goToAdminLog() {
        stage.setScene(adminLogFxScene);
    }

    /**
     * Navigates to the Server Log scene.
     * Corrected from the previous version to use serverLogFxScene.
     */
    public static void goToServerLog() {
        stage.setScene(serverLogFxScene);
    }
}
