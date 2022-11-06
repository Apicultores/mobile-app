import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';
import 'package:bee_monitoring_app/Commons/ChartItem.dart';

class Chart extends StatefulWidget {
  final List<Item> data;
  Chart(this.data);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Item> dataState = [];

  bool _temperatureInsideIsVisible = false;
  bool _temperatureOutsideIsVisible = false;

  bool _humidityInsideIsVisible = false;
  bool _humidityOutsideIsVisible = false;

  bool _soundIsVisible = false;

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
        print("catalogdata = list;!!!");
        dataState = list;
        _chartData = handleData();
      });
    });
    return "success";
  }

  void initState() {
    super.initState();
    loadData();
  }

  List<ChartItem> handleData() {
    final List<ChartItem> chartData = [];
    List<Item> dataStateTemp = dataState;

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
              getAverage(Type.temperatureInside, tempArray),
              getAverage(Type.temperatureOutside, tempArray),
              getAverage(Type.humidityInside, tempArray),
              getAverage(Type.humidityOutside, tempArray),
              getAverage(Type.sound, tempArray)));
    }

    return chartData;
  }

  double getAverage(Type type, List<Item> dataArray) {
    var sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperatureInside:
          sum += int.parse(dataArray[i].temperatureInside);
          break;

        case Type.temperatureOutside:
          sum += int.parse(dataArray[i].temperatureOutside);
          break;

        case Type.humidityInside:
          sum += int.parse(dataArray[i].humidityInside);
          break;

        case Type.humidityOutside:
          sum += int.parse(dataArray[i].humidityOutside);
          break;

        case Type.sound:
          sum += int.parse(dataArray[i].sound);
          break;
      }
    }

    return (sum / dataArray.length);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 0),
        itemCount: _chartData.isEmpty ? 0 : 4,
        itemBuilder: (context, index) {
          return index == 0 ? ChartWidget(temperatureInsideIsVisible: _temperatureInsideIsVisible, chartData: _chartData, temperatureOutsideIsVisible: _temperatureOutsideIsVisible, humidityInsideIsVisible: _humidityInsideIsVisible, humidityOutsideIsVisible: _humidityOutsideIsVisible, soundIsVisible: _soundIsVisible) : createCheckbox(index);
        });
  }

  late List<ChartItem> _chartData = [];
  Padding createCheckbox(int index) {
    switch (index) {
      case 1:
        return createTemperatureCheckbox();
      case 2:
        return createHumidityCheckbox();
      default:
        return createSoundCheckbox();
    }
  }

  Padding createTemperatureCheckbox() {
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
}

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    Key? key,
    required bool temperatureInsideIsVisible,
    required List<ChartItem> chartData,
    required bool temperatureOutsideIsVisible,
    required bool humidityInsideIsVisible,
    required bool humidityOutsideIsVisible,
    required bool soundIsVisible,
  }) : _temperatureInsideIsVisible = temperatureInsideIsVisible, _chartData = chartData, _temperatureOutsideIsVisible = temperatureOutsideIsVisible, _humidityInsideIsVisible = humidityInsideIsVisible, _humidityOutsideIsVisible = humidityOutsideIsVisible, _soundIsVisible = soundIsVisible, super(key: key);

  final bool _temperatureInsideIsVisible;
  final List<ChartItem> _chartData;
  final bool _temperatureOutsideIsVisible;
  final bool _humidityInsideIsVisible;
  final bool _humidityOutsideIsVisible;
  final bool _soundIsVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: SfCartesianChart(
          enableAxisAnimation: false,
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          title: ChartTitle(text: 'Ultimas medições'),
          legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              width: '80%',
              overflowMode: LegendItemOverflowMode.wrap,
              isResponsive: true),
          tooltipBehavior: TooltipBehavior(enable: false),
          series: <LineSeries<ChartItem, String>>[
            LineSeries<ChartItem, String>(
              isVisible: _temperatureInsideIsVisible,
              enableTooltip: true,
              name: 'Temperatura interna',
              dataSource: _chartData,
              xValueMapper: (ChartItem sales, _) => sales.month,
              yValueMapper: (ChartItem sales, _) => sales.temperatureInside,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                color: Colors.blue,
              ),
            ),
            LineSeries(
              isVisible: _temperatureOutsideIsVisible,
              enableTooltip: true,
              name: 'Temperatura externa',
              dataSource: _chartData,
              xValueMapper: (ChartItem sales, _) => sales.month,
              yValueMapper: (ChartItem sales, _) => sales.temperatureOutside,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                color: Color.fromARGB(255, 126, 19, 19),
              ),
            ),
            LineSeries(
              isVisible: _humidityInsideIsVisible,
              enableTooltip: true,
              name: 'Humidade interna',
              dataSource: _chartData,
              xValueMapper: (ChartItem sales, _) => sales.month,
              yValueMapper: (ChartItem sales, _) => sales.humidityInside,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                color: Color.fromARGB(255, 89, 0, 83),
              ),
            ),
            LineSeries(
              isVisible: _humidityOutsideIsVisible,
              enableTooltip: true,
              name: 'Humidade externa',
              dataSource: _chartData,
              xValueMapper: (ChartItem sales, _) => sales.month,
              yValueMapper: (ChartItem sales, _) => sales.humidityOutside,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                color: Color.fromARGB(255, 255, 0, 238),
              ),
            ),
            LineSeries(
              isVisible: _soundIsVisible,
              enableTooltip: true,
              name: 'Som',
              dataSource: _chartData,
              xValueMapper: (ChartItem sales, _) => sales.month,
              yValueMapper: (ChartItem sales, _) => sales.sound,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                color: Color.fromARGB(255, 0, 120, 150),
              ),
            ),
          ],
        ));
  }
}
