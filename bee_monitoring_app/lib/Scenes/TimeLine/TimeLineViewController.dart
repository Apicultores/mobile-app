import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Scenes/TimeLine/TimelineViewModel.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';

class TimeLineViewController extends StatefulWidget {
  final List<Item> data;
  TimeLineViewController(this.data);

  @override
  _TimeLineViewControllerState createState() => _TimeLineViewControllerState();
}

class _TimeLineViewControllerState extends State<TimeLineViewController> {
  List<Item> _data = [];
  Type _type = Type.temperatureInside;
  TimelineViewModel timelineViewModel = TimelineViewModel();
  int _groupValue = 0;
  Service service = Service();
  
  // MARK: - Life Cycle
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return 
    ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: _data.length + 1,
        itemBuilder: (context, index) {
          return createWidget(index);
        });
  }

  Widget createWidget(int index) {
    switch (index) {
      case 0:
        return timelineViewModel.createHeader();
      case 1:
        return 
        Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10, bottom: 5, right: 10, top: 25),
                  child: CupertinoSlidingSegmentedControl<int>(
                    backgroundColor: Color.fromARGB(255, 231, 231, 231),
                    thumbColor: Color.fromARGB(255, 255, 245, 186),
                    padding: EdgeInsets.all(8),
                    groupValue: _groupValue,
                    children: {
                      0: timelineViewModel.buildSegment("Temperatura"),
                      1: timelineViewModel.buildSegment("Umidade"),
                      2: timelineViewModel.buildSegment("Som"),
                    },
                    onValueChanged: (value) {
                      setState(() {
                        _groupValue = value ?? 0;
                        if (value == 0) {
                          _type = Type.temperatureInside;
                        } else if (value == 1) {
                          _type = Type.humidityInside;
                        } else {
                          _type = Type.sound;
                        }
                      });
                    },
                  ),
                );
      default:
      return timelineViewModel.buildCard(_type, _data[index]);
    }
  }

  // MARK: - Load Data
  Future loadData() async {
    service.loadData().then((value) {
      setState(() {
        _data = value;
      });
    });
  }
}
