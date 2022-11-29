import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';
import 'package:bee_monitoring_app/Commons/Enums/HomeWidgetType.dart';

class HomeViewModel {
  Service service = Service();

  List<HomeWidgetType> cellList = [
    HomeWidgetType.header,
    HomeWidgetType.title,
    HomeWidgetType.averageTemperature,
    HomeWidgetType.averageHumidity,
    HomeWidgetType.averageSound,
    HomeWidgetType.title,
    HomeWidgetType.maxTemperature,
    HomeWidgetType.maxHumidity,
    HomeWidgetType.maxSound,
    HomeWidgetType.title,
    HomeWidgetType.minTemperature,
    HomeWidgetType.minHumidity,
    HomeWidgetType.minSound
  ];

  Widget createWidget(int index, List<Item> data) {
    switch (cellList[index]) {
      case HomeWidgetType.header:
        return createHeader();
      case HomeWidgetType.averageTemperature:
        return createCard("Temperatura",
            "${service.getAverage(Type.temperatureInside, data).toStringAsFixed(2)} °C",
            subtitleTail:
                "${service.getAverage(Type.temperatureOutside, data).toStringAsFixed(2)} °C");
      case HomeWidgetType.averageHumidity:
        return createCard("Umidade",
            "${service.getAverage(Type.humidityInside, data).toStringAsFixed(2)} g/m³",
            subtitleTail:
                "${service.getAverage(Type.humidityOutside, data).toStringAsFixed(2)} g/m³");
      case HomeWidgetType.averageSound:
        String value = service.getAverage(Type.sound, data).toStringAsFixed(2);
        return createCard("Som", "$value dB");
      case HomeWidgetType.maxTemperature:
        return createCard(
            "Temperatura", "${service.getMax(Type.temperatureInside, data)} °C",
            subtitleTail:
                "${service.getMax(Type.temperatureOutside, data)} °C");
      case HomeWidgetType.maxHumidity:
        return createCard(
            "Umidade", "${service.getMax(Type.humidityInside, data)} g/m³",
            subtitleTail: "${service.getMax(Type.humidityOutside, data)} g/m³");
      case HomeWidgetType.maxSound:
        String value = service.getMax(Type.sound, data);
        return createCard("Som", "$value dB");
      case HomeWidgetType.minTemperature:
        return createCard(
            "Temperatura", "${service.getMin(Type.temperatureInside, data)} °C",
            subtitleTail:
                "${service.getMin(Type.temperatureOutside, data)} °C");
      case HomeWidgetType.minHumidity:
        return createCard(
            "Umidade", "${service.getMin(Type.humidityInside, data)} g/m³",
            subtitleTail: "${service.getMin(Type.humidityOutside, data)} g/m³");
      case HomeWidgetType.minSound:
        String value = service.getMin(Type.sound, data);
        return createCard("Som", "$value dB");
      default:
        return createTitle(index);
    }
  }

  Padding createCard(String title, String subtitle,
      {String subtitleTail = ""}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 0, right: 20, top: 0),
      child: Card(
        elevation: 2,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, top: 8.0),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Interna:  $subtitle',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: subtitleTail != "",
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Externa:  $subtitleTail',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  Padding createTitle(int index) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 15, bottom: 15, right: 20, top: 30),
        child: Text(
          handleTitle(index),
          style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ));
  }

  Widget createHeader() {
    return Container(
      color: Colors.white,
      child: (Row(
        children: const <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(left: 15, bottom: 15, right: 20, top: 20),
              child: Text(
                "Coleta (ID123123 : 22/11/2020)",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal),
              ))
        ],
      )),
    );
  }

  String handleTitle(int index) {
    switch (index) {
      case 1:
        return "Médias";
      case 5:
        return "Máximas";
      default:
        return "Mínimas";
    }
  }
}
