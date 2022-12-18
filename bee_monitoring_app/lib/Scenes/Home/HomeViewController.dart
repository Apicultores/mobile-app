import 'package:flutter/material.dart';
import 'package:bee_monitoring_app/Commons/Models/Item.dart';
import 'package:bee_monitoring_app/Scenes/Home/HomeViewModel.dart';

class HomeViewController extends StatelessWidget {
  final List<Item> data;
  HomeViewController(this.data, {super.key});
  HomeViewModel homeViewModel = HomeViewModel();

  // MARK: - Life Cycle
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 0),
        itemCount: HomeViewModel().cellList.length,
        itemBuilder: (context, index) {
          // print(index);
          return createCell(index);
        });
  }

  Widget createCell(int index) {
    return HomeViewModel().createWidget(index, data);
  }
}
