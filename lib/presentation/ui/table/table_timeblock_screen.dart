import 'package:flutter/material.dart';

import 'package:timey_web/presentation/ui/table/table_timeblock_page.dart';


class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTableItems(context);
  }

  Widget buildTableItems(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(child: MyDataTable()),
      ),
    );
  }
}
