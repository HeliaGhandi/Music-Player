import 'package:login/json-handler.dart';
import 'package:login/main.dart';
import 'package:login/music.dart';

class Musics {
  static List<Music> musics = [];
  static List<Music> likedSongs = [];
  static List<Music> sharedSongs = [];
  static List<String> musicNames = [];
  static List<String> likedMusicNames = [];
  static List<String> sharedMusicNames = [];
  static List<String> musicURLS = [];
  static List<String> likedMusicURLS = [];
  static List<String> sharedMusicURLS = [];
  static List<String> musicArtists = [];
  static List<String> likedMusicArtists = [];
  static List<String> sharedMusicArtists = [];

  static String? jsonMessage;
  static String? likedJsonMessage;
  static String? sharedJsonMessage;

  static loadMusicsFromServer() async {
    // <--- async اضافه شد
    Map<String, String> request = {"command": "GET_ALL_MUSICS"};
    // یک نمونه از JsonHandler ایجاد کرده و متد sendTestRequest را فراخوانی می‌کنیم
    // و منتظر پاسخ آن می‌مانیم.
    Map<String, dynamic> response =
        await JsonHandler(json: request).sendTestRequest(); // <--- تغییر اصلی
    jsonMessage = response["message"];
    print(
      jsonMessage!
          .substring(1, jsonMessage!.length - 1)
          .trim()
          .split(", ")
          .toString(),
    ); // <--- می‌توانید پاسخ سرور را اینجا چاپ کنید
  }

  static loadLikedMusicsFromServer() async {
    // <--- async اضافه شد
    Map<String, String> request = {
      "command": "GET_LIKED_MUSICS",
      "username": UserInfo.username,
    };
    // یک نمونه از JsonHandler ایجاد کرده و متد sendTestRequest را فراخوانی می‌کنیم
    // و منتظر پاسخ آن می‌مانیم.
    Map<String, dynamic> response =
        await JsonHandler(json: request).sendTestRequest(); // <--- تغییر اصلی

    // Handle the case when there are no liked songs or request fails
    if (response["success"] == true && response["message"] != null) {
      likedJsonMessage = response["message"];
      print(
        likedJsonMessage!
            .substring(1, likedJsonMessage!.length - 1)
            .trim()
            .split(", ")
            .toString(),
      );
    } else {
      // No liked songs or request failed, set empty lists
      likedMusicURLS.clear();
      likedSongs.clear();
      likedMusicNames.clear();
      likedMusicArtists.clear();
      print("No liked songs found or request failed");
    }
  }

  static loadSharedMusicsFromServer() async {
    // <--- async اضافه شد
    Map<String, String> request = {
      "command": "GET_QUEUE",
      "username": UserInfo.username,
    };
    // یک نمونه از JsonHandler ایجاد کرده و متد sendTestRequest را فراخوانی می‌کنیم
    // و منتظر پاسخ آن می‌مانیم.
    Map<String, dynamic> response =
        await JsonHandler(json: request).sendTestRequest(); // <--- تغییر اصلی

    // Handle the case when there are no liked songs or request fails
    if (response["success"] == true && response["message"] != null) {
      sharedJsonMessage = response["message"];
      print(
        sharedJsonMessage!
            .substring(1, sharedJsonMessage!.length - 1)
            .trim()
            .split(", ")
            .toString(),
      );
    } else {
      // No liked songs or request failed, set empty lists
      sharedMusicURLS.clear();
      sharedSongs.clear();
      sharedMusicNames.clear();
      sharedMusicArtists.clear();
      print("No shared songs found or request failed");
    }
  }

  static void extractInfoFromJson() {
    // Check if jsonMessage exists before processing
    if (jsonMessage == null) {
      print("No music data available");
      return;
    }

    musicURLS.clear();
    musics.clear();
    String data = jsonMessage!.substring(1, jsonMessage!.length - 1);
    musicURLS = data.trim().split(", ");
    musicNames.clear();
    musicArtists.clear();
    final RegExp regex = RegExp(r'(.*)!(.*)\.mp3');
    for (String url in musicURLS) {
      final Match? match = regex.firstMatch(url.trim());
      if (match != null && match.groupCount >= 2) {
        String name = match.group(1)!;
        String artist = match.group(2)!;
        name = name.replaceAll("-", " ");
        artist = artist.replaceAll("-", " ");
        musicNames.add(name.trim());
        musicArtists.add(artist.trim());
        Music music = Music();
        music.URL = url;
        music.name = name;
        music.singer = artist;
        musics.add(music);
      }
    }
  }

  static void extractInfoFromLikedJson() {
    // Check if likedJsonMessage exists before processing
    if (likedJsonMessage == null) {
      print("No liked music data available");
      return;
    }

    likedMusicURLS.clear();
    likedSongs.clear();

    String data = likedJsonMessage!.substring(1, likedJsonMessage!.length - 1);
    likedMusicURLS = data.trim().split(", ");
    likedMusicNames.clear();
    likedMusicArtists.clear();
    final RegExp regex = RegExp(r'(.*)!(.*)\.mp3');
    for (String url in likedMusicURLS) {
      final Match? match = regex.firstMatch(url.trim());
      if (match != null && match.groupCount >= 2) {
        String name = match.group(1)!;
        String artist = match.group(2)!;
        name = name.replaceAll("-", " ");
        artist = artist.replaceAll("-", " ");
        likedMusicNames.add(name.trim());
        likedMusicArtists.add(artist.trim());
        Music music = Music();
        music.URL = url;
        music.name = name;
        music.singer = artist;
        likedSongs.add(music);
      }
    }
  }

  static void extractInfoFromSharedJson() {
    // Check if likedJsonMessage exists before processing
    if (sharedJsonMessage == null) {
      print("No shared music data available");
      return;
    }

    sharedMusicURLS.clear();
    sharedSongs.clear();

    String data = sharedJsonMessage!.substring(1, sharedJsonMessage!.length - 1);
    sharedMusicURLS = data.trim().split(", ");
    sharedMusicNames.clear();
    sharedMusicArtists.clear();
    final RegExp regex = RegExp(r'(.*)!(.*)\.mp3');
    for (String url in sharedMusicURLS) {
      final Match? match = regex.firstMatch(url.trim());
      if (match != null && match.groupCount >= 2) {
        String name = match.group(1)!;
        String artist = match.group(2)!;
        name = name.replaceAll("-", " ");
        artist = artist.replaceAll("-", " ");
        sharedMusicNames.add(name.trim());
        sharedMusicArtists.add(artist.trim());
        Music music = Music();
        music.URL = url;
        music.name = name;
        music.singer = artist;
        sharedSongs.add(music);
      }
    }
  }
}
