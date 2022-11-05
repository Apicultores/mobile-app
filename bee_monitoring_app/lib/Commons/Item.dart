enum Type {
  temperatureInside("Temperatura Interna"),
  temperatureOutside("Temperatura Externa"),
  humidityInside("Umidade Interna"),
  humidityOutside("Umidade Externa"),
  sound("Som");

  const Type(this.value);
  final String value;
}

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

class SalesData {
  SalesData(this.month, this.temperatureInside, this.temperatureOutside,
      this.humidityInside, this.humidityOutside, this.sound);
  final String month;

  final double temperatureInside;
  final double temperatureOutside;

  final double humidityInside;
  final double humidityOutside;

  final double sound;
}
