import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Scenes/Home.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';

class ListViewHome extends StatelessWidget {
  final List data;
  final Type type;

  ListViewHome(this.data, this.type);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(getParameter(type, data[index])),
                  subtitle: Text(data[index].timestamp)));
        });
  }

  String getParameter(Type type, Item item) {
    switch (type) {
      case Type.temperature:
        return item.temperature;
      case Type.humidity:
        return item.humidity;
      case Type.sound:
        return item.sound;
    }
  }
}
