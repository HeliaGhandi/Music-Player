package com.lattestudio.musicplayer.util;
import com.lattestudio.musicplayer.util.Colors;

import java.io.FileWriter;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @see Colors
 * @since 0.0.18
 */

//helia latte noosh jonet :)

public class Message {
    private static Path log = Paths.get("src/com/lattestudio/musicplayer/db/log.txt");
    private static FileWriter fileWriter;
    private static RandomAccessFile fileReader;

    public static String timeFormat(){
        LocalTime localTime = LocalTime.now();
        StringBuilder hour = new StringBuilder(String.valueOf(localTime.getHour()));
        StringBuilder minute = new StringBuilder(String.valueOf(localTime.getMinute()));
        StringBuilder second = new StringBuilder(String.valueOf(localTime.getSecond()));

        //handle kardan 1 raghami ha :
        if(hour.length() == 1) hour.append('0').reverse();
        if(minute.length() == 1) minute.append('0').reverse();
        if(second.length() == 1) second.append('0').reverse();

        return (hour.toString() + ":" + minute.toString()+":"+second.toString());
    }

    public static String coloredTime(){
        return(Colors.PURPLE + timeFormat() + " - "+Colors.RESET);
    }

    public static String dateFormat(){
        LocalDateTime localDateTime = LocalDateTime.now();
        return localDateTime.format(DateTimeFormatter.ofPattern("yyyy-MMM-dd"));
    }

    public static void startUp(){
        try {
            fileWriter = new FileWriter(log.toFile() , true);
            fileReader = new RandomAccessFile(log.toFile() , "r");
        } catch (IOException e) {
            throw new RuntimeException("COULD NOT ACCESS LOG FILE");
        }
    }
    public static void shutDown(){
        try {
            fileWriter.close();
            fileReader.close();
        } catch (IOException e) {
            throw new RuntimeException("LOG FILE ISNT CLOSING \nDO STH:)");
        }
    }

    public static void cyanServerMessage(String message){
        startUp();
        String formattedString = coloredTime() + Colors.CYAN_BOLD_BRIGHT+"[SERVER]: "+Colors.YELLOW_BRIGHT+message+Colors.RESET +"\n" ;
        String formattedStringNoColor = dateFormat() + " " + timeFormat() +" - "+ "[SERVER]: "+ message +"\n" ;

        System.out.print(formattedString);
        try{
            fileWriter.write(formattedStringNoColor);
        } catch (IOException e) {
            throw new RuntimeException("COULD NOT WRITE TO LOG FILE!");
        }
        shutDown();
    }


    public static void redServerMessage(String message ){
        startUp();
        String formattedString = coloredTime() +Colors.RED_BOLD_BRIGHT+"[SERVER]: "+Colors.YELLOW_BRIGHT+message+Colors.RESET+"\n"  ;
        String formattedStringNoColor = dateFormat() + " " + timeFormat() +" - "+ "[SERVER]: "+ message +"\n" ;
        System.out.print(formattedString);
        try{
            fileWriter.write(formattedStringNoColor);
        } catch (IOException e) {
            throw new RuntimeException("COULD NOT WRITE TO LOG FILE!");
        }
        shutDown();
    }


    public static void jsonReceived(String message , String json){
        startUp();
        String formattedString = coloredTime()+ Colors.CYAN_BOLD_BRIGHT+"[SERVER]: "+Colors.YELLOW_BRIGHT+message+Colors.RESET + "\n" + Colors.BLACK_BACKGROUND_BRIGHT+ json+Colors.RESET +"\n" ;
        String formattedStringNoColor = dateFormat() + " " + timeFormat() +" - "+ "[SERVER]: "+ message +"\n" + json + "\n" ;
        System.out.print(formattedString);
        try{
            fileWriter.write(formattedStringNoColor);
        } catch (IOException e) {
            throw new RuntimeException("COULD NOT WRITE TO LOG FILE!");
        }
        shutDown();
    }
    public static void readAllLogs() throws IOException {
        startUp();
        System.out.print(Colors.BLACK_BACKGROUND_BRIGHT);
        System.out.println("   ARCHIVED LOG : ");
        System.out.println();
        String line ;
        while ((line = fileReader.readLine()) != null)
        {
            System.out.println("  " + line);
        }
        System.out.println();
        System.out.println(Colors.RESET);
        shutDown();
}

}
