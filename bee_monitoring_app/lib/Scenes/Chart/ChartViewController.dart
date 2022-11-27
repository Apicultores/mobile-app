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
part 'Handlers/DataHandler.dart';
part 'Handlers/DateTextHandler.dart';
part 'ChartPopup.dart';
part 'ChartViewModel.dart';

class ChartViewController extends StatefulWidget {
  final List<Item> data;
  ChartViewController(this.data);

  @override
  _ChartViewControllerState createState() => _ChartViewControllerState();
}

class _ChartViewControllerState extends State<ChartViewController> {
  // MARK: - Variables
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
}
