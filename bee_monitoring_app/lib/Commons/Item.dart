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
}