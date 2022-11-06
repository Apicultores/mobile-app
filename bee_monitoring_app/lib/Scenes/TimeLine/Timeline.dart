import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';
import 'package:bee_monitoring_app/Scenes/TimeLine/TimelineViewModel.dart';

class TimeLine extends StatefulWidget {
  final List data;
  final Type type;
  TimeLine(this.data, this.type);

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  List _data = [];
  Type _type = Type.temperatureInside;
  TimelineViewModel timelineViewModel = TimelineViewModel();
  int _groupValue = 0;

  // MARK: - Life Cycle
  void initState() {
    super.initState();
    _data = widget.data;
    _type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return index == 0
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
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
                )
              : 
              timelineViewModel.buildCard(_type, _data[index]);
        });
  }
}
