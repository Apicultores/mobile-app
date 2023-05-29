part of 'package:bee_monitoring_app/Scenes/Chart/ChartViewController.dart';

extension DataHandler on _ChartViewControllerState {
  Future loadData() async {
    setState(() {
      _averageChartData = handleAverageData().toSet().toList();
      _individualChartData = handleIndividualData();
      _presentedData = _averageChartData
          .getRange(_averageChartData.length - 6, _averageChartData.length)
          .toList();
      graphAverageDates = _averageChartData.map((e) => e.date).toSet().toList();
      graphAverageDatesText = graphAverageDates.last;

      graphIndividualDates =
          _individualChartData.map((e) => e.date).toSet().toList();
      graphIndividualDatesText =
          graphIndividualDates.isNotEmpty ? graphIndividualDates.last : '';
    });
  }

  List<ChartItem> handleAverageData() {
    final List<ChartItem> chartData = [];
    List<Item> dataStateTemp = widget.data;

    var firstDate = dataStateTemp.first.timestamp.day;

    var initIndex = 0;
    var finalIndex = 0;

    while (finalIndex + 1 < dataStateTemp.length) {
      while (firstDate == dataStateTemp[finalIndex + 1].timestamp.day) {
        finalIndex++;
        if (finalIndex + 1 >= dataStateTemp.length) {
          finalIndex--;
          break;
        }
      }

      chartData.insert(
          0,
          ChartItem(
              convertDateToString(dataStateTemp[initIndex].timestamp),
              service.getAverage(Type.temperatureInside,
                  dataStateTemp.sublist(initIndex, finalIndex)),
              service.getAverage(Type.temperatureOutside,
                  dataStateTemp.sublist(initIndex, finalIndex)),
              service.getAverage(Type.humidityInside,
                  dataStateTemp.sublist(initIndex, finalIndex)),
              service.getAverage(Type.humidityOutside,
                  dataStateTemp.sublist(initIndex, finalIndex)),
              service.getAverage(
                  Type.sound, dataStateTemp.sublist(initIndex, finalIndex))));

      if (finalIndex + 1 < dataStateTemp.length) {
        finalIndex += 1;
        initIndex = finalIndex;
        firstDate = dataStateTemp[initIndex].timestamp.day;
      } else {
        break;
      }
    }

    while (chartData.length < 6) {
      chartData.insert(0, ChartItem("", 0, 0, 0, 0, 0));
    }

    return chartData.reversed.toList();
  }

  List<ChartItem> handleIndividualData() {
    final List<ChartItem> chartData = [];
    final List<Item> dataStateTemp = widget.data;

    while (dataStateTemp.isNotEmpty) {
      chartData.insert(
          0,
          ChartItem(
              convertDateToStringWithHour(dataStateTemp.first.timestamp),
              double.parse(dataStateTemp.first.temperatureInside),
              double.parse(dataStateTemp.first.temperatureOutside),
              double.parse(dataStateTemp.first.humidityInside),
              double.parse(dataStateTemp.first.humidityOutside),
              double.parse(dataStateTemp.first.sound)));
      dataStateTemp.removeAt(0);
    }

    return chartData.reversed.toList();
  }
}
