package com.lattestudio.musicplayer.Tests;

import com.lattestudio.musicplayer.model.*;
import com.lattestudio.musicplayer.util.Colors;
import com.lattestudio.musicplayer.util.Message;
import org.junit.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import static org.junit.Assert.*;

/**
 * @see com.lattestudio.musicplayer.util.Message;
 * @since v0.1.1
 * @author chat GPT
 */
public class MessageHandlerTest {

    private final ByteArrayOutputStream consoleOut = new ByteArrayOutputStream();
    private PrintStream originalOut;
    private static final Path logFilePath = Path.of("src/com/lattestudio/musicplayer/db/log.txt");

    @Before
    public void setUp() throws IOException {
        // Redirect System.out to capture console output
        originalOut = System.out;
        System.setOut(new PrintStream(consoleOut));

        // Clear log file before each test
        Files.write(logFilePath, new byte[0]);
    }

    @After
    public void tearDown() {
        // Restore System.out
        System.setOut(originalOut);
    }

    private String readLogFile() throws IOException {
        return Files.readString(logFilePath);
    }

    @Test
    public void testCyanServerMessage() throws IOException {
        Message.cyanServerMessage("Test cyan message");

        String console = consoleOut.toString();
        String log = readLogFile();

        assertTrue(console.contains("[SERVER]:"));
        assertTrue(console.contains("Test cyan message"));
        assertTrue(log.contains("Test cyan message"));
    }

    @Test
    public void testRedServerMessage() throws IOException {
        Message.redServerMessage("Test red message");

        String console = consoleOut.toString();
        String log = readLogFile();

        assertTrue(console.contains("[SERVER]:"));
        assertTrue(console.contains("Test red message"));
        assertTrue(log.contains("Test red message"));
    }

    @Test
    public void testJsonReceived() throws IOException {
        Message.jsonReceived("Received something", "{\"json\":true}");

        String console = consoleOut.toString();
        String log = readLogFile();

        assertTrue(console.contains("Received something"));
        assertTrue(console.contains("{\"json\":true}"));
        assertTrue(log.contains("Received something"));
        assertTrue(log.contains("{\"json\":true}"));
    }

    @Test
    public void testJsonSent() throws IOException {
        Message.jsonSent("Sent something", "{\"json\":false}");

        String console = consoleOut.toString();
        String log = readLogFile();

        assertTrue(console.contains("Sent something"));
        assertTrue(console.contains("{\"json\":false}"));
        assertTrue(log.contains("Sent something"));
        assertTrue(log.contains("{\"json\":false}"));
    }

    @Test
    public void testReadAllLogs() throws IOException {
        // First, write something to the log
        Message.cyanServerMessage("Reading back this message");
        consoleOut.reset();

        // Then read and capture output
        Message.readAllLogs();
        String console = consoleOut.toString();

        assertTrue(console.contains("ARCHIVED LOG"));
        assertTrue(console.contains("Reading back this message"));
    }

    @Test
    public void testTimeAndDateFormat() {
        String time = Message.timeFormat();
        String date = Message.dateFormat();

        assertNotNull(time);
        assertNotNull(date);
        assertTrue(time.matches("\\d{2}:\\d{2}:\\d{2}"));
        assertTrue(date.matches("\\d{4}-[A-Za-z]{3}-\\d{2}"));
    }

    @Test
    public void testColoredTime() {
        String colored = Message.coloredTime();

        assertNotNull(colored);
        assertTrue(colored.contains(Colors.PURPLE));
        assertTrue(colored.contains(Colors.RESET));
    }
}