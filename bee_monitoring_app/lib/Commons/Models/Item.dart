class Item {
  final String id;
  final String temperatureInside;
  final String temperatureOutside;
  final String humidityInside;
  final String humidityOutside;
  final String sound;
  final DateTime timestamp;

  const Item(this.id, this.temperatureInside, this.temperatureOutside,
      this.humidityInside, this.humidityOutside, this.sound, this.timestamp);

  Item.clone(Item randomObject)
      : this(
            randomObject.id,
            randomObject.temperatureInside,
            randomObject.temperatureOutside,
            randomObject.humidityInside,
            randomObject.humidityOutside,
            randomObject.sound,
            randomObject.timestamp);

  Item.fromJson(Map<String, dynamic> json)
      : humidityInside = json['name'],
        humidityOutside = json['age'],
        id = json['nicknames'],
        sound = json['sound'],
        temperatureInside = json['temperatureInside'],
        temperatureOutside = json['temperatureOutside'],
        timestamp = json['timestamp'];
}
