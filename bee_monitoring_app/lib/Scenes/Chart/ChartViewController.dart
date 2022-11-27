import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '/Commons/Models/Item.dart';
import '/Commons/Enums/Type.dart';
import '/Commons/Enums/UpdateChartMode.dart';
import '/Commons/Models/ChartItem.dart';
import '/Commons/Service.dart';
import '/Commons/Enums/ChartWidgetType.dart';
import 'Widgets/ChartWidget.dart';
part 'Widgets/ChartCheckboxWidgets.dart';
part 'Widgets/HeaderWidgets.dart';
part 'ChartPopup.dart';
part 'Handlers/DataHandler.dart';

class ChartViewController extends StatefulWidget {
  final List<Item> data;
  ChartViewController(this.data);

  @override
  _ChartViewControllerState createState() => _ChartViewControllerState();
}

class _ChartViewControllerState extends State<ChartViewController> {
  List<Item> _allData = [];
  late int index = 0;
  late List<ChartItem> _presentedData = [];
  late List<ChartItem> _averageChartData = [];
  late List<ChartItem> _individualChartData = [];

  GraphMode graphMode = GraphMode.averageData;
  String _graphModeText = 'Média diária';
  var graphModes = [
    'Média diária',
    'Coletas individuais',
  ];

  String? graphAverageDatesText;
  var graphAverageDates = [
    'Carregando...',
  ];

  String? graphIndividualDatesText;
  var graphIndividualDates = [
    'Carregando...',
  ];

  Service service = Service();
  bool _temperatureInsideIsVisible = false;
  bool _temperatureOutsideIsVisible = false;

  bool _humidityInsideIsVisible = false;
  bool _humidityOutsideIsVisible = false;

  bool _soundIsVisible = false;

  List<ChartWidgetType> cellList = [
    ChartWidgetType.header,
    ChartWidgetType.graphHeader,
    ChartWidgetType.graph,
    ChartWidgetType.temperatureCheckbox,
    ChartWidgetType.humidityCheckbox,
    ChartWidgetType.soundCheckbox,
  ];

  // MARK: - Life Cycle
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 0),
        itemCount: _averageChartData.isEmpty ? 0 : cellList.length,
        itemBuilder: (context, index) {
          return createWidget(index);
        });
  }

  void initState() {
    super.initState();
    loadData();
  }

  // MARK: - Widget Builders
  Widget createWidget(int index) {
    switch (cellList[index]) {
      case ChartWidgetType.header:
        return createHeader();
      case ChartWidgetType.graphHeader:
        return createGraphHeader();
      case ChartWidgetType.graph:
        return ChartWidget(
            temperatureInsideIsVisible: _temperatureInsideIsVisible,
            chartData: _presentedData,
            temperatureOutsideIsVisible: _temperatureOutsideIsVisible,
            humidityInsideIsVisible: _humidityInsideIsVisible,
            humidityOutsideIsVisible: _humidityOutsideIsVisible,
            soundIsVisible: _soundIsVisible);
      case ChartWidgetType.temperatureCheckbox:
        return createTemperatureCheckbox();
      case ChartWidgetType.humidityCheckbox:
        return createHumidityCheckbox();
      case ChartWidgetType.soundCheckbox:
        return createSoundCheckbox();
    }
  }

  void updatePresentedChartData(UpdateChartMode mode) {
    if (mode == UpdateChartMode.next) {
      index += 1;
    } else {
      index -= 1;
    }
    if (index > 0) {
      index = 0;
    }
    if (graphMode == GraphMode.averageData) {
      int startRange = _averageChartData.length + ((index - 1) * 6);
      if (startRange < 0) {
        startRange = 0;
        if (_averageChartData.length + ((index) * 6) <= 0) {
          index += 1;
        }
      }
      int endRange = startRange + 6;
      setState(() {
        _presentedData =
            _averageChartData.getRange(startRange, endRange).toList();
      });
    } else {
      int startRange = _individualChartData.length + ((index - 1) * 4);
      if (startRange < 0) {
        startRange = 0;
        if (_individualChartData.length + ((index) * 4) <= 0) {
          index += 1;
        }
      }
      int endRange = startRange + 4;
      setState(() {
        _presentedData =
            _individualChartData.getRange(startRange, endRange).toList();
      });
      _presentedData.forEach((element) {
        print(element.month);
      });
    }
  }
}
