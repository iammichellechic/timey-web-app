import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../../../data/timeblocks.dart';
import 'chart_page.dart';

import '../../resources/values_manager.dart';

import '../../widgets/total_reported_time_widget.dart';
import '/presentation/utils/chart_utils.dart' as utils;

import '../../resources/formats_manager.dart';

// class WeeklyChart extends ViewModelWidget<TimeBlocksViewModel> {
//   const WeeklyChart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, TimeBlocksViewModel viewModel) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(
//           AppPadding.p12, AppPadding.p24, AppPadding.p12, AppPadding.p12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisSize: MainAxisSize.min,
//         children: [
         
//           TotalReportedTimeWidget(
//             label: 'Total Reported Time',
//             text:
//                 '${utils.getWeekTotalReportedHours(viewModel.appointmentData)}hrs',
//           ),
//           buildChartWeeklyWidget(context, viewModel),
//         ],
//       ),
//     );
//   }

//   Widget buildChartWeeklyWidget(
//       BuildContext context, TimeBlocksViewModel viewModel) {
//     List<charts.Series<utils.EntryTotal, String>> seriesData = [
//       charts.Series(
//           id: 'Reported Hours',
//           data: utils.entryTotalsByWeek(viewModel.appointmentData),
//           domainFn: (entryTotal, _) {
//             return Utils.toChartDate(entryTotal.day);
//           },
//           measureFn: (total, _) {
//             return total.value;
//           },
//           colorFn: (_, __) => charts.ColorUtil.fromDartColor(
//               Theme.of(context).colorScheme.secondary),
//           labelAccessorFn: (total, _) => total.value.toString())
//     ];

//     return Expanded(
//         child: SizedBox(
//             width: double.infinity,
//             child: ChartPage(
//               seriesData: seriesData,
//             )));
//   }
// }


class WeeklyChart  extends StatelessWidget {
  const WeeklyChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;
    
    return Padding(
      padding: EdgeInsets.fromLTRB(
          AppPadding.p12, AppPadding.p24, AppPadding.p12, AppPadding.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          TotalReportedTimeWidget(
            label: 'Total Reported Time',
            text:
                '${utils.getWeekTotalReportedHours(timeblocks)}hrs',
          ),
          buildChartWeeklyWidget(context),
        ],
      ),
    );
  }

  Widget buildChartWeeklyWidget(
      BuildContext context) {
        final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;


    List<charts.Series<utils.EntryTotal, String>> seriesData = [
      charts.Series(
          id: 'Reported Hours',
          data: utils.entryTotalsByWeek(timeblocks),
          domainFn: (entryTotal, _) {
            return Utils.toChartDate(entryTotal.day);
          },
          measureFn: (total, _) {
            return total.value;
          },
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.secondary),
          labelAccessorFn: (total, _) => total.value.toString())
    ];

    return Expanded(
        child: SizedBox(
            width: double.infinity,
            child: ChartPage(
              seriesData: seriesData,
            )));
  }
}
