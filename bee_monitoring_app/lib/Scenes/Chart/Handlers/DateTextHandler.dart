part of 'package:bee_monitoring_app/Scenes/Chart/ChartViewController.dart';

extension DateTextHandler on _ChartViewControllerState {
  String convertDateToString(DateTime date) {
    String day =
        date.day < 10 ? "0${date.day.toString()}" : date.day.toString();
    String month =
        date.month < 10 ? "0${date.month.toString()}" : date.month.toString();
    String year = date.year.toString();
    String cropedYear = year.substring(year.length - 2, year.length);
    return "$day/$month/$cropedYear";
  }

  String convertDateToStringWithHour(DateTime date) {
    String hour =
        date.day < 10 ? "0${date.hour.toString()}" : date.hour.toString();
    hour = hour == "0" ? "00" : hour;
    String minute =
        date.day < 10 ? "0${date.minute.toString()}" : date.minute.toString();
    minute = minute == "0" ? "00" : minute;
    String second =
        date.day < 10 ? "0${date.second.toString()}" : date.second.toString();
    second = second == "0" ? "00" : second;
    String day =
        date.day < 10 ? "0${date.day.toString()}" : date.day.toString();
    String month =
        date.month < 10 ? "0${date.month.toString()}" : date.month.toString();
    String year = date.year.toString();
    String cropedYear = year.substring(year.length - 2, year.length);
    return "$hour:$minute:$second\n$day/$month/$cropedYear";
  }
}
