import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:bee_monitoring_app/Scenes/TimeLine/Timeline.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';
import 'package:bee_monitoring_app/Scenes/Home/Home.dart';
import 'package:bee_monitoring_app/Scenes/Chart/Chart.dart';
import 'package:intl/intl.dart';

class Service {
  Future<List<Item>> loadData() async {
    var path = await rootBundle.loadString("assets/mockData.json");

    var response = json.decode(path);
    List data = response['data'];
    List<Item> list = [];

    for (var item in data) {
      list.add(Item(
          item['id'].toString(),
          item['temperatura_dentro'].toString(),
          item['temperatura_fora'].toString(),
          item['umidade_dentro'].toString(),
          item['umidade_fora'].toString(),
          item['som'].toString(),
          DateFormat("yyyy-MM-dd hh:mm:ss").parse(item['timestamp'])));
    }

    return list;
  }

  String getMax(Type type, List<Item> dataArray) {
    var sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperatureInside:
          if (sum < int.parse(dataArray[i].temperatureInside)) {
            sum = int.parse(dataArray[i].temperatureInside);
          }
          break;
        case Type.temperatureOutside:
          if (sum < int.parse(dataArray[i].temperatureOutside)) {
            sum = int.parse(dataArray[i].temperatureOutside);
          }
          break;

        case Type.humidityInside:
          if (sum < int.parse(dataArray[i].humidityInside)) {
            sum = int.parse(dataArray[i].humidityInside);
          }
          break;

        case Type.humidityOutside:
          if (sum < int.parse(dataArray[i].humidityOutside)) {
            sum = int.parse(dataArray[i].humidityOutside);
          }
          break;

        case Type.sound:
          if (sum < int.parse(dataArray[i].sound)) {
            sum = int.parse(dataArray[i].sound);
          }
          break;
      }
    }
    return sum.toString();
  }

  String getMin(Type type, List<Item> dataArray) {
    var sum = 1000;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperatureInside:
          if (sum > int.parse(dataArray[i].temperatureInside)) {
            sum = int.parse(dataArray[i].temperatureInside);
          }
          break;

        case Type.temperatureOutside:
          if (sum > int.parse(dataArray[i].temperatureOutside)) {
            sum = int.parse(dataArray[i].temperatureOutside);
          }
          break;

        case Type.humidityInside:
          if (sum > int.parse(dataArray[i].humidityInside)) {
            sum = int.parse(dataArray[i].humidityInside);
          }
          break;

        case Type.humidityOutside:
          if (sum > int.parse(dataArray[i].humidityOutside)) {
            sum = int.parse(dataArray[i].humidityOutside);
          }
          break;

        case Type.sound:
          if (sum > int.parse(dataArray[i].sound)) {
            sum = int.parse(dataArray[i].sound);
          }
          break;
      }
    }
    return sum.toString();
  }

  double getAverage(Type type, List<Item> dataArray) {
    var sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperatureInside:
          sum += int.parse(dataArray[i].temperatureInside);
          break;

        case Type.temperatureOutside:
          sum += int.parse(dataArray[i].temperatureOutside);
          break;

        case Type.humidityInside:
          sum += int.parse(dataArray[i].humidityInside);
          break;

        case Type.humidityOutside:
          sum += int.parse(dataArray[i].humidityOutside);
          break;

        case Type.sound:
          sum += int.parse(dataArray[i].sound);
          break;
      }
    }
    return (sum / dataArray.length);
  }
}
