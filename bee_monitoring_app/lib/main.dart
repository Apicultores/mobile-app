import 'package:bee_monitoring_app/bluetooth.dart';
import 'package:bee_monitoring_app/homeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apicultores',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const HasData(),
    );
  }
}

class HasData extends StatefulWidget {
  const HasData({super.key});

  @override
  State<HasData> createState() => _HasDataState();
}

class _HasDataState extends State<HasData> {
  @override
  void initState() {
    super.initState();
    _hasData().then((value) => {
          Future.delayed(
            const Duration(seconds: 2),
            () => value
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Bluetooth(),
                    ),
                  ),
          )
        });
  }

  Future<bool> _hasData() async {
    var result = false;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apicultores',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 6,
        ),
      ),
    );
  }
}
