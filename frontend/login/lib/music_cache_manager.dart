import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:async';

/// Manages local caching of music files for offline playback
class MusicCacheManager {
  static final MusicCacheManager _instance = MusicCacheManager._internal();
  factory MusicCacheManager() => _instance;
  MusicCacheManager._internal();

  static const String _cacheDirName = 'music_cache';
  static const int _maxCacheSize = 500 * 1024 * 1024; // 500MB max cache size

  Directory? _cacheDir;
  final Map<String, String> _fileMetadata = {};
  final Map<String, DateTime> _lastAccessed = {};

  /// Initialize the cache manager
  Future<void> initialize() async {
    if (_cacheDir != null) return;

    try {
      final appDir = await getApplicationDocumentsDirectory();
      _cacheDir = Directory('${appDir.path}/$_cacheDirName');

      if (!await _cacheDir!.exists()) {
        await _cacheDir!.create(recursive: true);
      }

      // Load existing metadata
      await _loadMetadata();

      // Clean up old files if cache is too large
      await _cleanupCache();

      print('Music cache manager initialized at: ${_cacheDir!.path}');
    } catch (e) {
      print('Error initializing cache manager: $e');
    }
  }

  /// Get the cache directory path
  String? get cachePath => _cacheDir?.path;

  /// Check if a music file is cached
  Future<bool> isCached(String musicName) async {
    await initialize();
    final fileName = _getFileName(musicName);
    final file = File('${_cacheDir!.path}/$fileName');
    return await file.exists();
  }

  /// Get cached music file path
  Future<String?> getCachedFilePath(String musicName) async {
    if (!await isCached(musicName)) return null;

    final fileName = _getFileName(musicName);
    final filePath = '${_cacheDir!.path}/$fileName';

    // Update last accessed time
    _lastAccessed[musicName] = DateTime.now();
    await _saveMetadata();

    return filePath;
  }

  /// Cache music data from base64 chunks
  Future<bool> cacheMusicFromChunks(
    String musicName,
    Stream<Uint8List> chunkStream,
  ) async {
    await initialize();

    try {
      final fileName = _getFileName(musicName);
      final filePath = '${_cacheDir!.path}/$fileName';
      final file = File(filePath);

      // Create a temporary file first
      final tempFile = File('$filePath.tmp');

      // Write chunks to temporary file
      final sink = tempFile.openWrite();
      int totalBytes = 0;

      await for (final chunk in chunkStream) {
        sink.add(chunk);
        totalBytes += chunk.length;
      }

      await sink.close();

      // Verify the file was written correctly
      if (await tempFile.exists() && await tempFile.length() == totalBytes) {
        // Move temporary file to final location
        await tempFile.rename(filePath);

        // Update metadata
        _fileMetadata[musicName] = fileName;
        _lastAccessed[musicName] = DateTime.now();
        await _saveMetadata();

        print('Successfully cached music: $musicName (${totalBytes} bytes)');
        return true;
      } else {
        // Clean up failed cache attempt
        if (await tempFile.exists()) {
          await tempFile.delete();
        }
        print('Failed to cache music: $musicName - file verification failed');
        return false;
      }
    } catch (e) {
      print('Error caching music $musicName: $e');
      return false;
    }
  }

  /// Cache music from base64 string
  Future<bool> cacheMusicFromBase64(String musicName, String base64Data) async {
    await initialize();

    try {
      final fileName = _getFileName(musicName);
      final filePath = '${_cacheDir!.path}/$fileName';
      final file = File(filePath);

      // Decode base64 and write to file
      final bytes = base64.decode(base64Data);
      await file.writeAsBytes(bytes);

      // Update metadata
      _fileMetadata[musicName] = fileName;
      _lastAccessed[musicName] = DateTime.now();
      await _saveMetadata();

      print(
        'Successfully cached music from base64: $musicName (${bytes.length} bytes)',
      );
      return true;
    } catch (e) {
      print('Error caching music from base64 $musicName: $e');
      return false;
    }
  }

  /// Get cached music as bytes
  Future<Uint8List?> getCachedMusicBytes(String musicName) async {
    if (!await isCached(musicName)) return null;

    try {
      final filePath = await getCachedFilePath(musicName);
      if (filePath == null) return null;

      final file = File(filePath);
      return await file.readAsBytes();
    } catch (e) {
      print('Error reading cached music $musicName: $e');
      return null;
    }
  }

  /// Get cached music as a stream
  Stream<Uint8List> getCachedMusicStream(String musicName) async* {
    if (!await isCached(musicName)) return;

    try {
      final filePath = await getCachedFilePath(musicName);
      if (filePath == null) return;

      final file = File(filePath);
      final stream = file.openRead();

      await for (final chunk in stream) {
        yield Uint8List.fromList(chunk);
      }
    } catch (e) {
      print('Error streaming cached music $musicName: $e');
    }
  }

