import 'package:bee_monitoring_app/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  // MultiProvider(providers: [
  //   ChangeNotifierProvider(create: ((context) => DataRepository())
  // ],)
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
      home: HomeScreen(),
    );
  }
}
