package com.lattestudio.musicplayer.Tests;

import com.lattestudio.musicplayer.model.*;
import org.junit.*;
import static org.junit.Assert.*;
/**
 * @author Iliya Esmaeili
 * @author Helia Ghandi
 * @author chat GPT
 * @since 0.0.15
 * @see com.lattestudio.musicplayer.model.User;
 *
 */
/*
  USING JNIT 4
 */
@SuppressWarnings("unused")
public class UserTest {
    private User testUser1 ;
    private User testUser2 ;
    private Music testMusic ;
    private Playlist testPlaylist ;

    @Before
    public void setup(){
        testUser1 = new User("helia" , "Helia123" , "h.ghandi@mail.sbu.sc.ir") ;
        testUser2 = new User("iliya" , "Iliya123" , "i.esmaeili@mail.sbu.sc.ir") ;
        testMusic = new Music("Fogholade" , 0 , 2 , 5);
        testPlaylist = new Playlist("yoohoo" , testUser1);
    }
    //GPT GENERATED TESTS :
    @Test
    public void testFollowUser() {
        assertTrue(testUser1.follow(testUser2));
        assertTrue(testUser1.getFollowings().contains(testUser2));
        assertTrue(testUser2.getFollowers().contains(testUser1));
    }

    @Test
    public void testUnfollowUser() {
        testUser1.follow(testUser2);
        assertTrue(testUser1.unfollow(testUser2));
        assertFalse(testUser1.getFollowings().contains(testUser2));
    }

    @Test
    public void testLikeMusic() {
        assertTrue(testUser1.likeMusic(testMusic));
        assertTrue(testUser1.getLikedSongs().contains(testMusic));
    }

    @Test
    public void testCreatePlaylist() {
        assertTrue(testUser1.createPlayList("Workout", testMusic));
        assertFalse(testUser1.createPlayList(null)); // should fail gracefully
    }

    @Test
    public void testAddToQueue() {
        assertTrue(testUser1.addToQueue(testMusic));
        assertTrue(testUser1.getQueue().contains(testMusic));
    }

    @Test
    public void testLikePlaylist() {
        assertTrue(testUser1.likePlaylist(testPlaylist));
        assertTrue(testUser1.getLikedPlayLists().contains(testPlaylist));
    }

    @Test
    public void testInvalidPasswordChange() {
        assertFalse(testUser1.changePassword("123"));  // too short or no letters
    }

    @Test
    public void testValidPasswordChange() {
        assertTrue(testUser1.changePassword("newpass123"));
        assertEquals("newpass123", testUser1.getPassword());
    }

    @Test
    public void testGetUsername() {
        assertEquals("iliya", testUser2.getUsername());
    }

    @Test
    public void testAddNullPlaylist() {
        assertFalse(testUser2.addPlaylist(null));
    }

    @Test()
    public void testAddPlaylistEdgeCase() {
        try {
            Playlist playlist = new Playlist("  ");
            testUser1.addPlaylist(playlist);
        }catch (IllegalArgumentException iae){
            assertEquals(0, testUser1.getPlaylists().size());
            assertEquals(0,testUser1.getPlaylists().size());
        }

    }

    @Test
    public void testAddMultiplePlaylistsWithSameName() {
        Playlist p1 = new Playlist("Rock");
        Playlist p2 = new Playlist("Rock");
        assertTrue(testUser1.addPlaylist(p1));
        testUser1.addPlaylist(p2);
        assertFalse(testUser1.addPlaylist(p2));
        assertEquals(1, testUser1.getPlaylists().size());
    }



    //Human Generated TESTS :


}
