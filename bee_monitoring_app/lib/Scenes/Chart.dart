import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:bee_monitoring_app/Scenes/ProprietyTimeline.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Scenes/Home.dart';
import 'package:bee_monitoring_app/Scenes/Chart.dart';

class Chart extends StatefulWidget {
  final List<Item> data;
  Chart(this.data);

  @override
  _ChartState createState()=> _ChartState();
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
        separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
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
    return
        Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
        child:
        Row(
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
              controlAffinity:
                  ListTileControlAffinity.leading,
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
              controlAffinity:
                  ListTileControlAffinity.leading,
            ))
      ],
    )
    );
  }

  Padding createSoundCheckbox() {
    return
        Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
        child:
        Row(
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
              controlAffinity:
                  ListTileControlAffinity.leading,
            ))
      ],
    )
    );
  }

  Padding createHumidityCheckbox() {
    return
        Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
        child:
        Row(
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
              controlAffinity:
                  ListTileControlAffinity.leading,
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
              controlAffinity:
                  ListTileControlAffinity.leading,
            ))
      ],
    )
    );
  }

  Container createChart() {
    _chartData = getChartData();
    return 
    Container(
      height: 400,
      child:   SfCartesianChart(
      enableAxisAnimation: false,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      title: ChartTitle(text: '11 jan - 18 jan'),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        width: '80%',
        overflowMode: LegendItemOverflowMode.wrap,
        isResponsive: true
      ),
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
    )
    );
    // SfCartesianChart(
    //   enableAxisAnimation: false,
    //   primaryXAxis: CategoryAxis(),
    //   primaryYAxis: NumericAxis(),
    //   title: ChartTitle(text: '11 jan - 18 jan'),
    //   legend: Legend(
    //     isVisible: true,
    //     position: LegendPosition.bottom,
    //     width: '80%',
    //     overflowMode: LegendItemOverflowMode.wrap,
    //     isResponsive: true
    //   ),
    //   tooltipBehavior: TooltipBehavior(enable: false),
    //   series: <LineSeries<SalesData, String>>[
    //     LineSeries<SalesData, String>(
    //       isVisible: _temperatureInsideIsVisible,
    //       enableTooltip: true,
    //       name: 'Temperatura interna',
    //       dataSource: _chartData,
    //       xValueMapper: (SalesData sales, _) => sales.month,
    //       yValueMapper: (SalesData sales, _) => sales.temperatureInside,
    //       dataLabelSettings: DataLabelSettings(
    //         isVisible: true,
    //         color: Colors.blue,
    //       ),
    //     ),
    //     LineSeries(
    //       isVisible: _temperatureOutsideIsVisible,
    //       enableTooltip: true,
    //       name: 'Temperatura externa',
    //       dataSource: _chartData,
    //       xValueMapper: (SalesData sales, _) => sales.month,
    //       yValueMapper: (SalesData sales, _) => sales.temperatureOutside,
    //       dataLabelSettings: const DataLabelSettings(
    //         isVisible: true,
    //         color: Color.fromARGB(255, 126, 19, 19),
    //       ),
    //     ),
    //     LineSeries(
    //       isVisible: _humidityInsideIsVisible,
    //       enableTooltip: true,
    //       name: 'Humidade interna',
    //       dataSource: _chartData,
    //       xValueMapper: (SalesData sales, _) => sales.month,
    //       yValueMapper: (SalesData sales, _) => sales.humidityInside,
    //       dataLabelSettings: const DataLabelSettings(
    //         isVisible: true,
    //         color: Color.fromARGB(255, 89, 0, 83),
    //       ),
    //     ),
    //     LineSeries(
    //       isVisible: _humidityOutsideIsVisible,
    //       enableTooltip: true,
    //       name: 'Humidade externa',
    //       dataSource: _chartData,
    //       xValueMapper: (SalesData sales, _) => sales.month,
    //       yValueMapper: (SalesData sales, _) => sales.humidityOutside,
    //       dataLabelSettings: const DataLabelSettings(
    //         isVisible: true,
    //         color: Color.fromARGB(255, 255, 0, 238),
    //       ),
    //     ),
    //     LineSeries(
    //       isVisible: _soundIsVisible,
    //       enableTooltip: true,
    //       name: 'Som',
    //       dataSource: _chartData,
    //       xValueMapper: (SalesData sales, _) => sales.month,
    //       yValueMapper: (SalesData sales, _) => sales.sound,
    //       dataLabelSettings: const DataLabelSettings(
    //         isVisible: true,
    //         color: Color.fromARGB(255, 0, 120, 150),
    //       ),
    //     ),
    //   ],
    // );
  }
}
