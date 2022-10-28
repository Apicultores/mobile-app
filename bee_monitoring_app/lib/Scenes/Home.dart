import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';

class Home extends StatelessWidget {
  final List<Item> data;
  Home(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: Type.values.length + 1,
        itemBuilder: (context, index) {
          return index == 0
              ? 
              Padding(
  padding: EdgeInsets.only(left:15, bottom: 10, right: 20, top:20), //apply padding to some sides only
  child:               Text(
                  "Médias",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )
)
              : Card(
                  child: ListTile(
                      title: Text(getAverage(Type.values[index - 1], data)),
                      subtitle: Text(Type.values[index - 1].value)));
        });
  }

  String getAverage(Type type, List<Item> dataArray) {
    var sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperature:
          sum += int.parse(dataArray[i].temperature);
          break;
        case Type.humidity:
          sum += int.parse(dataArray[i].humidity);
          break;
        case Type.sound:
          sum += int.parse(dataArray[i].sound);
          break;
      }
    }
    return (sum / dataArray.length).toStringAsFixed(2);
  }
}
