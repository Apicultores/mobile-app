import 'package:flutter/material.dart';

class ListViewHome extends StatelessWidget {

  final List<Item> myParam;
  ListViewHome(this.myParam);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: myParam.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(myParam[index].title),
                  subtitle: Text(myParam[index].subtitle)));
        });
  }
}

class Item {
  final String title;
  final String subtitle;
  const Item(this.title, this.subtitle);
 }