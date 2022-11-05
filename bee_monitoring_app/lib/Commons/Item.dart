import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum Type {
  temperature("Temperatura"),
  humidity("umidade"),
  sound("Som");
  
  const Type(this.value);
  final String value;
}

class Item {
  final String id;
  final String temperature;
  final String humidity;
  final String sound;
  final String timestamp;

  const Item(this.id, this.temperature, this.humidity, this.sound, this.timestamp);
}

class SalesData {
  SalesData(this.month, 
            this.temperatureInside, 
            this.temperatureOutside, 
            this.humidityInside, 
            this.humidityOutside, 
            this.sound);
  final String month;
  
  final double temperatureInside;
  final double temperatureOutside;

  final double humidityInside;
  final double humidityOutside;

  final double sound;
}
  