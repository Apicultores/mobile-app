import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:developer';

class Home extends StatelessWidget {
  final List<Item> data;
  Home(this.data);

  List<String> titles = ["Médias", "Máximas", "Mínimas"];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
        itemCount: (Type.values.length + 1) * titles.length,
        itemBuilder: (context, index) {
          return createCell(index);
        });
  }

  Padding createCell(int index) {
    return index % (Type.values.length + 1) == 0
        ? createTitle(index)
        : createCard(index);
  }

  Padding createTitle(int index) {
    return Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
        child: Text(
          titles[(index / (Type.values.length + 1)).toInt()],
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ));
  }

  Padding createCard(int index) {
    if (index < (Type.values.length + 1)) {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(getAverage(Type.values[index - 1], data)),
                  subtitle: Text(Type.values[index - 1].value))));
    }
    if (index < (Type.values.length + 1) * 2) {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(getMax(Type.values[index - 1 - 4], data)),
                  subtitle: Text(Type.values[index - 1 - 4].value))));
    } else {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(getMin(Type.values[index - 1 - 8], data)),
                  subtitle: Text(Type.values[index - 1 - 8].value))));
    }
  }

  String getMax(Type type, List<Item> dataArray) {
    var sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperature:
          if (sum < int.parse(dataArray[i].temperature)) {
            sum = int.parse(dataArray[i].temperature);
          }
          break;
        case Type.humidity:
          if (sum < int.parse(dataArray[i].humidity)) {
            sum = int.parse(dataArray[i].humidity);
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
        case Type.temperature:
          if (sum > int.parse(dataArray[i].temperature)) {
            sum = int.parse(dataArray[i].temperature);
          }
          break;
        case Type.humidity:
          if (sum > int.parse(dataArray[i].humidity)) {
            sum = int.parse(dataArray[i].humidity);
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

  String getAverage(Type type, List<Item> dataArray) {
    var sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperature:
          sum += int.parse(dataArray[i].temperature);
          break;
        case Type.humidity:
          sum += int.parse(dataArray[i].humidity);
          break;
        case Type.sound:
          sum += int.parse(dataArray[i].sound);
          break;
      }
    }
    return (sum / dataArray.length).toStringAsFixed(2);
  }
}
