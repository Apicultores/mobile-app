import 'package:flutter/material.dart';
import '/Commons/Models/Item.dart';
import '/Commons/Enums/Type.dart';
import '/Commons/Enums/UpdateChartMode.dart';
import '/Commons/Models/ChartItem.dart';
import '/Commons/Service.dart';
import '/Commons/Enums/ChartWidgetType.dart';
import 'Widgets/ChartWidget.dart';
import 'package:intl/intl.dart';
part 'Widgets/ChartCheckboxWidgets.dart';
part 'Widgets/HeaderWidgets.dart';
part 'Handlers/DataHandler.dart';
part 'Handlers/DateTextHandler.dart';
part 'ChartPopup.dart';
part 'ChartViewModel.dart';

class ChartViewController extends StatefulWidget {
  DateFormat dateFormat = DateFormat("HH:mm:ss - dd/MM/yyyy");
  final List<Item> data;
  ChartViewController(this.data, {super.key});

  @override
  _ChartViewControllerState createState() => _ChartViewControllerState();
}

class _ChartViewControllerState extends State<ChartViewController> {
  // MARK: - Variables
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
            const Divider(height: 0),
        itemCount: _averageChartData.isEmpty ? 0 : cellList.length,
        itemBuilder: (context, index) {
          return createWidget(index, widget.data.isEmpty ? null : widget.data);
        });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }
}
