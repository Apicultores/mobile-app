import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:developer';

class Home extends StatelessWidget {
  final List<Item> data;
  Home(this.data);

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData('Jan', 11, 14, 14),
      SalesData('Feb', 14, 19, 14),
      SalesData('Mar', 23, 12, 14),
      SalesData('Apr', 12, 31, 14),
      SalesData('May', 30, 11, 14),
      SalesData('Jun', 25, 15, 14),
    ];
    return chartData;
  }

  List<String> titles = ["Médias", "Máximas", "Mínimas"];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: (Type.values.length + 1) * titles.length,
        itemBuilder: (context, index) {
          return index < 1 ? createCheckbox() : createCell(index - 1);
        });
  }

  late List<SalesData> _chartData;
  Row createCheckbox() {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: CheckboxListTile(
              title: Text("title text"),
              value: true,
              onChanged: (newValue) {
                print("oi");
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            )),
        Expanded(
            flex: 5,
            child: CheckboxListTile(
              title: Text("title text"),
              value: true,
              onChanged: (newValue) {
                print("oi");
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ))
      ],
    );

    // CheckboxListTile(
    //         title: Text("helo"),
    //         controlAffinity: ListTileControlAffinity.leading,
    //         value: true,
    //         onChanged: null,

    //       ),
    //     ),

//     CheckboxListTile(
//   title: Text("title text"),
//   value: true,
//   onChanged: (newValue) {
//       print("oi");
//   },
//   controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
// );
  }

  SfCartesianChart createChart() {
    _chartData = getChartData();
    return SfCartesianChart(
      enableAxisAnimation: true,
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: '11 jan - 18 jan'),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
          enableTooltip: true,
          name: 'sales',
          dataSource: _chartData,
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.sales,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            color: Colors.blue,
          ),
        ),
        LineSeries(
          name: 'purchase',
          dataSource: _chartData,
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.purchase,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            color: Color.fromARGB(255, 126, 19, 19),
          ),
        ),
        LineSeries(
          name: 'teste',
          dataSource: _chartData,
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.teste,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            color: Color.fromARGB(255, 255, 0, 238),
          ),
        ),
      ],
    );
  }

  Padding createCell(int index) {
    return index % (Type.values.length + 1) == 0
        ? createTitle(index)
        : createCard(index);
  }

  Padding createTitle(int index) {
    return Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
        child: Text(
          titles[(index / (Type.values.length + 1)).toInt()],
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ));
  }

  Padding createCard(int index) {
    if (index < (Type.values.length + 1)) {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(getAverage(Type.values[index - 1], data)),
                  subtitle: Text(Type.values[index - 1].value))));
    }
    if (index < (Type.values.length + 1) * 2) {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(getMax(Type.values[index - 1 - 4], data)),
                  subtitle: Text(Type.values[index - 1 - 4].value))));
    } else {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, right: 20, top: 20),
          child: Card(
              child: ListTile(
                  title: Text(getMin(Type.values[index - 1 - 8], data)),
                  subtitle: Text(Type.values[index - 1 - 8].value))));
    }
  }

  String getMax(Type type, List<Item> dataArray) {
    var sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperature:
          if (sum < int.parse(dataArray[i].temperature)) {
            sum = int.parse(dataArray[i].temperature);
          }
          break;
        case Type.humidity:
          if (sum < int.parse(dataArray[i].humidity)) {
            sum = int.parse(dataArray[i].humidity);
          }
          break;
        case Type.sound:
          if (sum < int.parse(dataArray[i].sound)) {
            sum = int.parse(dataArray[i].sound);
          }
          break;
      }
    }
    return sum.toString();
  }

  String getMin(Type type, List<Item> dataArray) {
    var sum = 1000;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperature:
          if (sum > int.parse(dataArray[i].temperature)) {
            sum = int.parse(dataArray[i].temperature);
          }
          break;
        case Type.humidity:
          if (sum > int.parse(dataArray[i].humidity)) {
            sum = int.parse(dataArray[i].humidity);
          }
          break;
        case Type.sound:
          if (sum > int.parse(dataArray[i].sound)) {
            sum = int.parse(dataArray[i].sound);
          }
          break;
      }
    }
    return sum.toString();
  }

  String getAverage(Type type, List<Item> dataArray) {
    var sum = 0;
    for (var i = 0; i < dataArray.length; i++) {
      switch (type) {
        case Type.temperature:
          sum += int.parse(dataArray[i].temperature);
          break;
        case Type.humidity:
          sum += int.parse(dataArray[i].humidity);
          break;
        case Type.sound:
          sum += int.parse(dataArray[i].sound);
          break;
      }
    }
    return (sum / dataArray.length).toStringAsFixed(2);
  }
}
