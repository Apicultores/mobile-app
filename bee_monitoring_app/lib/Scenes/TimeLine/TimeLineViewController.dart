import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Scenes/TimeLine/TimelineViewModel.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';

class TimeLineViewController extends StatefulWidget {
  final List<Item> data;
  const TimeLineViewController(this.data, {super.key});

  @override
  _TimeLineViewControllerState createState() => _TimeLineViewControllerState();
}

class _TimeLineViewControllerState extends State<TimeLineViewController> {
  Type _type = Type.temperatureInside;
  TimelineViewModel timelineViewModel = TimelineViewModel();
  int _groupValue = 0;
  Service service = Service();

  // MARK: - Life Cycle
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: widget.data.length + 1,
        itemBuilder: (context, index) {
          return createWidget(index);
        });
  }

  Widget createWidget(int index) {
    switch (index) {
      case 0:
        return timelineViewModel
            .createHeader(widget.data.isNotEmpty ? widget.data[index] : null);
      case 1:
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: CupertinoSlidingSegmentedControl<int>(
            backgroundColor: const Color.fromARGB(255, 231, 231, 231),
            thumbColor: Colors.amber,
            padding: const EdgeInsets.all(8),
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
        if (widget.data.isNotEmpty) {
          return timelineViewModel.buildCard(_type, widget.data[index]);
        }
        return const SizedBox();
    }
  }
}
