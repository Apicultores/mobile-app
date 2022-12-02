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
    String fileContent = 'Cheetah Coding';

    File file = await _jsonFile;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
        final fileParser = FilesParser(fileContent);
        return await fileParser.parseInBackground();
      } catch (e) {
        print(e);
      }
    }

    return null;
  }

  // Future<User> writeJsonFile() async {
  //   final User user = User('Julian', 36, ['Jewels', 'Juice', 'J']);

  //   File file = await _jsonFile;
  //   await file.writeAsString(json.encode(user));
  //   return user;
  // }
}
