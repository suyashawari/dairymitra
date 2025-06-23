  // import 'dart:io';
  // import 'package:path_provider/path_provider.dart';
  //
  // class StorageService {
  //   static Future<Directory> getPersistentDirectory() async {
  //     if (Platform.isAndroid || Platform.isIOS) {
  //       return getApplicationDocumentsDirectory();
  //     } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
  //       return getApplicationSupportDirectory();
  //     } else {
  //       throw UnsupportedError('Platform not supported');
  //     }
  //   }
  //
  //   static Future<File> getLocalFile(String fileName) async {
  //     final directory = await getPersistentDirectory();
  //     return File('${directory.path}/$fileName');
  //   }
  //
  //   static Future<void> ensureInitialized() async {
  //     try {
  //       final dir = await getPersistentDirectory();
  //       if (!await dir.exists()) {
  //         await dir.create(recursive: true);
  //       }
  //     } catch (e) {
  //       print('Error initializing storage: $e');
  //     }
  //   }
  // }