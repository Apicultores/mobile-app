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