package com.lattestudio.musicplayer.fx.scenes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.lattestudio.musicplayer.fx.MainFx;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.util.Message;
import com.lattestudio.musicplayer.util.adapter.LocalDateTimeAdapter;
import com.lattestudio.musicplayer.util.adapter.LocalTimeAdapter;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;

import java.io.File;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

public class UserSettingFxScene extends Scene {

    private static final String ASSETS_DIR = "src/com/lattestudio/musicplayer/fx/assets/";

    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .registerTypeAdapter(LocalTime.class, new LocalTimeAdapter())
            .setPrettyPrinting()
            .create();//GPT
    public UserSettingFxScene(Stage stage) {
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
        Button personBtn = createIconButton("usersetting_selected.png", 40, 40, "User Settings");
        Button dialBtn = createIconButton("serversetting.png", 40, 40, "Server Settings");
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

        VBox userListContainer = new VBox(10);
        userListContainer.setPadding(new Insets(20));
        userListContainer.setAlignment(Pos.TOP_CENTER);

        Label titleLabel = new Label("User Settings");
        titleLabel.setFont(Font.font("Arial", FontWeight.BOLD, 24));
        titleLabel.setTextFill(Color.web("#07054E"));

        Button addUserBtn = new Button("Add User");
        addUserBtn.setStyle("-fx-background-color: #00B894; -fx-text-fill: white; -fx-font-weight: bold; -fx-background-radius: 10;");
        addUserBtn.setOnAction(e -> stage.setScene(new CreateUserFxScene(stage)));

        userListContainer.getChildren().addAll(titleLabel, addUserBtn);

        try {
            List<User> users = DataBase.getUsers();
            if (users != null) {
                for (User user : users) {
                    userListContainer.getChildren().add(createUserCard(user, stage));
                }
            }
        } catch (Exception e) {
            Label errorLabel = new Label("Error loading users: " + e.getMessage());
            errorLabel.setTextFill(Color.RED);
            userListContainer.getChildren().add(errorLabel);
        }

        ScrollPane scrollPane = new ScrollPane();
        scrollPane.setContent(userListContainer);
        scrollPane.setFitToWidth(true);
        scrollPane.setPrefSize(1000, 700);
        scrollPane.setStyle("-fx-background-color: transparent; -fx-border-color: transparent;");

        root.setCenter(scrollPane);
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

    private Pane createUserCard(User user, Stage stage) {
        HBox card = new HBox(15);
        card.setPadding(new Insets(10));
        card.setStyle("-fx-background-color: white; -fx-background-radius: 10; -fx-border-radius: 10; -fx-border-color: #ccc;");
        card.setPrefHeight(80);

        Circle avatar = new Circle(30);
        avatar.setFill(Color.LIGHTGRAY);

        VBox info = new VBox(5);
        info.getChildren().addAll(
                new Label("username : " + user.getUsername()) ,
                new Label("Full Name : " + user.getFirstname() +" "+ user.getLastname()) ,
                new Label("Email : "+ user.getEmail())
        );

        Button editButton = createIconButton("edit.png" , 20 , 20, "Edit User");
        editButton.setOnAction(e -> MainFx.stage.setScene(new UserEditFxScene(MainFx.stage, user)));

        Region spacer = new Region();
        HBox.setHgrow(spacer, Priority.ALWAYS);

        Button deleteButton = createIconButton("trash_bin.jpg", 20, 20, "Delete User");
        deleteButton.setOnAction(e -> {
          DataBase.removeUserFromServer(user);
            stage.setScene(new UserSettingFxScene(stage));
        });

        card.getChildren().addAll(avatar, info, spacer, editButton, deleteButton);
        return card;
    }
}
