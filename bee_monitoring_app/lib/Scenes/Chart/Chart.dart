import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';
import 'package:bee_monitoring_app/Commons/ChartItem.dart';
import 'package:bee_monitoring_app/Scenes/Chart/ChartWidget.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';

class Chart extends StatefulWidget {
  final List<Item> data;
  Chart(this.data);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Item> _allData = [];
  List<Item> _presentedData = [];
  late List<ChartItem> _chartData = [];

  Service service = Service();
  bool _temperatureInsideIsVisible = false;
  bool _temperatureOutsideIsVisible = false;

  bool _humidityInsideIsVisible = false;
  bool _humidityOutsideIsVisible = false;

  bool _soundIsVisible = false;

  // MARK: - Life Cycle
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 0),
        itemCount: _chartData.isEmpty ? 0 : 5,
        itemBuilder: (context, index) {
          return createWidget(index);
        });
  }

  void initState() {
    super.initState();
    loadData();
  }

  Widget createWidget(int index) {
    switch (index) {
      case 0:
        return createHeader();

      case 1:
        return ChartWidget(
            temperatureInsideIsVisible: _temperatureInsideIsVisible,
            chartData: _chartData,
            temperatureOutsideIsVisible: _temperatureOutsideIsVisible,
            humidityInsideIsVisible: _humidityInsideIsVisible,
            humidityOutsideIsVisible: _humidityOutsideIsVisible,
            soundIsVisible: _soundIsVisible);
      case 2:
        return createTemperatureCheckbox();
      case 3:
        return createHumidityCheckbox();
      default:
        return createSoundCheckbox();
    }
  }

  Widget createHeader() {
    return Padding(
        padding: EdgeInsets.only(left: 20, bottom: 5, right: 20, top: 25),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ElevatedButton(
                child: Text('< Anterior'),
                onPressed: () {
                  updateData(UpdateMode.back);
                },
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 15, bottom: 20, right: 20, top: 20),
                child: Text(
                  "Medições",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                child: Text('Próximo >'),
                onPressed: () {
                  updateData(UpdateMode.next);
                },
              ),
            )
          ],
        ));
  }

  void updateData(UpdateMode mode) {
    // TODO: Implementar
  }

  // MARK: - Checkbox
  Widget createTemperatureCheckbox() {
    return Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: CheckboxListTile(
                  title: Text("Temperatura Interna"),
                  value: _temperatureInsideIsVisible,
                  onChanged: (newValue) {
                    setState(() {
                      _temperatureInsideIsVisible = newValue ?? true;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            Expanded(
                flex: 5,
                child: CheckboxListTile(
                  title: Text("Temperatura Externa"),
                  value: _temperatureOutsideIsVisible,
                  onChanged: (newValue) {
                    setState(() {
                      _temperatureOutsideIsVisible = newValue ?? true;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ))
          ],
        ));
  }

  Padding createSoundCheckbox() {
    return Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: CheckboxListTile(
                  title: Text("Som"),
                  value: _soundIsVisible,
                  onChanged: (newValue) {
                    setState(() {
                      _soundIsVisible = newValue ?? true;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ))
          ],
        ));
  }

  Padding createHumidityCheckbox() {
    return Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: CheckboxListTile(
                  title: Text("Humidade Interna"),
                  value: _humidityInsideIsVisible,
                  onChanged: (newValue) {
                    setState(() {
                      _humidityInsideIsVisible = newValue ?? true;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            Expanded(
                flex: 5,
                child: CheckboxListTile(
                  title: Text("Humidade Externa"),
                  value: _humidityOutsideIsVisible,
                  onChanged: (newValue) {
                    setState(() {
                      _humidityOutsideIsVisible = newValue ?? true;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ))
          ],
        ));
  }

  // MARK: - Load Data
  Future<String> loadData() async {
    var path = await rootBundle.loadString("assets/mockData.json");
    setState(() {
      var response = json.decode(path);
      List data = response['data'];
      List<Item> list = [];
      for (var item in data) {
        list.add(Item(
            item['id'].toString(),
            item['temperatura_dentro'].toString(),
            item['temperatura_fora'].toString(),
            item['umidade_dentro'].toString(),
            item['umidade_fora'].toString(),
            item['som'].toString(),
            DateFormat("yyyy-MM-dd hh:mm:ss").parse(item['timestamp'])));
      }

      setState(() {
        _allData = list;
        _chartData = handleData();
      });
    });
    return "success";
  }

  List<ChartItem> handleData() {
    final List<ChartItem> chartData = [];
    List<Item> dataStateTemp = _allData;

    while (!dataStateTemp.isEmpty) {
      DateTime currentDate = dataStateTemp.first.timestamp;
      List<Item> tempArray = [];
      while (dataStateTemp.first.timestamp == currentDate) {
        tempArray.add(dataStateTemp.first);
        dataStateTemp.removeAt(0);
        if (dataStateTemp.isEmpty) {
          break;
        }
      }

      chartData.insert(
          0,
          ChartItem(
              currentDate.day.toString(),
              service.getAverage(Type.temperatureInside, tempArray),
              service.getAverage(Type.temperatureOutside, tempArray),
              service.getAverage(Type.humidityInside, tempArray),
              service.getAverage(Type.humidityOutside, tempArray),
              service.getAverage(Type.sound, tempArray)));
    }

    return chartData;
  }
}
