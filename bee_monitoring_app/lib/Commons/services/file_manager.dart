import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/services/file_parser.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static FileManager? _instance;

  FileManager._internal() {
    _instance = this;
  }

  factory FileManager() => _instance ?? FileManager._internal();

  Future<String> get _directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File('$path/data.json');
  }

  readJsonFile() async {
    String fileContent = '';

    File file = await _jsonFile;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
        print(fileContent);
        // final fileParser = FilesParser(fileContent.trim());
        // return await fileParser.parseInBackground();
      } catch (e) {
        print(e);
      }
    }

    return null;
  }

  Future<void> writeJsonFile(List<int> subscribeStreamValue) async {
    try {
      File file = await _jsonFile;

      String _data = String.fromCharCodes(subscribeStreamValue);
      await file.writeAsString(_data, mode: FileMode.append);
    } catch (e) {
      print(e);
    }
  }
}
