import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';

class Service {
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
