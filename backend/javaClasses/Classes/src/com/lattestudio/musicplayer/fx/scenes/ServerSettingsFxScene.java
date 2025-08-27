package com.lattestudio.musicplayer.fx.scenes;

import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.fx.MainFx;
import com.lattestudio.musicplayer.network.Server;
import com.lattestudio.musicplayer.util.Message;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;
import javafx.util.Duration;

import java.io.File;
import java.io.IOException;
import java.time.LocalTime;

public class ServerSettingsFxScene extends Scene {

    private static final String ASSETS_DIR = "src/com/lattestudio/musicplayer/fx/assets/";

    public ServerSettingsFxScene(Stage stage) {
        super(new BorderPane(), 1366, 768);
        BorderPane root = (BorderPane) getRoot();
        root.setBackground(new Background(new BackgroundFill(Color.web("#F5F5F5"), CornerRadii.EMPTY, Insets.EMPTY)));

        VBox sidebar = new VBox(25);
        sidebar.setPrefWidth(280);
        sidebar.setStyle("-fx-background-color: #07054E; -fx-background-radius: 0 70 70 0;");
        sidebar.setPadding(new Insets(20, 0, 20, 0));
        sidebar.setAlignment(Pos.TOP_CENTER);

        Circle ellipse = new Circle(50);
        ellipse.setFill(Color.web("#D9D9D9"));
        sidebar.getChildren().add(ellipse);

        Button homeBtn = createIconButton("home.png", 40, 40, "Home");
        Button musicBtn = createIconButton("musics.png", 40, 40, "Musics");
        Button personBtn = createIconButton("usersetting.png", 40, 40, "User Settings");
        Button dialBtn = createIconButton("serversetting_selected.png", 40, 40, "Server Settings");
        Button logBtn = createIconButton("log.png", 40, 40, "Logs");

        homeBtn.setOnAction(e -> MainFx.goToHome());
        musicBtn.setOnAction(e -> MainFx.goToMusic());
        personBtn.setOnAction(e -> MainFx.goToUser());
        dialBtn.setOnAction(e -> MainFx.goToServer());
        logBtn.setOnAction(e -> MainFx.goToLog());

        VBox buttonBox = new VBox(15);
        buttonBox.setAlignment(Pos.CENTER);
        buttonBox.getChildren().addAll(homeBtn, musicBtn, personBtn, dialBtn, logBtn);
        sidebar.getChildren().add(buttonBox);
        VBox.setVgrow(buttonBox, Priority.ALWAYS);

        root.setLeft(sidebar);

        VBox mainContent = new VBox(20);
        mainContent.setPadding(new Insets(20));
        mainContent.setAlignment(Pos.CENTER);

        Label titleLabel = new Label("Server Settings");
        titleLabel.setFont(Font.font("Arial", FontWeight.BOLD, 24));
        titleLabel.setTextFill(Color.web("#07054E"));

        // Server Info Tabs
        GridPane infoGrid = new GridPane();
        infoGrid.setHgap(20);
        infoGrid.setVgap(20);
        infoGrid.setAlignment(Pos.CENTER);
        infoGrid.setPadding(new Insets(20));

        // Placeholder for real data
        String serverIp = Server.USED_IP;
        String serverPort = String.valueOf(Server.USED_PORT);
        String connectedUsers = String.valueOf(Server.numberOfConnectedUsers);
        String serverThreads = "5";
        String songsLoaded = "0";
        try {
            songsLoaded = String.valueOf(DataBase.loadSongs().size());
        } catch (Exception e) {
            Message.redAdminMessageToAdminPanel(e.getLocalizedMessage());
        }

        // Create the uptime info tab with an initial value
        VBox uptimeTab = createInfoTab("Server Uptime", "Loading...");

        infoGrid.add(createInfoTab("Server IP", serverIp), 0, 0);
        infoGrid.add(createInfoTab("Server Port", serverPort), 1, 0);
        infoGrid.add(createInfoTab("Connected Users", connectedUsers), 2, 0);
        infoGrid.add(uptimeTab, 0, 1);
        infoGrid.add(createInfoTab("Server Threads", serverThreads), 1, 1);
        infoGrid.add(createInfoTab("Songs Loaded", songsLoaded), 2, 1);

        // Start the uptime timer to update the label every second
        startUptimeTimer((Label) uptimeTab.getChildren().get(0));

        Button reloadUsersBtn = makeBtn("Reload Users");
        reloadUsersBtn.setOnAction(e -> {
            Message.cyanAdminMessageToAdminPanel("Reloading users...");
            try {
                DataBase.loadUsers();
                Message.cyanAdminMessageToAdminPanel("Users reloaded: " + DataBase.getUsernames());
            } catch (IOException ex) {
                Message.redAdminMessageToAdminPanel("Failed to reload users: " + ex.getMessage());
            }
        });

        Button showLogsBtn = makeBtn("Show Server Logs");
        showLogsBtn.setOnAction(e -> MainFx.goToServerLog());

        Button clearUsersBtn = makeBtn("Clear All Users");
        clearUsersBtn.setStyle("-fx-background-color: #D63031; -fx-text-fill: white; -fx-font-weight: bold; -fx-background-radius: 15;");
        clearUsersBtn.setOnAction(e -> {
            DataBase.clearUsersJson();
            DataBase.getUsers().clear();
            try {
                Message.redAdminMessageToAdminPanel("Users Loaded:" + DataBase.loadUsers());
            } catch (IOException ioe) {
                Message.redAdminMessageToAdminPanel("FAILED TO LOAD USERS");
            }
            Message.redAdminMessageToAdminPanel("ALL USERS WERE DELETED!");
        });

        Button pingBtn = makeBtn("Ping Server");
        pingBtn.setOnAction(e -> {
            boolean isServerOnline = true;
            if (isServerOnline) {
                Message.cyanAdminMessageToAdminPanel("Server is online.");
            } else {
                Message.redAdminMessageToAdminPanel("Server is offline.");
            }
        });

        Button reloadSongsBtn = makeBtn("Reload Songs");
        reloadSongsBtn.setOnAction(e -> {
            try {
                DataBase.loadSongs();
                Message.cyanAdminMessageToAdminPanel("Songs reloaded.");
            } catch (IOException ex) {
                Message.redServerMessage("Failed to reload songs: " + ex.getMessage());
            }
        });

        mainContent.getChildren().addAll(
                titleLabel,
                infoGrid,
                reloadUsersBtn,
                clearUsersBtn,
                showLogsBtn,
                pingBtn,
                reloadSongsBtn
        );
        root.setCenter(mainContent);
    }

