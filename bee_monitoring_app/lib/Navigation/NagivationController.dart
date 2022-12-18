import 'package:bee_monitoring_app/Commons/services/file_manager.dart';
import 'package:bee_monitoring_app/Scenes/device_list.dart';
import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Scenes/TimeLine/TimeLineViewController.dart';
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

  // MARK: - Life Cycle
  @override
  void initState() {
    super.initState();
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
                if (snapshot.hasData && snapshot.data != null) {
                  return Stack(
                    children: [
                      Offstage(
                        offstage: _currentIndex != 0,
                        child: HomeViewController(snapshot.data),
                      ),
                      Offstage(
                        offstage: _currentIndex != 1,
                        child: ChartViewController(snapshot.data),
                      ),
                      Offstage(
                        offstage: _currentIndex != 2,
                        child: TimeLineViewController(snapshot.data),
                      ),
                    ],
                  );
                } else {
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
                    ),
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
    await context.read<JsonRepository>().readData();
    if (context.read<JsonRepository>().items.isEmpty) {
      setState(() {});
      return null;
    }
    return context.read<JsonRepository>().items;
  }
}
