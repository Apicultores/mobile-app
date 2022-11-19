import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';

class HomeViewModel {
  List<String> titles = ["Médias", "Máximas", "Mínimas"];
  Service service = Service();

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

  Padding createCard(int index, List<Item> data) {
    if (index < (Type.values.length + 1)) {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(service
                      .getAverage(Type.values[index - 1], data)
                      .toStringAsFixed(2)),
                  subtitle: Text(Type.values[index - 1].value))));
    }
    if (index < (Type.values.length + 1) * 2) {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(service.getMax(
                      Type.values[index - Type.values.length - 2], data)),
                  subtitle: Text(Type.values[index - 7].value))));
    } else {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(service.getMin(
                      Type.values[index - (Type.values.length * 2) - 3], data)),
                  subtitle: Text(Type
                      .values[index - (Type.values.length * 2) - 3].value))));
    }
  }
}
