package com.lattestudio.musicplayer.util;

import java.util.Random;
/**
 * Utility class for mathematical operations related to the Latte Studio music player.
 * <p>
 * Currently provides functionality for generating random verification codes.
 * </p>
 *
 * @author ChatGPT
 * @since v0.1.8
 */
public class Math {
    private Math(){
        throw new UnsupportedOperationException("Utility class");
    } //util class :)


    // Generates a random 4-digit code
    /**
     * Generates a random 4-digit numeric verification code as a String.
     * <p>
     * The code is guaranteed to be between 1000 and 9999 inclusive.
     * </p>
     *
     * @return A randomly generated 4-digit verification code as a String.
     * @since v0.1.8
     * @author GPT
     */
    public static String generateCode() {
        Random random = new Random();
        int code = 1000 + random.nextInt(9000);
        return String.valueOf(code);
    }
}
