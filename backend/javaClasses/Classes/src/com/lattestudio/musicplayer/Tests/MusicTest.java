package com.lattestudio.musicplayer.Tests;

import com.lattestudio.musicplayer.model.*;
import org.junit.*;
import static org.junit.Assert.*;

/**
 * @author Iliya Esmaeili
 * @author Helia Ghandi
 * @author chat GPT
 * @since 0.0.15
 * @see com.lattestudio.musicplayer.model.Music;
 *
 */
@SuppressWarnings("unused")
public class MusicTest {
    private Music testMusic;

    @Before
    public void setup() {
        testMusic = new Music("TestSong", 0, 1, 30);
    }

    @Test
    public void testMusicNameValidation() {
        assertTrue(testMusic.isMusicNameValid("ValidName"));
        assertFalse(testMusic.isMusicNameValid(""));
    }

    @Test
    public void testPlay() {
        assertTrue(testMusic.play());
        assertFalse(testMusic.play()); // Already playing
    }

    @Test
    public void testPause() {
        testMusic.play();
        assertTrue(testMusic.pause());
        assertFalse(testMusic.pause()); // Already paused
    }

    @Test(expected = IllegalArgumentException.class)
    public void testInvalidMusicName() {
        new Music("", 1);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testInvalidDurationByMinute() {
        new Music("Invalid", -5);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testInvalidHourMinuteSecond() {
        new Music("Invalid", 1, 70, 0);
    }


}
