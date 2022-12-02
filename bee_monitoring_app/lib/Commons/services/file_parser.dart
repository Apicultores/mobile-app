import 'dart:convert';
import 'dart:isolate';

import '../Models/Item.dart';

class FilesParser {
  // 1. pass the encoded json as a constructor argument
  FilesParser(this.encodedJson);
  final String encodedJson;

  // 2. public method that does the parsing in the background
  Future<List<Item>> parseInBackground() async {
    // create a port
    final p = ReceivePort();
    // spawn the isolate and wait for it to complete
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    // get and return the result data
    return await p.first;
  }

  // 3. json parsing
  Future<void> _decodeAndParseJson(SendPort p) async {
    // decode and parse the json
    final jsonData = jsonDecode(encodedJson);
    final resultsJson = jsonData['results'] as List<dynamic>;
    final results = resultsJson.map((json) => Item.fromJson(json)).toList();
    // return the result data via Isolate.exit()
    Isolate.exit(p, results);
  }
}
