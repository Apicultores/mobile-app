import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';
import 'package:bee_monitoring_app/Commons/Enums/HomeCardType.dart';

class HomeViewModel {
  List<String> titles = ["Médias", "Máximas", "Mínimas"];
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

  Padding createTitle(int index) {
    return Padding(
        padding: EdgeInsets.only(left: 15, bottom: 15, right: 20, top: 30),
        child: Text(
          titles[(index / (Type.values.length + 1)).toInt()],
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ));
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
                          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
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
                              fontSize: 14.0,
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
                                fontSize: 14.0,
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

  Padding createAverageCard(int index, List<Item> data) {
    switch (cellList[index]) {
      case HomeCardType.averageTemperature:
        return HomeViewModel().createCard(Type.temperatureInside.value,
            service.getAverage(Type.temperatureInside, data).toStringAsFixed(2),
            subtitleTail: service
                .getAverage(Type.temperatureOutside, data)
                .toStringAsFixed(2));
      case HomeCardType.averageHumidity:
        return HomeViewModel().createCard(Type.humidityInside.value,
            service.getAverage(Type.humidityInside, data).toStringAsFixed(2),
            subtitleTail: service
                .getAverage(Type.humidityOutside, data)
                .toStringAsFixed(2));
      case HomeCardType.averageSound:
        return HomeViewModel().createCard(Type.sound.value,
            service.getAverage(Type.sound, data).toStringAsFixed(2));
      case HomeCardType.maxTemperature:
        return HomeViewModel().createCard(Type.temperatureInside.value,
            service.getMax(Type.temperatureInside, data),
            subtitleTail: service.getMax(Type.temperatureOutside, data));
      case HomeCardType.maxHumidity:
        return HomeViewModel().createCard(Type.humidityInside.value,
            service.getMax(Type.humidityInside, data),
            subtitleTail: service.getMax(Type.humidityOutside, data));
      case HomeCardType.maxSound:
        return HomeViewModel()
            .createCard(Type.sound.value, service.getMax(Type.sound, data));
      case HomeCardType.minTemperature:
        return HomeViewModel().createCard(Type.temperatureInside.value,
            service.getMin(Type.temperatureInside, data),
            subtitleTail: service.getMin(Type.temperatureOutside, data));
      case HomeCardType.minHumidity:
        return HomeViewModel().createCard(Type.humidityInside.value,
            service.getMin(Type.humidityInside, data),
            subtitleTail: service.getMin(Type.humidityOutside, data));
      case HomeCardType.minSound:
        return HomeViewModel()
            .createCard(Type.sound.value, service.getMin(Type.sound, data));
      default:
        return HomeViewModel().createTitle(index);
    }
  }
}
