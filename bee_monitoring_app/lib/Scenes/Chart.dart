import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
      print(DateFormat("yyyy-MM-dd hh:mm:ss").parse(data[0]['timestamp']));
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
    // dataState = widget.data;
    loadData();
  }

  List<SalesData> handleData() {
    final List<SalesData> chartData = [];
    List<Item> dataStateTemp = dataState;

    while (!dataStateTemp.isEmpty) {
      DateTime currentDate = dataStateTemp.first.timestamp;
      List<Item> tempArray = [];
      while (dataStateTemp.first.timestamp == currentDate) {
        print(dataStateTemp.first.timestamp);
        print("-------");
        tempArray.add(dataStateTemp.first);
        dataStateTemp.removeAt(0);
        if (dataStateTemp.isEmpty) {
          break;
        }
      }

      chartData.insert(
          0,
          SalesData(
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
    print("---------");
    print((sum / dataArray.length).toString());
    return (sum / dataArray.length);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 0),
        itemCount: _chartData.isEmpty ? 0 : 4,
        itemBuilder: (context, index) {
          return index == 0 ? createChart() : createCheckbox(index);
        });
  }

  late List<SalesData> _chartData = [];
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

  Container createChart() {
    //getChartData();
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
          series: <LineSeries<SalesData, String>>[
            LineSeries<SalesData, String>(
              isVisible: _temperatureInsideIsVisible,
              enableTooltip: true,
              name: 'Temperatura interna',
              dataSource: _chartData,
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.temperatureInside,
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
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.temperatureOutside,
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
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.humidityInside,
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
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.humidityOutside,
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
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.sound,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                color: Color.fromARGB(255, 0, 120, 150),
              ),
            ),
          ],
        ));
  }
}
