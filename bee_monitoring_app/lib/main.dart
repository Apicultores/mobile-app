import 'package:bee_monitoring_app/Commons/repository/json_data_repository.dart';
import 'package:bee_monitoring_app/Navigation/NagivationController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => JsonRepository())],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<JsonRepository>().readData();

    return MaterialApp(
      title: 'Apicultores',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: NagivationController(),
    );
  }
}
