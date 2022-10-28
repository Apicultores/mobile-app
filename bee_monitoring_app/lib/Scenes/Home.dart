import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // final List myParam;

  // Home(this.myParam);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(title: Text("teste"), subtitle: Text("home")));
        });
  }
}
