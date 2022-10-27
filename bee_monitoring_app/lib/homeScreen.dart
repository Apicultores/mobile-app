import 'package:bee_monitoring_app/new_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Item> homeModel = [
  Item("Valor médio", "Temperatura"),
  Item("Valor médio", "Som"),
  Item("Valor médio", "umidade"),
];

List<Item> model = [
  Item("List 1", "Here is list 1 subtitle"),
  Item("List 2", "Here is list 2 subtitle"),
  Item("List 3", "Here is list 3 subtitle"),
  Item("List 3", "Here is list 3 subtitle"),
];

class _HomeScreenState extends State<HomeScreen> {
  int _indiceAtual = 0;

  final List<Widget> _telas = [
    ListViewHome(model),
    ListViewHome(model),
    ListViewHome(model),
    ListViewHome(model)
  ];

  late List<Item> catalogdata = [];
  Future<String> loadData() async {
    var path = await rootBundle.loadString("assets/mockData.json");
    setState(() {
      var response = json.decode(path);
      List data = response['data'];
      print(data[0]);
      print(data[0]['id']);
      List<Item> list = [];
      for (var item in data) {
        list.add(Item(item['id'].toString(), item['timestamp'].toString()));
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
      body: ListViewHome(catalogdata),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        selectedIconTheme: const IconThemeData(color: Colors.amberAccent, size: 30),
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
      _indiceAtual = index;
    });
  }
}
