import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Item.dart';
import 'package:bee_monitoring_app/Commons/Type.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';
import 'package:bee_monitoring_app/Scenes/Home/HomeViewModel.dart';

class Home extends StatelessWidget {
  final List<Item> data;
  Home(this.data);

  Service service = Service();
  HomeViewModel homeViewModel = HomeViewModel();

  // MARK: - Life Cycle
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 10),
        itemCount: (Type.values.length + 1) * HomeViewModel().titles.length,
        itemBuilder: (context, index) {
          return createCell(index);
        });
  }

  Padding createCell(int index) {
    return index % (Type.values.length + 1) == 0
        ? HomeViewModel().createTitle(index)
        : HomeViewModel().createCard(index, data);
  }
}
