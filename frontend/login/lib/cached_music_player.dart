import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';
import 'package:login/json-handler.dart';
import 'package:login/music_cache_manager.dart';
import 'package:flutter/material.dart';

/// Enhanced music player with automatic caching support
class CachedMusicPlayer {
  static final CachedMusicPlayer _instance = CachedMusicPlayer._internal();
  factory CachedMusicPlayer() => _instance;
  CachedMusicPlayer._internal();

  final String serverIp = '10.0.2.2';
  final int serverPort = 9090;
  final MusicCacheManager _cacheManager = MusicCacheManager();

  RawChunkStreamHandler? _streamHandler;
  static ValueNotifier<bool> isPlaying = ValueNotifier(false);
  static ValueNotifier<String> currentMusicName = ValueNotifier('');
  static ValueNotifier<bool> isCached = ValueNotifier(false);

  static void togglePlayingState() {
    isPlaying.value = !isPlaying.value;
  }

  bool _isInitialized = false;
  Duration? _lastPosition;
  final _audioPlayer = AudioPlayer();
  StreamController<Uint8List>? _byteController;
  StreamAudioSource? _audioSource;

  // Cache-related variables
  bool _isCaching = false;
  StreamController<Uint8List>? _cacheStreamController;

  /// Initialize the cache manager
  Future<void> initialize() async {
    await _cacheManager.initialize();
  }

  /// Check if music is cached
  Future<bool> checkIfCached(String musicName) async {
    final cached = await _cacheManager.isCached(musicName);
    isCached.value = cached;
    return cached;
  }

  /// Play music with automatic caching
  Future<void> playMusic({
    required String musicName,
    required Function() onDone,
    required Function(Object) onError,
    bool forceStream = false, // Force streaming even if cached
  }) async {
    print("=== CachedMusicPlayer.playMusic STARTED ===");
    print("Music name: $musicName, Force stream: $forceStream");

    try {
      // Initialize cache manager if not already done
      await initialize();

      // Check if music is cached
      final cached = await checkIfCached(musicName);
      currentMusicName.value = musicName;

      if (cached && !forceStream) {
        print("Playing from cache: $musicName");
        await _playFromCache(musicName, onDone, onError);
      } else {
        print("Streaming and caching: $musicName");
        await _streamAndCache(musicName, onDone, onError);
      }
    } catch (e) {
      print("=== ERROR IN playMusic ===");
      print("Exception: $e");
      onError(e);
    }
  }

  /// Play music from local cache
  Future<void> _playFromCache(
    String musicName,
    Function() onDone,
    Function(Object) onError,
  ) async {
    try {
      print("=== Playing from cache ===");

      // Get cached file path
      final filePath = await _cacheManager.getCachedFilePath(musicName);
      if (filePath == null) {
        throw Exception('Cached file not found');
      }

      // Set audio source from file
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.file(filePath)));

      // Start playing
      await _audioPlayer.play();
      isPlaying.value = true;
      _isInitialized = true;

      print("Successfully playing from cache: $musicName");

