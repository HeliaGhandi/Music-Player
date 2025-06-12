package com.lattestudio.musicplayer.util.adapter;

import com.google.gson.*;

import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 * Custom Gson adapter to handle serialization and deserialization of {@link LocalTime} objects.
 * <p>
 * This adapter converts {@code LocalTime} to a JSON string in ISO-8601 format
 * (e.g., {@code "10:15:30"}) and vice versa.
 * </p>
 * <p>
 * Useful when using Gson with Java 8 time types that are not natively supported.
 * </p>
 *
 * @author GPT
 */
// LocalTime adapter
public class LocalTimeAdapter implements JsonSerializer<LocalTime>, JsonDeserializer<LocalTime> {
    //Properties :
    private static final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_TIME;

    //Methods :


    /**
     * Serializes a {@link LocalTime} into its ISO-8601 string representation.
     *
     * @param src the {@code LocalTime} object to serialize
     * @param typeOfSrc the actual type of the source object (ignored in this implementation)
     * @param context the context for serialization (unused)
     * @return a {@link JsonPrimitive} containing the formatted time string
     */
    @Override
    public JsonElement serialize(LocalTime src, Type typeOfSrc, JsonSerializationContext context) {
        return new JsonPrimitive(src.format(formatter));
    }
    /**
     * Deserializes an ISO-8601 formatted time string into a {@link LocalTime} object.
     *
     * @param json the {@code JsonElement} containing the time string
     * @param typeOfT the target type of the deserialization (expected to be {@code LocalTime})
     * @param context the context for deserialization (unused)
     * @return the parsed {@code LocalTime} object
     * @throws JsonParseException if the JSON is not a properly formatted time string
     */
    @Override
    public LocalTime deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
            throws JsonParseException {
        return LocalTime.parse(json.getAsString(), formatter);
    }
}