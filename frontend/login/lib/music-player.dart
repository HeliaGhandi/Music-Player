import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';
import 'package:login/json-handler.dart';
import 'package:flutter/material.dart';

/// Custom audio source to feed bytes directly to just_audio
class _ChunkedAudioSource extends StreamAudioSource {
  final Stream<Uint8List> byteStream;
  _ChunkedAudioSource(this.byteStream);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    return StreamAudioResponse(
      sourceLength: null, // unknown length
      contentLength: null,
      offset: start ?? 0,
      stream: byteStream,
      contentType: 'audio/mpeg',
    );
  }
}

/// New music player specifically for raw chunk streaming from Java server
class RawChunkMusicPlayer {
  static final RawChunkMusicPlayer _instance = RawChunkMusicPlayer._internal();
  factory RawChunkMusicPlayer() => _instance;
  RawChunkMusicPlayer._internal();

  final String serverIp = '10.0.2.2';
  final int serverPort = 9090;

  RawChunkStreamHandler? _streamHandler;
  static ValueNotifier<bool> isPlaying = ValueNotifier(false);
  static void togglePlayingState() {
    isPlaying.value = !isPlaying.value;
  }

  bool _isInitialized = false; // Track if we've set up the audio source
  Duration? _lastPosition; // Store position when pausing

  final _audioPlayer = AudioPlayer();
  StreamController<Uint8List>? _byteController;
  StreamAudioSource? _audioSource;

  Future<void> togglePlayPause({
    required Function() onDone,
    required Function(Object) onError,
    required Map<String, String> jsonRequest,
  }) async {
    print("=== RawChunkMusicPlayer.togglePlayPause STARTED ===");
    print("Current isPlaying state: $isPlaying");
    print("JSON Request received: $jsonRequest");

    if (isPlaying.value) {
      print("Pausing current playback...");
      await pause();
    } else if (_isInitialized && _streamHandler != null) {
      // Resume existing playback
      print("Resuming existing playback...");
      await resume();
    } else {
      try {
        print("Starting new playback...");

        // Prepare stream for audio data
        _byteController = StreamController<Uint8List>.broadcast();
        print("Stream controller created");

        // Connect to server FIRST, before setting up audio
        print("Creating RawChunkStreamHandler...");
        _streamHandler = RawChunkStreamHandler(
          serverIp: serverIp,
          serverPort: serverPort,
          jsonRequest: jsonRequest,
        );
        print("RawChunkStreamHandler created");

        print("Connecting to server...");
        await _streamHandler!.connectAndSend(
          (Uint8List chunkBytes) {
            print("=== CHUNK RECEIVED ===");
            print("Chunk size: ${chunkBytes.length} bytes");
            // Add received chunk to the stream
            if (_byteController != null && !_byteController!.isClosed) {
              _byteController!.add(chunkBytes);
              print("Chunk added to stream controller");

              // Start playing on first chunk
              if (_audioPlayer.playerState.playing == false) {
                _audioPlayer.play();
                print("Audio player started playing");
              }
            }
          },
          onDone: () async {
            print("=== STREAM COMPLETED ===");
            if (_byteController != null) {
              await _byteController!.close();
            }
            isPlaying = ValueNotifier(false);
            onDone();
          },
          onError: (error) async {
            print("=== STREAM ERROR ===");
            print("Stream error details: $error");
            if (_byteController != null) {
              await _byteController!.close();
            }
            isPlaying = ValueNotifier(false);
            ;
            onError(error);
          },
        );
        print("Server connection established");

        // NOW set up audio player AFTER server connection is established
        print("Setting up audio player...");
        _audioSource = _ChunkedAudioSource(_byteController!.stream);
        await _audioPlayer.setAudioSource(_audioSource!);
        print("Audio source set");

        // Don't start playing yet - wait for first chunk
        isPlaying = ValueNotifier(true);
        _isInitialized = true;
        print("Audio player ready - waiting for chunks to start playing");
      } catch (e) {
        print("=== ERROR STARTING PLAYBACK ===");
        print("Exception: $e");
        print("Stack trace: ${StackTrace.current}");
        if (_byteController != null) {
          await _byteController!.close();
        }
        isPlaying = ValueNotifier(false);
        ;
        onError(e);
      }
    }

    print("=== RawChunkMusicPlayer.togglePlayPause COMPLETED ===");
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _streamHandler?.close();
      if (_byteController != null && !_byteController!.isClosed) {
        await _byteController!.close();
      }
      isPlaying = ValueNotifier(false);
      ;
    } catch (e) {
      print('Error stopping playback: $e');
    }
  }

  Future<void> pause() async {
    if (isPlaying.value && _isInitialized) {
      _lastPosition = _audioPlayer.position;
      await _audioPlayer.pause();
      isPlaying = ValueNotifier(false);
      ;
      print("Music paused at position: $_lastPosition");
    }
  }

  Future<void> resume() async {
    if (!isPlaying.value && _isInitialized && _streamHandler != null) {
      await _audioPlayer.play();
      isPlaying = ValueNotifier(true);
      ;
      print("Music resumed from position: $_lastPosition");
    }
  }

  Future<void> seekTo(Duration position) async {
    if (_isInitialized) {
      await _audioPlayer.seek(position);
      print("Seeked to position: $position");
    }
  }

  bool get isInitialized => _isInitialized;
  Duration? get lastPosition => _lastPosition;

  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  PlayerState get playerState => _audioPlayer.playerState;
  Duration? get position => _audioPlayer.position;
  Duration? get duration => _audioPlayer.duration;
}
