import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  void initState() {
    super.initState();
    dataState = widget.data;
    _chartData = handleData();
  }

  List<SalesData> handleData() {
    final List<SalesData> chartData = [];
    while (!dataState.isEmpty) {
      DateTime currentDate = dataState.first.timestamp;
      print("dataState.first.timestamp");
      print(dataState.first.timestamp);
      List<Item> tempArray = [];
      while (dataState.first.timestamp == currentDate) {
        print(dataState.first.timestamp);
        print("-------");
        tempArray.add(dataState.first);
        dataState.removeAt(0);
        if (dataState.isEmpty) {
          break;
        }
      }

      chartData.add(SalesData(currentDate.day.toString(),
          getAverage(Type.humidityInside, tempArray), 14, 14, 19, 2));
    }

    // chartData.add(SalesData('Seg', 3, 14, 14, 19, 2));
    // chartData.add(SalesData('Ter', 3, 19, 14, 19, 2));
    // chartData.add(SalesData('Qua', 3, 12, 14, 19, 2));
    
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

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData('Seg', 3, 14, 14, 19, 2),
      SalesData('Ter', 3, 19, 14, 19, 2),
      SalesData('Qua', 3, 12, 14, 19, 2),
      SalesData('Qui', 3, 31, 14, 19, 2),
      SalesData('Sex', 3, 11, 14, 19, 2),
      SalesData('Sab', 3, 15, 14, 19, 2),
      SalesData('Dom', 3, 90, 14, 19, 2),
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 0),
        itemCount: 4,
        itemBuilder: (context, index) {
          return index == 0 ? createChart() : createCheckbox(index);
        });
  }

  late List<SalesData> _chartData;
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
          title: ChartTitle(text: '11 jan - 18 jan'),
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
