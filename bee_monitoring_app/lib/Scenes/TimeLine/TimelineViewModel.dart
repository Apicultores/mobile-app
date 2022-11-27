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
      case Type.humidityInside:
        String humidityInside = item.humidityInside;
        String humidityOutside = item.humidityOutside;
        return "Interna $humidityInside  g/m³\n\nExterna $humidityOutside g/m³\n";
      case Type.sound:
        return "${item.sound} dB";
      default:
        return "";
    }
  }

    Widget createHeader() {
    return Container(
      color: Colors.white,
      child: (Row(
        children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(left: 15, bottom: 15, right: 20, top: 20),
              child: Text(
                "Coleta (ID123123 : 22/11/2020)",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal),
              )),
          Expanded(child: Container()),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(primary: Colors.white),
            child: Icon(
              Icons.more_vert_sharp,
              size: 24.0,
            ),
          ),
          SizedBox(width: 10),
        ],
      )),
    );
  }
}
