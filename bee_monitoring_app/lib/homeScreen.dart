import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:bee_monitoring_app/Scenes/ProprietyTimeline.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';
import 'package:bee_monitoring_app/Scenes/Home.dart';
import 'package:bee_monitoring_app/Scenes/Chart.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Item> catalogdata = [];

  Future<String> loadData() async {
    var path = await rootBundle.loadString("assets/mockData.json");
    setState(() {
      var response = json.decode(path);
      List data = response['data'];
      List<Item> list = [];
      print(DateFormat("yyyy-MM-dd hh:mm:ss").parse(data[0]['timestamp']));
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
        print("catalogdata = list;!!!");
        catalogdata = list;
      });
    });
    return "success";
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  StatefulWidget sceneHandler() {
    switch (_currentIndex) {
      case 1:
        return Chart(catalogdata);
      default:
        return ListViewHome(catalogdata, Type.temperatureInside);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Apicultores",
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: _currentIndex == 0 ? Home(catalogdata) : sceneHandler(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        selectedIconTheme:
            const IconThemeData(color: Colors.amberAccent, size: 30),
        selectedItemColor: Colors.amberAccent,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ("Resumo")),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Graficos"),
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
}
