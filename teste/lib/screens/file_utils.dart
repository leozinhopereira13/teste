import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
 Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
}

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  //Future<int> readCounter() async {
  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      //return int.parse(contents);
	return contents ;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(counter);
  }
}
