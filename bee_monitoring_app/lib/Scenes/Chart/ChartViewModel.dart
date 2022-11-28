part of 'ChartViewController.dart';

extension ChartViewModel on _ChartViewControllerState {
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

  // MARK: - Chart Presented Data
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