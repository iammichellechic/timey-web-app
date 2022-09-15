import 'package:flutter/material.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';

class TablePage extends StatelessWidget {
  
  final List<DataColumn> tableColumns;
  final List<DataRow> tableRows;
  final double? dataRowHeight;
  // final List<TimeBlock> tb;

  const TablePage({
    Key? key,
    
    required this.tableColumns,
    required this.tableRows,
    required this.dataRowHeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(top: AppPadding.p40),
            child: Column(children: [
              const SizedBox(height: AppSize.s30),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ]),
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      clipBehavior: Clip.hardEdge,
                      child: DataTable(
                       
                        //settings//
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2))),
                        dataRowHeight: dataRowHeight,
                        showCheckboxColumn: false,
                        dividerThickness: 0,
                        columnSpacing: 80,
                        //headingRowColor: MaterialStateColor.resolveWith((states) {return ColorManager.primaryContainer;}),

                        columns: tableColumns,
                        rows: tableRows,
                      )))
            ])));
  }
}
