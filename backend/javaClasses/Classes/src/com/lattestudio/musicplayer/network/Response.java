package com.lattestudio.musicplayer.network;

class Response {
    boolean success;
    String message;

    public Response(boolean success, String message) {
        this.success = success;
        this.message = message;

    }
}