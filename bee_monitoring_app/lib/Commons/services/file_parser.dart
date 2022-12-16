import 'dart:convert';
import 'dart:isolate';
import 'package:intl/intl.dart';

import '../Models/Item.dart';

class FilesParser {
  // 1. pass the encoded json as a constructor argument
  FilesParser(this.encodedJson);
  final String encodedJson;

  // 2. public method that does the parsing in the background
  Future<List<Item>> parseInBackground() async {
    // create a port
    // final p = ReceivePort();
    // spawn the isolate and wait for it to complete
    // await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    // get and return the result data
    return await _decodeAndParseJson();
  }

  // 3. json parsing
  Future<List<Item>> _decodeAndParseJson() async {
    // decode and parse the json
    final jsonData = jsonDecode(encodedJson);
    final resultsJson = jsonData['data'] as List<dynamic>;
    List<Item> results = [];
    for (var item in resultsJson) {
      results.add(
        Item(
          item!['ti'].toString(),
          item!['te'].toString(),
          item!['ui'].toString(),
          item!['ue'].toString(),
          item!['s'].toString(),
          DateFormat("yyyy-MM-dd hh:mm:ss").parse(item!['ts']),
        ),
      );
    }
    return results;
  }
}
