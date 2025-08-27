/*
TO-DO-LIST :
    1.private constructor + javadoc + comment
 */

//kolah refactoring gozashtim - yekshanbe fizik darim - hichi balad nistim ;) 22 khordad 2024
package com.lattestudio.musicplayer.util;

import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.model.User;

import java.io.FileWriter;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * <p>
 *     a util class that does multiple things :
 * </p>
 * <p>
 *     1.sending Colored outputs with help of Color class
 * </p>
 * <p>
 *     2.sending the uncolored version to the log file
 * </p>
 * @author Helia Ghandi
 * @author Iliya Esmaeili
 * @see Colors
 * @since v0.0.18
 */

//helia latte noosh joonet :)

public class Message {
    //Properties :
    private static Path log = Paths.get("src/com/lattestudio/musicplayer/db/log.txt");
    private static Path adminLog = Paths.get("src/com/lattestudio/musicplayer/db/adminLog.txt");
    private static FileWriter fileWriter;
    private static RandomAccessFile fileReader;
    private static FileWriter adminFileWriter;
    private static RandomAccessFile adminFileReader;

    //Constructors :

    /**
     * Private constructor (UTIL CLASS)
     */
    private Message() {
        throw new UnsupportedOperationException("Utility class");
    }

    //Methods :

    /**
     * <p>
     *     uses a {@code StringBuilder} to create a format for time (using {@code LocalTime} for time)
     * </p>
     * @return a formatted string for time : {@code "hh:mm:ss"} (for example  01:01:01)
     * @see StringBuilder
     * @see LocalTime
     */
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

    /**
     * @return a colored string using {@code Colors} class
     * @see Colors
     */
    public static String coloredTime(){
        return(Colors.PURPLE + timeFormat() + " - "+Colors.RESET);
    }

    /**
     * <p>uses {@code LocalDateTime} format method to produce formatted string for date</p>
     * @return a string of format : {@code "yyyy-MMM-dd"} (for example 2024-Nov-12)
     * @see LocalDateTime
     */
    public static String dateFormat(){
        LocalDateTime localDateTime = LocalDateTime.now();
        return localDateTime.format(DateTimeFormatter.ofPattern("yyyy-MMM-dd"));
    }

    /**
     * <p>
     *     opens writers and readers for {@code Messages} class
     * </p>
     * @see Message
     */
    public static void startUp(){
        try {
            fileWriter = new FileWriter(log.toFile() , true);
            fileReader = new RandomAccessFile(log.toFile() , "r");
        } catch (IOException e) {
            throw new RuntimeException("COULD NOT ACCESS LOG FILE");
        }
    }

    /**
     * <p>
     *     opens admin writers and admin readers for {@code Messages} class (specific for admin)
     * </p>
     * @see Message
     */
    public static void adminLogStartUp(){
        try {
            adminFileWriter = new FileWriter(adminLog.toFile() , true);
            adminFileReader = new RandomAccessFile(adminLog.toFile() , "r");
        } catch (IOException e) {
            throw new RuntimeException("COULD NOT ACCESS LOG FILE");
        }
    }

    /**
     * <p>
     *     closes writers and readers for {@code Messages}  class
     * </p>
     * @see Message
     */
    public static void shutDown(){
        try {
            fileWriter.close();
            fileReader.close();
        } catch (IOException e) {
            throw new RuntimeException("LOG FILE ISNT CLOSING \nDO STH:)");
        }
    }

    /**
     * <p>
     *     closes admin writers and admin readers for {@code Messages}  class
     * </p>
     * @see Message
     */
    public static void adminLogShutDown(){
        try {
            adminFileWriter.close();
            adminFileReader.close();
        } catch (IOException e) {
            throw new RuntimeException("LOG FILE ISNT CLOSING \nDO STH:)");
        }
    }

    /**
     * <p>
     *     a String with format and color :
     * </p>
     * <p>
     *     {@code [SERVER]: {message}} for the console
     * </p>
     * <p>
     *     a String with format and no color :
     * </p>
     * <p>
     *     {@code "yyyy-MMM-dd hh:mm:ss - [SERVER]: {message}} for the log file
     * </p>
     * @param message the message from the server to be shown in console and written to log file
     * @see Colors
     */
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




