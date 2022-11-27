import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Commons/Enums/Type.dart';
import 'package:bee_monitoring_app/Scenes/Home/HomeViewModel.dart';
import 'package:bee_monitoring_app/Commons/Service.dart';

class HomeViewController extends StatelessWidget {
  final List<Item> data;
  HomeViewController(this.data);
  HomeViewModel homeViewModel = HomeViewModel();

  // MARK: - Life Cycle
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 0),
        itemCount: HomeViewModel().cellList.length,
        itemBuilder: (context, index) {
          return createCell(index);
        });
  }

  Widget createCell(int index) {
    return HomeViewModel().createWidget(index, data);
  }
}
