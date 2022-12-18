import 'package:bee_monitoring_app/Commons/services/file_manager.dart';
import 'package:bee_monitoring_app/Scenes/device_list.dart';
import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Scenes/TimeLine/TimeLineViewController.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/repository/json_data_repository.dart';
import 'package:bee_monitoring_app/Scenes/Home/HomeViewController.dart';
import 'package:bee_monitoring_app/Scenes/Chart/ChartViewController.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import '../Scenes/ble_status_screen.dart';
part 'AppBarActions.dart';

class NagivationController extends StatefulWidget {
  @override
  _NagivationControllerState createState() => _NagivationControllerState();
}

class _NagivationControllerState extends State<NagivationController> {
  int _currentIndex = 0;
  List<Item> _data = [];

  // MARK: - Life Cycle
  @override
  void initState() {
    super.initState();
  }

  Widget handleOffstage(index, data) {
    if (data.isNotEmpty) {
      if (index == 0) return HomeViewController(data);
      if (index == 1) return ChartViewController(data);
      if (index == 2) return TimeLineViewController(data);
    }
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Text('Aguardando dados'),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) =>
      Consumer<BleStatus?>(builder: (_, status, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Apicultores",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            actions: createAppBarActions(status),
          ),
          body: FutureBuilder(
              future: loadData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      Offstage(
                        offstage: _currentIndex != 0,
                        child: handleOffstage(0, snapshot.data),
                      ),
                      Offstage(
                        offstage: _currentIndex != 1,
                        child: handleOffstage(1, snapshot.data),
                      ),
                      Offstage(
                        offstage: _currentIndex != 2,
                        child: handleOffstage(2, snapshot.data),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            backgroundColor: Colors.amber,
            selectedIconTheme:
                const IconThemeData(color: Colors.black, size: 30),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Resumo"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.auto_graph), label: "Gráficos"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: "Histórico")
            ],
          ),
        );
      });

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // MARK: - Load Data
  Future loadData() async {
    if (context.read<JsonRepository>().items.isNotEmpty) {
      return context.read<JsonRepository>().items;
    }
    await context.read<JsonRepository>().readData();
    setState(() {
      _data = context.read<JsonRepository>().items;
    });
    return _data;
  }
}
