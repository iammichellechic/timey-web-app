import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/presentation/resources/color_manager.dart';
import '../../data/providers/timeblocks.dart';
import '../widgets/dialogs_widget.dart';

class MyDataTable extends StatefulWidget {
  const MyDataTable({Key? key}) : super(key: key);

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  int? sortColumnIndex;
  bool isAscending = false;
  bool isFetched = false;

  @override
  Widget build(BuildContext context) {
    // final timeblocksData = Provider.of<TimeBlocks>(context);
    // final timeblocks = timeblocksData.userTimeBlock;

    // //sorting doesnt work
    // //initState list != null sort
    // int compareValues(bool ascending, DateTime value1, DateTime value2) =>
    //     ascending ? value1.compareTo(value2) : value2.compareTo(value1);

    // void onSort(int columnIndex, bool ascending) {
    //   if (columnIndex == 1) {
    //     timeblocks.sort((user1, user2) =>
    //         compareValues(ascending, user1.startDate, user2.startDate));
    //   } else if (columnIndex == 2) {
    //     timeblocks.sort((user1, user2) =>
    //         compareValues(ascending, user1.endDate, user2.endDate));
    //   }

    //   setState(() {
    //     this.sortColumnIndex = columnIndex;
    //     this.isAscending = ascending;
    //   });
    // }

    return Container(
        child: Consumer<TimeBlocks>(builder: (context, task, child) {
      if (isFetched == false) {
        ///Fetch the data
        task.getTimeblocks(true);

        Future.delayed(const Duration(seconds: 3), () => isFetched = true);
      }
      return RefreshIndicator(
          onRefresh: () {
            task.getTimeblocks(false);
            return Future.delayed(const Duration(seconds: 3));
          },
          child: (task.getResponseData().isNotEmpty)
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: task.getResponseData().length,
                  itemBuilder: (context, index) {
                    final tb = task.getResponseData()[index];
                    return Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${tb["datetimeStart"]}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text("${tb["datetimeEnd"]}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ])
                        ]));
                  })
              : Container(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("No timeblocks found"),
                  )));
    }));
  }
}