  /// Remove a specific music file from cache
  Future<bool> removeFromCache(String musicName) async {
    await initialize();

    try {
      final fileName = _getFileName(musicName);
      final filePath = '${_cacheDir!.path}/$fileName';
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();

        // Remove from metadata
        _fileMetadata.remove(musicName);
        _lastAccessed.remove(musicName);
        await _saveMetadata();

        print('Removed from cache: $musicName');
        return true;
      }
      return false;
    } catch (e) {
      print('Error removing from cache $musicName: $e');
      return false;
    }
  }

  /// Clear all cached music
  Future<bool> clearCache() async {
    await initialize();

    try {
      if (await _cacheDir!.exists()) {
        await _cacheDir!.delete(recursive: true);
        await _cacheDir!.create();
      }

      _fileMetadata.clear();
      _lastAccessed.clear();
      await _saveMetadata();

      print('Cache cleared successfully');
      return true;
    } catch (e) {
      print('Error clearing cache: $e');
      return false;
    }
  }

  /// Get cache statistics
  Future<Map<String, dynamic>> getCacheStats() async {
    await initialize();

    try {
      int totalFiles = 0;
      int totalSize = 0;
      List<String> cachedMusic = [];

      if (await _cacheDir!.exists()) {
        final files = _cacheDir!.listSync();
        for (final file in files) {
          if (file is File && file.path.endsWith('.mp3')) {
            totalFiles++;
            totalSize += await file.length();
            cachedMusic.add(file.path.split('/').last.replaceAll('.mp3', ''));
          }
        }
      }

      return {
        'totalFiles': totalFiles,
        'totalSize': totalSize,
        'cachedMusic': cachedMusic,
        'cachePath': _cacheDir?.path,
      };
    } catch (e) {
      print('Error getting cache stats: $e');
      return {};
    }
  }

  /// Generate a unique filename for the music
  String _getFileName(String musicName) {
    // Create a hash of the music name to avoid special characters in filenames
    final hash = sha256
        .convert(utf8.encode(musicName))
        .toString()
        .substring(0, 16);
    return '${hash}_${musicName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.mp3';
  }

  /// Load metadata from file
  Future<void> _loadMetadata() async {
    try {
      final metadataFile = File('${_cacheDir!.path}/metadata.json');
      if (await metadataFile.exists()) {
        final content = await metadataFile.readAsString();
        final data = jsonDecode(content) as Map<String, dynamic>;

        _fileMetadata.clear();
        _lastAccessed.clear();

        if (data['files'] != null) {
          final files = data['files'] as Map<String, dynamic>;
          for (final entry in files.entries) {
            _fileMetadata[entry.key] = entry.value.toString();
          }
        }

        if (data['lastAccessed'] != null) {
          final lastAccessed = data['lastAccessed'] as Map<String, dynamic>;
          for (final entry in lastAccessed.entries) {
            _lastAccessed[entry.key] = DateTime.parse(entry.value.toString());
          }
        }
      }
    } catch (e) {
      print('Error loading metadata: $e');
    }
  }

  /// Save metadata to file
  Future<void> _saveMetadata() async {
    try {
      final metadataFile = File('${_cacheDir!.path}/metadata.json');

      final data = {
        'files': _fileMetadata,
        'lastAccessed': _lastAccessed.map(
          (key, value) => MapEntry(key, value.toIso8601String()),
        ),
      };

      await metadataFile.writeAsString(jsonEncode(data));
    } catch (e) {
      print('Error saving metadata: $e');
    }
  }

  /// Clean up cache if it exceeds maximum size
  Future<void> _cleanupCache() async {
    try {
      final stats = await getCacheStats();
      int totalSize = stats['totalSize'] as int? ?? 0;

      if (totalSize > _maxCacheSize) {
        print(
          'Cache size (${totalSize ~/ (1024 * 1024)}MB) exceeds limit, cleaning up...',
        );

        // Sort files by last accessed time (oldest first)
        final sortedFiles =
            _lastAccessed.entries.toList()
              ..sort((a, b) => a.value.compareTo(b.value));

        // Remove oldest files until we're under the limit
        for (final entry in sortedFiles) {
          if (totalSize <= _maxCacheSize) break;

          final removed = await removeFromCache(entry.key);
          if (removed) {
            // Recalculate total size
            final newStats = await getCacheStats();
            totalSize = newStats['totalSize'] as int? ?? 0;
          }
        }

        print(
          'Cache cleanup completed. New size: ${totalSize ~/ (1024 * 1024)}MB',
        );
      }
    } catch (e) {
      print('Error during cache cleanup: $e');
    }
  }
}
