part of 'package:bee_monitoring_app/Scenes/Chart/ChartViewController.dart';

extension DataHandler on _ChartViewControllerState {
  Future loadData() async {
    service.loadData().then((value) {
      setState(() {
        _allData = value;
        _averageChartData = handleAverageData().toSet().toList();
        _individualChartData = handleIndividualData();
        _presentedData = _averageChartData
            .getRange(_averageChartData.length - 6, _averageChartData.length)
            .toList();
        graphAverageDates =
            _averageChartData.map((e) => e.date).toSet().toList();
        graphAverageDatesText = graphAverageDates.last;

        graphIndividualDates =
            _individualChartData.map((e) => e.date).toSet().toList();
        graphIndividualDatesText = graphIndividualDates.last;
      });
    });
  }

  List<ChartItem> handleAverageData() {
    final List<ChartItem> chartData = [];
    final List<Item> dataStateTemp = _allData.toList();

    var firstDate = dataStateTemp.first.timestamp.day;

    List<Item> tempArray = [];
    var initIndex = 0;
    var finalIndex = 0;

    while (finalIndex+1 < dataStateTemp.length) {
      while (firstDate == dataStateTemp[finalIndex+1].timestamp.day) {
        finalIndex++;
        if (finalIndex+1 >= dataStateTemp.length) {
          finalIndex--;
          break;
        }
      }
        print(initIndex);
        print(finalIndex);

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

          // break;
          if (finalIndex+1 < dataStateTemp.length) {
              finalIndex += 1; 
              initIndex = finalIndex;
              firstDate = dataStateTemp[initIndex].timestamp.day;
          } else {
            break;
          }
    }

    while (chartData.length < 6) {
      chartData.insert(0,ChartItem("",0,0,0,0,0));
    }
    return chartData;
  }

  List<ChartItem> handleAverageData2() {
    final List<ChartItem> chartData = [];
    List<Item> dataStateTemp = _allData.toList();

    while (dataStateTemp.isNotEmpty) {
      DateTime currentDate = dataStateTemp.first.timestamp;
      List<Item> tempArray = [];

      while (dataStateTemp.first.timestamp.day == currentDate.day) {
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

  List<ChartItem> handleIndividualData() {
    final List<ChartItem> chartData = [];
    final List<Item> dataStateTemp = _allData.toList();

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