    /**
     * Creates a stylish info tab with a label and a value.
     * @param label The label for the info tab.
     * @param value The value to display.
     * @return A VBox representing the info tab.
     */
    private VBox createInfoTab(String label, String value) {
        VBox tab = new VBox(5);
        tab.setPadding(new Insets(15));
        tab.setAlignment(Pos.CENTER);
        tab.setStyle("-fx-background-color: #FFFFFF; -fx-background-radius: 15; -fx-border-color: #D9D9D9; -fx-border-radius: 15; -fx-border-width: 1; -fx-effect: dropshadow(gaussian, rgba(0,0,0,0.1), 10, 0.5, 0, 5);");

        Label valueLabel = new Label(value);
        valueLabel.setFont(Font.font("Arial", FontWeight.BOLD, 20));
        valueLabel.setTextFill(Color.web("#07054E"));

        Label labelLabel = new Label(label);
        labelLabel.setFont(Font.font("Arial", FontWeight.NORMAL, 14));
        labelLabel.setTextFill(Color.web("#808080"));

        tab.getChildren().addAll(valueLabel, labelLabel);
        return tab;
    }

    /**
     * Creates a Timeline to update the uptime label every second.
     * @param uptimeLabel The label to be updated with the server uptime.
     */
    private void startUptimeTimer(Label uptimeLabel) {
        Timeline timeline = new Timeline(new KeyFrame(javafx.util.Duration.seconds(1), event -> {
            java.time.Duration duration = java.time.Duration.between(Server.serverRunningStartTime, LocalTime.now());
            long seconds = duration.getSeconds();
            long minutes = (seconds / 60) % 60;
            long hours = (seconds / (60 * 60)) % 24;
            long days = seconds / (60 * 60 * 24);

            String formattedUptime = String.format("%d days, %02d:%02d:%02d", days, hours, minutes, seconds % 60);
            uptimeLabel.setText(formattedUptime);
        }));
        timeline.setCycleCount(Timeline.INDEFINITE);
        timeline.play();
    }

    private Button makeBtn(String text) {
        Button btn = new Button(text);
        btn.setPrefSize(300, 50);
        btn.setStyle("-fx-background-color: #07054E; -fx-text-fill: white; -fx-font-weight: bold; -fx-background-radius: 15;");
        return btn;
    }

    private Button createIconButton(String filename, double width, double height, String tooltipText) {
        File file = new File(ASSETS_DIR + filename);
        ImageView imageView = null;

        if (!file.exists()) {
            imageView = new ImageView();
        } else {
            Image image = new Image(file.toURI().toString());
            imageView = new ImageView(image);
        }

        imageView.setFitWidth(width);
        imageView.setFitHeight(height);
        imageView.setPreserveRatio(true);

        Button button = new Button();
        button.setGraphic(imageView);
        button.setTooltip(new javafx.scene.control.Tooltip(tooltipText));
        button.setStyle(
                "-fx-background-color: transparent; " +
                        "-fx-padding: 15px; " +
                        "-fx-background-radius: 20;"
        );

        button.setOnMouseEntered(e -> button.setStyle(
                "-fx-background-color: rgba(255, 255, 255, 0.1); " +
                        "-fx-padding: 15px; " +
                        "-fx-background-radius: 20;"
        ));
        button.setOnMouseExited(e -> button.setStyle(
                "-fx-background-color: transparent; " +
                        "-fx-padding: 15px; " +
                        "-fx-background-radius: 20;"
        ));

        return button;
    }
}
