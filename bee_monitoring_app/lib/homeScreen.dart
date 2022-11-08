import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:bee_monitoring_app/Scenes/TimeLine/Timeline.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';
import 'package:bee_monitoring_app/Scenes/Home/Home.dart';
import 'package:bee_monitoring_app/Scenes/Chart/Chart.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Item> _data = [];

  // MARK: - Life Cycle
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Apicultores",
          style: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: _currentIndex == 0 ? Home(_data) : sceneHandler(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.amberAccent,
        onTap: onTabTapped,
        selectedIconTheme: const IconThemeData(color: Colors.black, size: 30),
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ("Resumo")),
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph), label: "Gráficos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: ("Histórico"))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  StatefulWidget sceneHandler() {
    switch (_currentIndex) {
      case 1:
        return Chart(_data);
      default:
        return TimeLine(_data, Type.temperatureInside);
    }
  }

  // MARK: - Load Data
  Future<String> loadData() async {
    var path = await rootBundle.loadString("assets/mockData.json");

    var response = json.decode(path);
    List data = response['data'];
    List<Item> list = [];

    for (var item in data) {
      list.add(Item(
          item['id'].toString(),
          item['temperatura_dentro'].toString(),
          item['temperatura_fora'].toString(),
          item['umidade_dentro'].toString(),
          item['umidade_fora'].toString(),
          item['som'].toString(),
          DateFormat("yyyy-MM-dd hh:mm:ss").parse(item['timestamp'])));
    }

    setState(() {
      _data = list;
    });

    return "success";
  }
}
