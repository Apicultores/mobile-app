import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:bee_monitoring_app/Scenes/TimeLine/TimeLineViewController.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';
import 'package:bee_monitoring_app/Scenes/Home/HomeViewController.dart';
import 'package:bee_monitoring_app/Scenes/Chart/ChartViewController.dart';
import 'package:intl/intl.dart';

class NagivationManager extends StatefulWidget {
  @override
  _NagivationManagerState createState() => _NagivationManagerState();
}

class _NagivationManagerState extends State<NagivationManager> {
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
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _currentIndex != 0,
            child: HomeViewController(_data),
          ),
          Offstage(
            offstage: _currentIndex != 1,
            child: ChartViewController(_data),
          ),
          Offstage(
            offstage: _currentIndex != 2,
            child: TimeLineViewController(_data),
          ),
        ],
      ),
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

  // MARK: - Load Data
  Future loadData() async {
    Service service = Service();
    service.loadData().then((value) {
      setState(() {
        _data = value;
      });
    });
  }
}