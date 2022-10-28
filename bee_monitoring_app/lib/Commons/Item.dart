enum Type { temperature, humidity, sound }

class Item {
  final String id;
  final String temperatura;
  final String umidade;
  final String som;
  final String timestamp;

  const Item(this.id, this.temperatura, this.umidade, this.som, this.timestamp);
}