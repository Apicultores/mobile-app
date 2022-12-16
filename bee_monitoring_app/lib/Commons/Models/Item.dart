import 'package:intl/intl.dart';

class Item {
  final String temperatureInside;
  final String temperatureOutside;
  final String humidityInside;
  final String humidityOutside;
  final String sound;
  final DateTime timestamp;

  const Item(this.temperatureInside, this.temperatureOutside,
      this.humidityInside, this.humidityOutside, this.sound, this.timestamp);

  Item.clone(Item randomObject)
      : this(
            randomObject.temperatureInside,
            randomObject.temperatureOutside,
            randomObject.humidityInside,
            randomObject.humidityOutside,
            randomObject.sound,
            randomObject.timestamp);

  Item.fromJson(Map<String, dynamic> json)
      : humidityInside = json['ui'].toString(),
        humidityOutside = json['ue'].toString(),
        sound = json['s'].toString(),
        temperatureInside = json['ti'].toString(),
        temperatureOutside = json['te'].toString(),
        timestamp = DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['ts']);
}
