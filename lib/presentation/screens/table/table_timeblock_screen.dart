import 'package:flutter/material.dart';
import 'package:timey_web/presentation/pages/table_timeblock_page.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';


//right now this screen has no purpose

class EditablePage extends StatefulWidget {
  const EditablePage({Key? key}) : super(key: key);

  @override
  State<EditablePage> createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: buildTableItems(context));
  }

  Widget buildTableItems(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: AppPadding.p30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              //Chart(timeblocksData.recentEntries), //no prupose
              MyDataTable()
            ],
          ),
        ),
      ),
    );
  }
}
