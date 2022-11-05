import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';

class ListViewHome extends StatefulWidget {
  final List data;
  final Type type;
  ListViewHome(this.data, this.type);

  @override
  _ListViewHomeState createState() => _ListViewHomeState();
}

class _ListViewHomeState extends State<ListViewHome> {
  List data = [];
  Type _type = Type.temperatureInside;

  void initState() {
    super.initState();
    data = widget.data;
    _type = widget.type;
  }

  DateFormat dateFormat = DateFormat("HH:mm:ss - dd/MM/yyyy");

  Widget buildSegment(String text) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }

  int _groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return index == 0
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: CupertinoSlidingSegmentedControl<int>(
                    backgroundColor: Color.fromARGB(255, 231, 231, 231),
                    thumbColor: Color.fromARGB(255, 255, 245, 186),
                    padding: EdgeInsets.all(8),
                    groupValue: _groupValue,
                    children: {
                      0: buildSegment("Temperatura"),
                      1: buildSegment("Umidade"),
                      2: buildSegment("Som"),
                    },
                    onValueChanged: (value) {
                      setState(() {
                        _groupValue = value ?? 0;
                        if (value == 0) {
                          _type = Type.temperatureInside;
                        } else if (value == 1) {
                          _type = Type.humidityInside;
                        } else {
                          _type = Type.sound;
                        }
                      });
                    },
                  ),
                )
              : Card(
                  child: ListTile(
                      title: Text(getParameter(_type, data[index])),
                      subtitle:
                          Text(dateFormat.format(data[index].timestamp))));
        });
  }

  String getParameter(Type type, Item item) {
    switch (type) {
      case Type.temperatureInside:
        String temperatureInside = item.temperatureInside;
        String temperatureOutside = item.temperatureOutside;
        return "Interna $temperatureInside \n\nExterna $temperatureOutside\n";
      case Type.temperatureOutside:
        return item.temperatureOutside;
      case Type.humidityInside:
        String humidityInside = item.humidityInside;
        String humidityOutside = item.humidityOutside;
        return "Interna $humidityInside \n\nExterna $humidityOutside\n";
      case Type.humidityOutside:
        return item.humidityOutside;
      case Type.sound:
        return item.sound;
    }
  }
}
