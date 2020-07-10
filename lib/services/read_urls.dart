import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class ReadURLFromFile {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/urls.txt');
  }

  Future<File> writeURL(String url) async {
    final file = await _localFile;
    return file.writeAsString('$url');
  }

  Future<List<String>> readURLs() async {
    try {
      final file = await _localFile;
      List<String> contents = await file.readAsLines();
      return contents;
    } catch (e) {
      return null;
    }
  }
}
