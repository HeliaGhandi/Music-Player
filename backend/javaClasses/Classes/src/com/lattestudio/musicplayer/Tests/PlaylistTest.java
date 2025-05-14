package com.lattestudio.musicplayer.Tests;

import com.lattestudio.musicplayer.model.*;
import org.junit.*;
import java.util.*;
import static org.junit.Assert.*;

/**
 * @see com.lattestudio.musicplayer.model.Playlist;
 * @since 0.0.15
 * @author Iliya Esmaeili
 * @author Helia Ghandi
 * @author chat GPT
 */
@SuppressWarnings("unused")
public class PlaylistTest {
    private Playlist playlist;
    private Music music1;
    private Music music2;
    private User author;

    @Before
    public void setup() {
        music1 = new Music("Track1", 0, 2, 0);
        music2 = new Music("Track2", 0, 3, 0);
        author = new User("user1", "Pass1234", "user1@mail.com");
        playlist = new Playlist("Workout", author);
    }

    @Test
    public void testAddMusicToPlaylistVarargs() {
        assertTrue(playlist.addMusicToPlaylist(music1, music2));
        assertTrue(playlist.getMusicList().contains(music1));
    }

    @Test
    public void testAddMusicToPlaylistList() {
        List<Music> musics = Arrays.asList(music1, music2);
        assertTrue(playlist.addMusicToPlaylist(musics));
    }

    @Test
    public void testRemoveMusic() {
        playlist.addMusicToPlaylist(music1);
        assertTrue(playlist.removeMusicFromPlaylist(music1));
        assertFalse(playlist.removeMusicFromPlaylist(music2)); // not in list
    }

    @Test
    public void testSetPrivacy() {
        assertTrue(playlist.setPrivate());
        assertFalse(playlist.setPrivate()); // already private

        assertTrue(playlist.setPublic());
        assertFalse(playlist.setPublic()); // already public
    }

    @Test
    public void testAppendFromPublicPlaylist() {
        Playlist publicPlaylist = new Playlist("Chill", author, music1, music2);
        assertTrue(playlist.appendFromPlaylist(publicPlaylist));
    }

    @Test
    public void testAppendFromPrivatePlaylistFails() {
        Playlist privatePlaylist = new Playlist("Secret", author, music1);
        privatePlaylist.setPrivate();
        assertFalse(playlist.appendFromPlaylist(privatePlaylist));
    }

    @Test(expected = IllegalArgumentException.class)
    public void testInvalidPlaylistName() {
        new Playlist("", author);
    }

    @Test(expected = NullPointerException.class)
    public void testInvalidPlaylistAuthor() {
        new Playlist("ValidName", null);
    }
}
