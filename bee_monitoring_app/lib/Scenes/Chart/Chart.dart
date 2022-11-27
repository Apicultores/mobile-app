import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Commons/Enums/UpdateChartMode.dart';
import 'package:bee_monitoring_app/Commons/Models/ChartItem.dart';
import 'package:bee_monitoring_app/Scenes/Chart/ChartWidget.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';
import 'package:bee_monitoring_app/Commons/Enums/ChartWidgetType.dart';

class Chart extends StatefulWidget {
  final List<Item> data;
  Chart(this.data);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Item> _allData = [];
  late int index = 0;
  late List<ChartItem> _presentedData = [];
  late List<ChartItem> _chartData = [];

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
        itemCount: _chartData.isEmpty ? 0 : cellList.length,
        itemBuilder: (context, index) {
          return createWidget(index);
        });
  }

  void initState() {
    super.initState();
    loadData();
  }

  Widget createWidget(int index) {
    switch (cellList[index]) {
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
      case ChartWidgetType.header:
        return createHeader();
    }
  }

  Widget createHeader() {
    return Container(
      color: Colors.white,
      child: (Row(
        children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(left: 15, bottom: 15, right: 20, top: 20),
              child: Text(
                "Coleta (ID123123 : 22/11/2020)",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal),
              )),
          Expanded(child: Container()),
          ElevatedButton(
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) => _buildPopupDialog(context),
              // );
              showDialog(
                context: context,
                builder: (context) {
                  String contentText = "Content of Dialog";
                  return StatefulBuilder(
                    builder: (context, setState) {
                      // return _buildPopupDialog(context);
                      return AlertDialog(
                        title: Text("Opções"),
                        content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Modo de apresentação:"),
          DropdownButton(
            value: dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
          SizedBox(height: 30),
          Text("Data:"),
          DropdownButton(
            value: dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
                            ]),
                        actions: <Widget>[
                          new ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.grey[50]),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        SizedBox(width: 10),
        new ElevatedButton(
          onPressed: () {
            
          },
          child: const Text('Aplicar'),
        ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(primary: Colors.white),
            child: Icon(
              Icons.more_vert_sharp,
              size: 24.0,
            ),
          ),
          SizedBox(width: 10),
        ],
      )),
    );
  }

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Opções'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Modo de apresentação:"),
          DropdownButton(
            value: dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
          SizedBox(height: 30),
          Text("Data:"),
          DropdownButton(
            value: dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.grey[50]),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        SizedBox(width: 10),
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Aplicar'),
        ),
      ],
    );
  }

  Widget createGraphHeader() {
    return Padding(
        padding: EdgeInsets.only(left: 20, bottom: 5, right: 20, top: 25),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ElevatedButton(
                child: Text('< Anterior'),
                onPressed: () {
                  updateData(UpdateChartMode.back);
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
                  updateData(UpdateChartMode.next);
                },
              ),
            )
          ],
        ));
  }

  void updateData(UpdateChartMode mode) {
    if (mode == UpdateChartMode.next) {
      index += 1;
    } else {
      index -= 1;
    }
    if (index > 0) {
      index = 0;
    }
    int startRange = _chartData.length + ((index - 1) * 4);
    if (startRange < 0) {
      startRange = 0;
      if (_chartData.length + ((index) * 4) <= 0) {
        index += 1;
      }
    }
    int endRange = startRange + 4;
    setState(() {
      _presentedData = _chartData.getRange(startRange, endRange).toList();
    });
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
  Future loadData() async {
    service.loadData().then((value) {
      setState(() {
        _allData = value;
        _chartData = handleData();
        _presentedData = _chartData
            .getRange(_chartData.length - 4, _chartData.length)
            .toList();
      });
    });
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
              convertDateToString(currentDate),
              service.getAverage(Type.temperatureInside, tempArray),
              service.getAverage(Type.temperatureOutside, tempArray),
              service.getAverage(Type.humidityInside, tempArray),
              service.getAverage(Type.humidityOutside, tempArray),
              service.getAverage(Type.sound, tempArray)));
    }

    return chartData;
  }

  String convertDateToString(DateTime date) {
    String day =
        date.day < 10 ? "0${date.day.toString()}" : date.day.toString();
    String month =
        date.month < 10 ? "0${date.month.toString()}" : date.month.toString();
    String year = date.year.toString();
    String cropedYear = year.substring(year.length - 2, year.length);
    return "$day/$month/$cropedYear";
  }
}
