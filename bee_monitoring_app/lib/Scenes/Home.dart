import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';

class Home extends StatelessWidget {
  final List<Item> data;
  Home(this.data);

  List<String> titles = ["Médias", "Máximas", "Mínimas"];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 10),
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
                  title: Text(getMax(Type.values[index - 7], data)),
                  subtitle: Text(Type.values[index - 7].value))));
    } else {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(getMin(Type.values[index - 13], data)),
                  subtitle: Text(Type.values[index - 13].value))));
    }
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

  String getAverage(Type type, List<Item> dataArray) {
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
    return (sum / dataArray.length).toStringAsFixed(2);
  }
}
