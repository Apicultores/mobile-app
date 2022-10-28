import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';

class Home extends StatelessWidget {
  final List<Item> myParam;
  Home(this.myParam);

  List<Type> temperature = [Type.temperature, Type.humidity, Type.sound];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: temperature.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(title: Text(getParameter(temperature[index], myParam)), subtitle: Text(temperature[index].value)));
        });
  }

  String getParameter(Type type, List<Item> myParam) {
    var sum = 0;
    for (var i = 0; i < myParam.length; i++) {
      switch (type) {
      case Type.temperature:
        sum += int.parse(myParam[i].temperature);
        break;
      case Type.humidity:
        sum += int.parse(myParam[i].humidity);
        break;
      case Type.sound:
        sum += int.parse(myParam[i].sound);
        break;
    }
    }
    return (sum / myParam.length).toStringAsFixed(2);
  }  
}