      // Listen for completion
      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          onDone();
        }
      });
    } catch (e) {
      print("Error playing from cache: $e");
      // Fallback to streaming if cache fails
      await _streamAndCache(musicName, onDone, onError);
    }
  }

  /// Stream music and cache it simultaneously
  Future<void> _streamAndCache(
    String musicName,
    Function() onDone,
    Function(Object) onError,
  ) async {
    try {
      print("=== Streaming and caching ===");

      // Prepare stream for audio data
      _byteController = StreamController<Uint8List>.broadcast();
      _cacheStreamController = StreamController<Uint8List>.broadcast();

      // Connect to server
      _streamHandler = RawChunkStreamHandler(
        serverIp: serverIp,
        serverPort: serverPort,
        jsonRequest: {"command": "MUSIC_REQUEST", "musicName": musicName},
      );

      await _streamHandler!.connectAndSend(
        (Uint8List chunkBytes) async {
          print("=== CHUNK RECEIVED ===");
          print("Chunk size: ${chunkBytes.length} bytes");

          if (_byteController != null && !_byteController!.isClosed) {
            _byteController!.add(chunkBytes);
          }

          // Cache the chunk
          if (_cacheStreamController != null &&
              !_cacheStreamController!.isClosed) {
            _cacheStreamController!.add(chunkBytes);
          }

          // Start playing on first chunk
          if (_audioPlayer.playerState.playing == false) {
            _audioPlayer.play();
            print("Audio player started playing");
          }
        },
        onDone: () async {
          print("=== STREAM COMPLETED ===");
          await _finalizeCaching(musicName);
          await _closeStreams();
          onDone();
        },
        onError: (error) async {
          print("=== STREAM ERROR ===");
          print("Error details: $error");
          await _closeStreams();
          onError(error);
        },
      );

      // Set up audio player
      _audioSource = _ChunkedAudioSource(_byteController!.stream);
      await _audioPlayer.setAudioSource(_audioSource!);

      // Start caching in background
      _startCaching(musicName);

      isPlaying.value = true;
      _isInitialized = true;

      print("Streaming and caching setup completed");
    } catch (e) {
      print("Error in streaming and caching: $e");
      await _closeStreams();
      onError(e);
    }
  }

  /// Start caching music in background
  Future<void> _startCaching(String musicName) async {
    if (_isCaching) return;

    _isCaching = true;
    try {
      print("=== Starting background caching ===");

      // Cache the music from the stream
      final success = await _cacheManager.cacheMusicFromChunks(
        musicName,
        _cacheStreamController!.stream,
      );

      if (success) {
        print("Background caching completed successfully");
        isCached.value = true;
      } else {
        print("Background caching failed");
      }
    } catch (e) {
      print("Error in background caching: $e");
    } finally {
      _isCaching = false;
    }
  }

  /// Finalize caching when stream completes
  Future<void> _finalizeCaching(String musicName) async {
    if (_cacheStreamController != null && !_cacheStreamController!.isClosed) {
      await _cacheStreamController!.close();
    }

    // Update cache status
    await checkIfCached(musicName);
  }

  /// Close all streams
  Future<void> _closeStreams() async {
    if (_byteController != null && !_byteController!.isClosed) {
      await _byteController!.close();
    }
    if (_cacheStreamController != null && !_cacheStreamController!.isClosed) {
      await _cacheStreamController!.close();
    }
  }

  /// Toggle play/pause
  Future<void> togglePlayPause({
    required String musicName,
    required Function() onDone,
    required Function(Object) onError,
  }) async {
    print("=== CachedMusicPlayer.togglePlayPause STARTED ===");

    if (isPlaying.value) {
      await pause();
    } else if (_isInitialized && currentMusicName.value == musicName) {
      await resume();
    } else {
      await playMusic(musicName: musicName, onDone: onDone, onError: onError);
    }
  }

  /// Stop playback
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _streamHandler?.close();
      await _closeStreams();
      isPlaying.value = false;
      _isInitialized = false;
    } catch (e) {
      print('Error stopping playback: $e');
    }
  }

  /// Pause playback
  Future<void> pause() async {
    if (isPlaying.value && _isInitialized) {
      _lastPosition = _audioPlayer.position;
      await _audioPlayer.pause();
      isPlaying.value = false;
      print("Music paused at position: $_lastPosition");
    }
  }

  /// Resume playback
  Future<void> resume() async {
    if (!isPlaying.value && _isInitialized) {
      await _audioPlayer.play();
      isPlaying.value = true;
      print("Music resumed from position: $_lastPosition");
    }
  }

  /// Seek to position
  Future<void> seekTo(Duration position) async {
    if (_isInitialized) {
      await _audioPlayer.seek(position);
      print("Seeked to position: $position");
    }
  }

  /// Get cache statistics
  Future<Map<String, dynamic>> getCacheStats() async {
    return await _cacheManager.getCacheStats();
  }

  /// Clear cache
  Future<bool> clearCache() async {
    return await _cacheManager.clearCache();
  }

  /// Remove specific music from cache
  Future<bool> removeFromCache(String musicName) async {
    return await _cacheManager.removeFromCache(musicName);
  }

  // Getters
  bool get isInitialized => _isInitialized;
  Duration? get lastPosition => _lastPosition;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  PlayerState get playerState => _audioPlayer.playerState;
  Duration? get position => _audioPlayer.position;
  Duration? get duration => _audioPlayer.duration;
}

/// Custom audio source for chunked streaming
class _ChunkedAudioSource extends StreamAudioSource {
  final Stream<Uint8List> byteStream;
  _ChunkedAudioSource(this.byteStream);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    return StreamAudioResponse(
      sourceLength: null,
      contentLength: null,
      offset: start ?? 0,
      stream: byteStream,
      contentType: 'audio/mpeg',
    );
  }
}
