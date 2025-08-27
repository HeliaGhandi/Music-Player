package com.lattestudio.musicplayer.fx.scenes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.fx.MainFx;
import com.lattestudio.musicplayer.model.User;
import com.lattestudio.musicplayer.util.Message;
import com.lattestudio.musicplayer.util.adapter.LocalDateTimeAdapter;
import com.lattestudio.musicplayer.util.adapter.LocalTimeAdapter;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.stage.Stage;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class UserEditFxScene extends Scene {

    private static final String ASSETS_DIR = "src/com/lattestudio/musicplayer/fx/assets/";
    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .registerTypeAdapter(LocalTime.class, new LocalTimeAdapter())
            .setPrettyPrinting()
            .create();//GPT
    public UserEditFxScene(Stage stage, User user) {
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

        VBox formBox = new VBox(20);
        formBox.setPadding(new Insets(40));
        formBox.setPrefSize(400, 500);
        formBox.setStyle("-fx-background-color: white; -fx-background-radius: 20;");
        formBox.setAlignment(Pos.CENTER);

        ImageView profileImage = createProfileImage();
        Label titleLabel = new Label("Edit User");
        titleLabel.setStyle("-fx-font-size: 24px; -fx-font-weight: bold; -fx-text-fill: #07054E;");

        TextField usernameField = styledTextField(user.getUsername());
        TextField firstNameField = styledTextField(user.getFirstname());
        TextField lastNameField = styledTextField(user.getLastname());
        TextField emailField = styledTextField(user.getEmail());

        Button saveBtn = new Button("Save");
        saveBtn.setPrefWidth(250);
        saveBtn.setStyle("-fx-background-color: #00B894; -fx-text-fill: white; -fx-font-size: 16px; -fx-font-weight: bold; -fx-background-radius: 10;");

        Button cancelBtn = new Button("Cancel");
        cancelBtn.setPrefWidth(250);
        cancelBtn.setStyle("-fx-background-color: #D63031; -fx-text-fill: white; -fx-font-size: 16px; -fx-font-weight: bold; -fx-background-radius: 10;");

        formBox.getChildren().addAll(
                profileImage,
                titleLabel,
                labeledField("Username", usernameField),
                labeledField("First Name", firstNameField),
                labeledField("Last Name", lastNameField),
                labeledField("Email", emailField),
                saveBtn,
                cancelBtn
        );

        saveBtn.setOnAction(e -> {
            int indexOfUser = DataBase.getUsers().indexOf(user);
            user.setUsername(usernameField.getText());
            user.setFirstname(firstNameField.getText());
            user.setLastname(lastNameField.getText());
            user.setEmail(emailField.getText());
            DataBase.getUsers().set(indexOfUser , user);
            DataBase.clearUsersJson();
            for(int i = 0 ; i < DataBase.getUsers().size() ; i++){
                try{
                    DataBase.writeToUsersJson(DataBase.getUsers().get(i) , gson , false);
                }catch (Exception ex){
                    throw new RuntimeException(ex.getMessage());
                }
            }
            try{
                DataBase.loadUsers();
            }catch (Exception exc){
                Message.redAdminMessageToAdminPanel("ERR Reloading Users\n" + exc.getLocalizedMessage());
                throw new RuntimeException("ERR Reloading Users\n" + exc.getLocalizedMessage());
            }
            stage.setScene(new UserSettingFxScene(stage));
        });

        cancelBtn.setOnAction(e -> stage.setScene(new UserSettingFxScene(stage)));

        root.setCenter(formBox);
    }

    private ImageView createProfileImage() {
        File imageFile = new File(ASSETS_DIR + "user_placeholder.png");
        if (imageFile.exists()) {
            Image image = new Image(imageFile.toURI().toString());
            ImageView imageView = new ImageView(image);
            imageView.setFitWidth(100);
            imageView.setFitHeight(100);
            imageView.setClip(new Circle(50, 50, 50));
            return imageView;
        } else {
            Circle circle = new Circle(50);
            circle.setFill(Color.GRAY);
            return new ImageView(circle.snapshot(null, null));
        }
    }

    private TextField styledTextField(String text) {
        TextField tf = new TextField(text);
        tf.setPrefWidth(250);
        return tf;
    }

    private VBox labeledField(String labelText, TextField field) {
        VBox box = new VBox(5);
        box.setAlignment(Pos.CENTER_LEFT);
        Label label = new Label(labelText);
        box.getChildren().addAll(label, field);
        return box;
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
