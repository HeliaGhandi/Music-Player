<p align="center"><img src="finalprap/musicplayer/fx/assets/musics.png" width="150"></p>
<h1 align="center"><b>Flutter Music Player</b></h1>
<h4 align="center">A cross-platform music player with a robust Java backend.</h4>
<p align="center">
    <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-64B5F6?style=flat">
    <img alt="Framework" src="https://img.shields.io/badge/flutter-3.x-4B95DE?style=flat&logo=flutter">
    <img alt="Backend" src="https://img.shields.io/badge/backend-Java%20(TCP%20Sockets)-2B6DBE?style=flat&logo=java">
    <img alt="License" src="https://img.shields.io/badge/license-MIT-1450A8?style=flat">
</p>

<h4 align="center">
    Developed by Latte Studio ☕<br>
    Helia Ghandi & Iliya Esmaeili
</h4>

📖 About The Project<br>
This Flutter Music Player is a full-stack, cross-platform application developed as a final project for the Advanced Programming course at Shahid Beheshti University. It features a powerful, multithreaded backend built with pure Java and TCP sockets.

The application allows users to either play music directly from their device's storage or stream songs from the server in real time. The project also includes a dedicated JavaFX admin panel for comprehensive server and user management.

✨ Key Features
Offline & Online Playback: Play songs locally from your device or stream them from the server.

Secure Authentication: A complete login and signup system with 2FA using a 4-digit code sent to your email.

User-Centric Experience:

Like songs to save them and sync them across all your devices.

Share music with other users, which will appear on their home screen.

Customization:
the terminal is colorful.

Switch between Dark, Light, or System based themes.

Set your account to private to block others from sharing music with you.

Admin Panel: A dedicated JavaFX panel for administrators to manage users, songs, and server operations.

In Development: A chat system is currently being developed to be added in a future update.

📸 Screenshots
<p align="center">
    <img src="photos/screen-shots/auth-screen.png" width=150>
    <img src="photos/screen-shots/login.png" width=150>
    <img src="photos/screen-shots/registration.png" width=150>
    <img src="photos/screen-shots/2fa.png" width=150>
    <img src="photos/screen-shots/find-account.png" width=150>
    <img src="photos/screen-shots/password-change.png" width=150>
 
    
</p>
<p align="center">
    <img src="photos/screen-shots/home-dark.png" width=150>
    <img src="photos/screen-shots/home-2-dark.png" width=150>
    <img src="photos/screen-shots/search-dark.png" width=150>
  <img src="photos/screen-shots/search-ligh.png" width=150>
  <img src="photos/screen-shots/library-dark.png" width=150>
  <img src="photos/screen-shots/library-light.png" width=150>
</p>
<p align="center">
    <img src="photos/screen-shots/setting-dark.png" width=150>
    <img src="photos/screen-shots/profile-dark.png" width=150>
    <img src="photos/screen-shots/edit-profile-dark.png" width=150>
    <img src="photos/screen-shots/content-setting-dark.png" width=150>
    <img src="photos/screen-shots/social-setting-dark.png" width=150>
    
</p>
<p align="center">
    <img src="photos/screen-shots/home-light.png" width=150>
  <img src="photos/screen-shots/direct-dark.png" width=150>
    <img src="photos/screen-shots/chat-dark.png" width=150>
  <img src="photos/screen-shots/chat-light.png" width=150>
  <img src="photos/screen-shots/music-screen.png" width=150>
  <img src="photos/screen-shots/share-music.png" width=150>
    
</p>

🛠️ Installation & Setup
Frontend (Flutter)

Ensure you have Flutter installed on your system.

Navigate to the project directory:

```bash
cd Music-Player
```

Install dependencies and run the app:

```bash
flutter pub get
flutter run
```

Backend (Java)

Open the finalprap/musicplayer folder in your preferred Java IDE (e.g., IntelliJ IDEA or Eclipse).

Run the Server.java file to start the backend server.

-> ADMIN PANEL WILL START AUTOMATICLY.


🧪 Tests
Unit tests for the backend are located in the musicplayer/Tests/ directory. You can run them using JUnit in your IDE.

👨‍💻 Authors
This project was developed by:

Helia Ghandi

Iliya Esmaeili



📜 License
This project is licensed under the MIT License.
