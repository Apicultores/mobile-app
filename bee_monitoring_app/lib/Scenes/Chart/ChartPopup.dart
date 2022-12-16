part of 'ChartViewController.dart';

extension ChartPopup on _ChartViewControllerState {
  void showPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Opções"),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Modo de apresentação:"),
                    DropdownButton(
                      value: _graphModeText,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: graphModes.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _graphModeText = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    const Text("Data para consulta:"),
                    Visibility(
                        visible: _graphModeText == graphModes.first,
                        child: DropdownButton(
                          value: graphAverageDatesText,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: graphAverageDates.map((String items) {
                            return DropdownMenuItem(
                                value: items, child: Text(items));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              if (graphAverageDates.contains(newValue)) {
                                graphAverageDatesText = newValue!;
                              }
                            });
                          },
                        )),
                    Visibility(
                        visible: _graphModeText != graphModes.first,
                        child: DropdownButton(
                          isExpanded: true,
                          value: graphIndividualDatesText,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: graphIndividualDates.map((String items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text(items.replaceAll("\n", " - ")));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              if (graphIndividualDates.contains(newValue)) {
                                graphIndividualDatesText = newValue!;
                              }
                            });
                          },
                        ))
                  ]),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[50]),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      graphMode = _graphModeText == graphModes.first
                          ? GraphMode.averageData
                          : GraphMode.individualData;
                      if (_graphModeText == graphModes.first) {
                        changePagination(graphAverageDatesText);
                      } else {
                        changePagination(graphIndividualDatesText);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aplicar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void changePagination(String? date) {
    if (graphMode == GraphMode.averageData) {
      averageChangePagination(date);
    } else {
      individualChangePagination(date);
    }
  }

  void individualChangePagination(String? date) {
    index = 0;
    bool dateFinded = false;
    while (!dateFinded) {
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
      for (var element in _presentedData) {
        if (element.month == date) {
          dateFinded = true;
        }
      }
      if (!dateFinded) {
        index -= 1;
      }
    }
  }

  void averageChangePagination(String? date) {
    index = 0;
    bool dateFinded = false;
    while (!dateFinded) {
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
      for (var element in _presentedData) {
        if (element.month == date) {
          dateFinded = true;
        }
      }
      if (!dateFinded) {
        index -= 1;
      }
    }
  }
}
