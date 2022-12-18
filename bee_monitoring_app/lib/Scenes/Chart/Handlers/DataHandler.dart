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

    while (dataStateTemp.isNotEmpty) {
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
    print(chartData.length);

    return chartData;
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

    return chartData;
  }
}
