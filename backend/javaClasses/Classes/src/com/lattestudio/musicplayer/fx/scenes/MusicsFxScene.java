package com.lattestudio.musicplayer.fx.scenes;

import com.lattestudio.musicplayer.fx.MainFx;
import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.model.Music;
import com.lattestudio.musicplayer.model.User;
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
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

public class MusicsFxScene extends Scene {

    private static final String ASSETS_DIR = "src/com/lattestudio/musicplayer/fx/assets/";

    public MusicsFxScene(Stage stage) {
        super(new BorderPane(), 1366, 768);
        BorderPane root = (BorderPane) getRoot();
        root.setBackground(new Background(new BackgroundFill(Color.web("#F5F5F5"), CornerRadii.EMPTY, Insets.EMPTY)));

        // --- Sidebar layout setup (unchanged from original code) ---
        VBox sidebar = new VBox(25);
        sidebar.setPrefWidth(280);
        sidebar.setStyle("-fx-background-color: #07054E; -fx-background-radius: 0 70 70 0;");
        sidebar.setPadding(new Insets(20, 0, 20, 0));
        sidebar.setAlignment(Pos.TOP_CENTER);

        Circle ellipse = new Circle(50);
        ellipse.setFill(Color.web("#D9D9D9"));
        sidebar.getChildren().add(ellipse);

        Button homeBtn = createIconButton("home.png", 40, 40, "Home");
        Button musicBtn = createIconButton("musics_selected.png", 40, 40, "Musics");
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

        // --- Main content area for music list (with updates) ---
        VBox musicListContainer = new VBox(10);
        musicListContainer.setPadding(new Insets(20));
        musicListContainer.setAlignment(Pos.TOP_CENTER);

        Label titleLabel = new Label("All Musics");
        titleLabel.setFont(Font.font("Arial", FontWeight.BOLD, 24));
        titleLabel.setTextFill(Color.web("#07054E"));

        musicListContainer.getChildren().add(titleLabel);

        // Call the method to load music cards from the database
        loadMusicCards(musicListContainer);

        ScrollPane scrollPane = new ScrollPane();
        scrollPane.setContent(musicListContainer);
        scrollPane.setFitToWidth(true);
        scrollPane.setPrefSize(1000, 700);
        scrollPane.setStyle("-fx-background-color: transparent; -fx-border-color: transparent;");

        VBox.setVgrow(scrollPane, Priority.ALWAYS);
        root.setCenter(scrollPane);
    }

    /**
     * Loads music data from the database and creates a card for each song.
     * @param container The VBox to add the music cards to.
     */
    private void loadMusicCards(VBox container) {
        // Fetch all musics from the database
        List<Music> musics = DataBase.getMusics();
        if (musics != null && !musics.isEmpty()) {
            for (Music music : musics) {
                // Create and add a card for each music item
                container.getChildren().add(createMusicCard(music));
            }
        } else {
            Label noMusicLabel = new Label("No musics found in the database.");
            noMusicLabel.setStyle("-fx-font-size: 16px; -fx-text-fill: #555555;");
            container.getChildren().add(noMusicLabel);
        }
    }

    /**
     * Creates a card pane for a single music object.
     * @param music The Music object to display.
     * @return A Pane representing the music card.
     */
    private Pane createMusicCard(Music music) {
        VBox card = new VBox(6);
        card.setPrefSize(300, 120);
        card.setStyle("-fx-background-color: #FFFFFF; -fx-background-radius: 15; -fx-border-radius: 15; -fx-border-color: #CCCCCC; -fx-padding: 10;");

        Label titleLabel = new Label("🎵 " + music.getName());
        titleLabel.setStyle("-fx-font-size: 16px; -fx-font-weight: bold; -fx-text-fill: #07054E;");

        Label likesLabel = new Label("❤️ " + music.getLikedCount() + " likes");
        likesLabel.setStyle("-fx-font-size: 14px; -fx-text-fill: #333333;");

        // Use the size of the comments map to get the comment count
        Label commentsCountLabel = new Label("💬 " + music.getComments().size() + " comments");
        commentsCountLabel.setStyle("-fx-font-size: 14px; -fx-text-fill: #333333;");

        // Use the getArtist() method to get the single artist name
        String artistName = music.getArtist();
        if (artistName == null || artistName.isEmpty()) {
            artistName = "Unknown Artist";
        }
        Label authorLabel = new Label("✍️ Author: " + artistName);
        authorLabel.setStyle("-fx-font-size: 14px; -fx-text-fill: #555555;");

        Button showCommentsBtn = new Button("Show Comments");
        showCommentsBtn.setStyle("-fx-background-color: #07054E; -fx-text-fill: white; -fx-font-size: 14px; -fx-background-radius: 10;");

        card.getChildren().addAll(titleLabel, likesLabel, commentsCountLabel, authorLabel, showCommentsBtn);
        return card;
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
