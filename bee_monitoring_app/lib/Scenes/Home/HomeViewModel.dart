import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';
import 'package:bee_monitoring_app/Commons/Enums/HomeCardType.dart';

class HomeViewModel {
  Service service = Service();

  List<HomeCardType> cellList = [
    HomeCardType.title,
    HomeCardType.averageTemperature,
    HomeCardType.averageHumidity,
    HomeCardType.averageSound,
    HomeCardType.title,
    HomeCardType.maxTemperature,
    HomeCardType.maxHumidity,
    HomeCardType.maxSound,
    HomeCardType.title,
    HomeCardType.minTemperature,
    HomeCardType.minHumidity,
    HomeCardType.minSound
  ];

  Padding createAverageCard(int index, List<Item> data) {
    switch (cellList[index]) {
      case HomeCardType.averageTemperature:
        return HomeViewModel().createCard(
            "Temperatura",
            service
                    .getAverage(Type.temperatureInside, data)
                    .toStringAsFixed(2) +
                " °C",
            subtitleTail: service
                    .getAverage(Type.temperatureOutside, data)
                    .toStringAsFixed(2) +
                " °C");
      case HomeCardType.averageHumidity:
        return HomeViewModel().createCard(
            "Umidade",
            service.getAverage(Type.humidityInside, data).toStringAsFixed(2) +
                " g/m³",
            subtitleTail: service
                    .getAverage(Type.humidityOutside, data)
                    .toStringAsFixed(2) +
                " g/m³");
      case HomeCardType.averageSound:
        String value = service.getAverage(Type.sound, data).toStringAsFixed(2);
        return HomeViewModel().createCard("Som", "$value dB");
      case HomeCardType.maxTemperature:
        return HomeViewModel().createCard(
            "Temperatura", service.getMax(Type.temperatureInside, data) + " °C",
            subtitleTail:
                service.getMax(Type.temperatureOutside, data) + " °C");
      case HomeCardType.maxHumidity:
        return HomeViewModel().createCard(
            "Umidade", service.getMax(Type.humidityInside, data) + " g/m³",
            subtitleTail: service.getMax(Type.humidityOutside, data) + " g/m³");
      case HomeCardType.maxSound:
        String value = service.getMax(Type.sound, data);
        return HomeViewModel().createCard("Som", "$value dB");
      case HomeCardType.minTemperature:
        return HomeViewModel().createCard(
            "Temperatura", service.getMin(Type.temperatureInside, data) + " °C",
            subtitleTail:
                service.getMin(Type.temperatureOutside, data) + " °C");
      case HomeCardType.minHumidity:
        return HomeViewModel().createCard(
            "Umidade", service.getMin(Type.humidityInside, data) + " g/m³",
            subtitleTail: service.getMin(Type.humidityOutside, data) + " g/m³");
      case HomeCardType.minSound:
        String value = service.getMin(Type.sound, data);
        return HomeViewModel().createCard("Som", "$value dB");
      default:
        return HomeViewModel().createTitle(index);
    }
  }

  Padding createCard(String title, String subtitle,
      {String subtitleTail = ""}) {
    return Padding(
      padding: EdgeInsets.only(left: 15, bottom: 0, right: 20, top: 0),
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
                    SizedBox(
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
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Interna:  $subtitle',
                            style: TextStyle(
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
                              style: TextStyle(
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
        padding: EdgeInsets.only(left: 15, bottom: 15, right: 20, top: 30),
        child: Text(
          handleTitle(index),
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ));
  }

  String handleTitle(int index) {
    switch (index) {
      case 0:
        return "Médias";
      case 4:
        return "Máximas";
      default:
        return "Mínimas";
    }
  }
}
