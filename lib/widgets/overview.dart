import 'package:flutter/material.dart';
import 'package:timey_web_scratch/shared/menu_drawer.dart';

class OverView extends StatelessWidget {
  const OverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Timey'),
          actions: [
            IconButton(
              tooltip: 'Search',
              onPressed: () {},
              icon: const Icon(
                Icons.search))
          ],),
        drawer: MenuDrawer(),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
          image: AssetImage('images/overview.png'),
          fit: BoxFit.contain,
        ))));
  }
}