    /**
     * <p>
     *     a String with format and color :
     * </p>
     * <p>
     *     {@code [ADMIN]: {message}} for the admin console
     * </p>
     * <p>
     *     a String with format and no color :
     * </p>
     * <p>
     *     {@code "yyyy-MMM-dd hh:mm:ss - [ADMIN]: {message}} for the log file
     * </p>
     * @param message the message from the ADMIN action to be shown in admin console and written to admin log file
     * @see Colors
     */
    public static void cyanAdminMessageToAdminPanel(String message){
        adminLogStartUp();
        String formattedString = coloredTime() + Colors.GREEN_BOLD_BRIGHT+"[ADMIN ACTION]: "+Colors.BLUE_BOLD_BRIGHT+message+Colors.RESET +"\n" ;
        String formattedStringNoColor = dateFormat() + " " + timeFormat() +" - "+ "[ADMIN ACTION]: "+ message +"\n" ;

        System.out.print(formattedString);
        try{
            adminFileWriter.write(formattedStringNoColor);
        } catch (IOException e) {
            throw new RuntimeException("COULD NOT WRITE TO LOG FILE! : " + e.getLocalizedMessage());
        }
        adminLogShutDown();
    }




    /**
     * <p>
     *     a String with format and color :
     * </p>
     * <p>
     *     {@code [ADMIN]: {message}} for the admin console
     * </p>
     * <p>
     *     a String with format and no color :
     * </p>
     * <p>
     *     {@code "yyyy-MMM-dd hh:mm:ss - [ADMIN]: {message}} for the log file
     * </p>
     * @param message the message from the ADMIN action to be shown in admin console and written to admin log file
     * @see Colors
     */
    public static void redAdminMessageToAdminPanel(String message){
        adminLogStartUp();
        String formattedString = coloredTime() + Colors.RED_BOLD_BRIGHT+"[ADMIN ACTION]: "+Colors.BLUE_BOLD_BRIGHT+message+Colors.RESET +"\n" ;
        String formattedStringNoColor = dateFormat() + " " + timeFormat() +" - "+ "[ADMIN ACTION]: "+ message +"\n" ;

        System.out.print(formattedString);
        try{
            adminFileWriter.write(formattedStringNoColor);
        } catch (IOException e) {
            throw new RuntimeException("COULD NOT WRITE TO LOG FILE!");
        }
        adminLogShutDown();
    }






    /**
     * <p>
     *     a String with format and color :
     * </p>
     * <p>
     *     {@code [SERVER]: {message}} for the console
     * </p>
     * <p>
     *     a String with format and no color :
     * </p>
     * <p>
     *     {@code "yyyy-MMM-dd hh:mm:ss - [SERVER]: {message}} for the log file
     * </p>
     * @param message the message from the server to be shown in console and written to log file
     * @see Colors
     */
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

    /**
     * <p>
     *     a String with format and color for console and String with format and no color for log file
     * </p>
     * @param message the message from the server to be shown in console and written to log file
     * @param json the JSON String from the front app to the server
     * @see Colors
     */
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
    /**
     * <p>
     *     a String with format and color for console and String with format and no color for log file
     * </p>
     * @param message the message from the server to be shown in console and written to log file
     * @param json the JSON String from the server to the front app
     * @see Colors
     */
    public static void jsonSent(String message , String json){
        startUp();
        String formattedString = coloredTime()+ Colors.CYAN_BOLD_BRIGHT+"[SERVER]: "+Colors.YELLOW_BRIGHT + message + Colors.RESET + "\n" + Colors.BLACK_BACKGROUND_BRIGHT+ json+Colors.RESET   ;
        String formattedStringNoColor = dateFormat() + " " + timeFormat() +" - "+ "[SERVER]: "+ message +"\n" + json + "\n" ;
        System.out.print(formattedString);
        System.out.println(Colors.BLACK_BACKGROUND_BRIGHT + "\n" + Colors.RESET);
        if(!message.contains("CHUNK")){
            try{
                fileWriter.write(formattedStringNoColor);
            } catch (IOException e) {
                throw new RuntimeException("COULD NOT WRITE TO LOG FILE!" + e.getLocalizedMessage() );
            }
        }

        shutDown();
    }

    /**
     * reads all logs that are saved to the log file
     * @throws IOException
     * @see Colors
     */
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
    public static void restoreUsers() throws IOException {
        Message.cyanServerMessage("USERS RESTORED : ");
        System.out.println(Colors.BLACK_BACKGROUND_BRIGHT);

        for(User user : DataBase.loadUsers()){
            System.out.format("""
                     Name : %s %s
                     Email:%s
                    """ , user.getFirstname() , user.getLastname() , user.getEmail());
            System.out.println();
        }
        System.out.println(Colors.RESET);

    }

}
