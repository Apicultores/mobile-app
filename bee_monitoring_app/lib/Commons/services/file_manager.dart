import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'file_parser.dart';

class FileManager {
  static FileManager? _instance;

  FileManager._internal() {
    _instance = this;
  }

  factory FileManager() => _instance ?? FileManager._internal();

  Future<String> get _directoryPath async {
    Directory? directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File('$path/data.json');
  }

  readJsonFile() async {
    File file = await _jsonFile;

    if (await file.exists()) {
      try {
        String fileContent = await file.readAsString();
        final fileParser = FilesParser(fileContent.trim());
        return await fileParser.parseInBackground();
      } catch (e) {
        print(e);
      }
    }

    return null;
  }

  Future<void> writeJsonFile(List<int> subscribeStreamValue) async {
    try {
      File file = await _jsonFile;
      if (await file.exists()) {
        await file.delete();
      }
      String data = String.fromCharCodes(subscribeStreamValue);
      await file.writeAsString(data, mode: FileMode.append);
    } catch (e) {
      print(e);
    }
  }

  Future<void> exportJson(BuildContext context) async {
    try {
      dynamic path = await _directoryPath;
      await Share.shareFiles(['$path/data.json']);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Erro ao exportar dados, nenhum dado encontrado"),
        ),
      );
    }
  }
}
