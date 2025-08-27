package com.lattestudio.musicplayer.fx.scenes;

import com.lattestudio.musicplayer.fx.MainFx;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;

import java.io.File;

public class LogFxScene extends Scene {

    private static final String ASSETS_DIR = "src/com/lattestudio/musicplayer/fx/assets/";

    public LogFxScene(Stage stage) {
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

        VBox mainContent = new VBox(20);
        mainContent.setAlignment(Pos.CENTER);

        Button adminBtn = new Button("ADMIN LOG");
        adminBtn.setPrefSize(300, 100);
        adminBtn.setStyle("-fx-background-color: #07054E; -fx-text-fill: white; -fx-font-weight: bold; -fx-font-size: 20px; -fx-background-radius: 15;");
        adminBtn.setOnAction(e -> MainFx.goToAdminLog());

        Button serverBtn = new Button("SERVER LOG");
        serverBtn.setPrefSize(300, 100);
        serverBtn.setStyle("-fx-background-color: #2196F3; -fx-text-fill: white; -fx-font-weight: bold; -fx-font-size: 20px; -fx-background-radius: 15;");
        serverBtn.setOnAction(e -> MainFx.goToServerLog());

        mainContent.getChildren().addAll(adminBtn, serverBtn);
        root.setCenter(mainContent);
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
