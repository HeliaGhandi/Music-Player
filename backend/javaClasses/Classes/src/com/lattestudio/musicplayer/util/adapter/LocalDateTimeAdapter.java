/*
TO-DO-LIST :

 */
package com.lattestudio.musicplayer.util.adapter;

import com.google.gson.*;

import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Custom Gson adapter to handle serialization and deserialization of {@link LocalDateTime} objects.
 * <p>
 * This adapter converts {@code LocalDateTime} to a JSON string in ISO-8601 format
 * (e.g., {@code "2025-06-12T10:15:30"}) and vice versa.
 * </p>
 * <p>
 * Useful when working with JSON libraries like Gson that do not support Java 8 time types out of the box.
 * </p>
 * <p>created to help Gson Serialize LocalDateTime objects by chatGPT</p>
 *
 * @author GPT
 */
public class LocalDateTimeAdapter implements JsonSerializer<LocalDateTime>, JsonDeserializer<LocalDateTime> {
    //Properties :
    private static final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

    //Methods :

    /**
     * Serializes a {@link LocalDateTime} into its ISO-8601 string representation.
     *
     * @param src the {@code LocalDateTime} object to serialize
     * @param typeOfSrc the actual type of the source object (ignored in this implementation)
     * @param context the context for serialization (unused)
     * @return a {@link JsonPrimitive} containing the formatted date-time string
     */
    @Override
    public JsonElement serialize(LocalDateTime src, Type typeOfSrc, JsonSerializationContext context) {
        return new JsonPrimitive(src.format(formatter));
    }

    /**
     * Deserializes an ISO-8601 formatted date-time string into a {@link LocalDateTime} object.
     *
     * @param json the {@code JsonElement} containing the date-time string
     * @param typeOfT the target type of the deserialization (expected to be {@code LocalDateTime})
     * @param context the context for deserialization (unused)
     * @return the parsed {@code LocalDateTime} object
     * @throws JsonParseException if the JSON is not a properly formatted date-time string
     */
    @Override
    public LocalDateTime deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
            throws JsonParseException {
        return LocalDateTime.parse(json.getAsString(), formatter);
    }
}
