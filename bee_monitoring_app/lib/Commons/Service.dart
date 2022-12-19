import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class Service {
  Future<String> get _directoryPath async {
    Directory? directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File('$path/data.json');
  }

  Future<List<Item>> loadData() async {
    File file = await _jsonFile;

    var response = json.decode(await file.readAsString());
    List data = response['data'];
    List<Item> list = [];
    for (var item in data) {
      list.add(
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

    return list;
  }

  String getMax(Type type, List<Item> dataArray) {
    double sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperatureInside:
          if (sum < double.parse(dataArray[i].temperatureInside)) {
            sum = double.parse(dataArray[i].temperatureInside);
          }
          break;
        case Type.temperatureOutside:
          if (sum < double.parse(dataArray[i].temperatureOutside)) {
            sum = double.parse(dataArray[i].temperatureOutside);
          }
          break;

        case Type.humidityInside:
          if (sum < double.parse(dataArray[i].humidityInside)) {
            sum = double.parse(dataArray[i].humidityInside);
          }
          break;

        case Type.humidityOutside:
          if (sum < double.parse(dataArray[i].humidityOutside)) {
            sum = double.parse(dataArray[i].humidityOutside);
          }
          break;

        case Type.sound:
          if (sum < double.parse(dataArray[i].sound)) {
            sum = double.parse(dataArray[i].sound);
          }
          break;
      }
    }
    return sum.toString();
  }

  String getMin(Type type, List<Item> dataArray) {
    double sum = 1000;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperatureInside:
          if (sum > double.parse(dataArray[i].temperatureInside)) {
            sum = double.parse(dataArray[i].temperatureInside);
          }
          break;

        case Type.temperatureOutside:
          if (sum > double.parse(dataArray[i].temperatureOutside)) {
            sum = double.parse(dataArray[i].temperatureOutside);
          }
          break;

        case Type.humidityInside:
          if (sum > double.parse(dataArray[i].humidityInside)) {
            sum = double.parse(dataArray[i].humidityInside);
          }
          break;

        case Type.humidityOutside:
          if (sum > double.parse(dataArray[i].humidityOutside)) {
            sum = double.parse(dataArray[i].humidityOutside);
          }
          break;

        case Type.sound:
          if (sum > double.parse(dataArray[i].sound)) {
            sum = double.parse(dataArray[i].sound);
          }
          break;
      }
    }
    return sum.toString();
  }

  double getAverage(Type type, List<Item> dataArray) {
    double sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperatureInside:
          sum += double.parse(dataArray[i].temperatureInside);
          break;

        case Type.temperatureOutside:
          sum += double.parse(dataArray[i].temperatureOutside);
          break;

        case Type.humidityInside:
          sum += double.parse(dataArray[i].humidityInside);
          break;

        case Type.humidityOutside:
          sum += double.parse(dataArray[i].humidityOutside);
          break;

        case Type.sound:
          sum += double.parse(dataArray[i].sound);
          break;
      }
    }
    return (sum / dataArray.length);
  }
}
