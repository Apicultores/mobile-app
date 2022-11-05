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

  
  void onTabTapped(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData('Jan', 11, 14, 14),
      SalesData('Feb', 14, 19, 14),
      SalesData('Mar', 23, 12, 14),
      SalesData('Apr', 12, 31, 14),
      SalesData('May', 30, 11, 14),
      SalesData('Jun', 25, 15, 14),
    ];
    return chartData;
  }

  List<String> titles = ["Médias", "Máximas", "Mínimas"];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
        itemCount: 4,
        itemBuilder: (context, index) {
          return index == 0 ? createChart() : createCheckbox();
        });
  }

  late List<SalesData> _chartData;
  Padding createCheckbox() {
    return
    Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
        child:
        Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: CheckboxListTile(
              title: Text("title text"),
              value: _temperatureInsideIsVisible,
              onChanged: (newValue) {
                setState(() {
                  _temperatureInsideIsVisible = newValue ?? false;
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading,
            )),
        Expanded(
            flex: 5,
            child: CheckboxListTile(
              title: Text("title text"),
              value: true,
              onChanged: (newValue) {
                print("oi");
              },
              controlAffinity:
                  ListTileControlAffinity.leading,
            ))
      ],
    )
    );
  }

  SfCartesianChart createChart() {
    _chartData = getChartData();
    return SfCartesianChart(
      enableAxisAnimation: true,
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: '11 jan - 18 jan'),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
          isVisible: _temperatureInsideIsVisible,
          enableTooltip: true,
          name: 'sales',
          dataSource: _chartData,
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.sales,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            color: Colors.blue,
          ),
        ),
        LineSeries(
          name: 'purchase',
          dataSource: _chartData,
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.purchase,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            color: Color.fromARGB(255, 126, 19, 19),
          ),
        ),
        LineSeries(
          name: 'teste',
          dataSource: _chartData,
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.teste,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            color: Color.fromARGB(255, 255, 0, 238),
          ),
        ),
      ],
    );
  }
}
