import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Commons/Models/ChartItem.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    Key? key,
    required bool temperatureInsideIsVisible,
    required List<ChartItem> chartData,
    required bool temperatureOutsideIsVisible,
    required bool humidityInsideIsVisible,
    required bool humidityOutsideIsVisible,
    required bool soundIsVisible,
  })  : _temperatureInsideIsVisible = temperatureInsideIsVisible,
        _chartData = chartData,
        _temperatureOutsideIsVisible = temperatureOutsideIsVisible,
        _humidityInsideIsVisible = humidityInsideIsVisible,
        _humidityOutsideIsVisible = humidityOutsideIsVisible,
        _soundIsVisible = soundIsVisible,
        super(key: key);

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
              xValueMapper: (ChartItem sales, _) => sales.date,
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
              xValueMapper: (ChartItem sales, _) => sales.date,
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
              xValueMapper: (ChartItem sales, _) => sales.date,
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
              xValueMapper: (ChartItem sales, _) => sales.date,
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
              xValueMapper: (ChartItem sales, _) => sales.date,
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
