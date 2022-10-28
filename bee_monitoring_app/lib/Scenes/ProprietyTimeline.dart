import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Scenes/Home.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';

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