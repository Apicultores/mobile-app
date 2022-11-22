import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:intl/intl.dart';

class TimelineViewModel {
  DateFormat dateFormat = DateFormat("HH:mm:ss - dd/MM/yyyy");

  Widget buildSegment(String text) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }

  Card buildCard(Type type, Item item) {
    return Card(
        child: ListTile(
            title: Text(getParameter(type, item)),
            subtitle: Text(dateFormat.format(item.timestamp))));
  }

  String getParameter(Type type, Item item) {
    switch (type) {
      case Type.temperatureInside:
        String temperatureInside = item.temperatureInside;
        String temperatureOutside = item.temperatureOutside;
        return "Interna $temperatureInside  °C\n\nExterna $temperatureOutside °C\n";
      case Type.temperatureOutside:
        return item.temperatureOutside;
      case Type.humidityInside:
        String humidityInside = item.humidityInside;
        String humidityOutside = item.humidityOutside;
        return "Interna $humidityInside  g/m³\n\nExterna $humidityOutside g/m³\n";
      case Type.humidityOutside:
        return item.humidityOutside;
      case Type.sound:
        return "${item.sound} dB";
    }
  }
}
