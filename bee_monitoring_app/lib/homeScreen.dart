import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:bee_monitoring_app/Scenes/ProprietyTimeline.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Scenes/Home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late List<Item> catalogdata = [];

  Future<String> loadData() async {
    var path = await rootBundle.loadString("assets/mockData.json");
    setState(() {
      var response = json.decode(path);
      List data = response['data'];
      List<Item> list = [];
      for (var item in data) {
        list.add(Item(
            item['id'].toString(),
            item['temperatura'].toString(),
            item['umidade'].toString(),
            item['som'].toString(),
            item['timestamp'].toString()));
      }

      setState(() {
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
      body: _currentIndex == 0
          ? Home(catalogdata)
          : ListViewHome(catalogdata, Type.values[_currentIndex - 1]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        selectedIconTheme:
            const IconThemeData(color: Colors.amberAccent, size: 30),
        selectedItemColor: Colors.amberAccent,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ("início")),
          BottomNavigationBarItem(
              icon: Icon(Icons.thermostat_auto), label: "Temperatura"),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: ("Úmidade")),
          BottomNavigationBarItem(icon: Icon(Icons.radio), label: ("Som")),
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
