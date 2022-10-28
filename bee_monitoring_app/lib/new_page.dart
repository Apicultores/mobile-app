import 'package:flutter/material.dart';

class ListViewHome extends StatelessWidget {
  final List myParam;
  final Type type;

  ListViewHome(this.myParam, this.type);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: myParam.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(getParameter(type, myParam[index])),
                  subtitle: Text(myParam[index].timestamp)));
        });
  }

  String getParameter(Type type, Item item) {
    switch (type) {
      case Type.temperature:
        return item.temperatura;
      case Type.humidity:
        return item.umidade;
      case Type.sound:
        return item.som;
    }
  }
}

enum Type { temperature, humidity, sound }

class Item {
  final String id;
  final String temperatura;
  final String umidade;
  final String som;
  final String timestamp;

  const Item(this.id, this.temperatura, this.umidade, this.som, this.timestamp);
}

class Home extends StatelessWidget {
  // final List myParam;

  // Home(this.myParam);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(title: Text("teste"), subtitle: Text("home")));
        });
  }
}
