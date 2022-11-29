import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/services/file_manager.dart';
import 'package:flutter/material.dart';

class JsonRepository extends ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  readData() async {
    final result = await FileManager().readJsonFile();

    if (result != null) {
      _items = List<Item>.from(result.map((model) => Item.fromJson(model)));
    }

    notifyListeners();
  }
}
