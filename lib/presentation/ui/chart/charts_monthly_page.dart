import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';


import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/ui/chart/chart_page.dart';
import 'package:timey_web/presentation/widgets/total_reported_time_widget.dart';
import '../../../data/timeblocks.dart';

import '/presentation/utils/chart_utils.dart' as utils;

import '../../resources/formats_manager.dart';

// class MonthlyChart extends ViewModelWidget<TimeBlocksViewModel> {
//   const MonthlyChart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, TimeBlocksViewModel viewModel) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(
//           AppPadding.p12, AppPadding.p24, AppPadding.p12, AppPadding.p12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           TotalReportedTimeWidget(
//             label: 'Total Reported Time',
//             text:
//                 '${utils.getMonthTotalReportedHours(viewModel.appointmentData)}hrs',
//           ),
//           buildChartWidget(context, viewModel)
//         ],
//       ),
//     );
//   }

//   Widget buildChartWidget(BuildContext context, TimeBlocksViewModel viewModel) {
//     //TODO: id:tags.name
//     final ScrollController controller = ScrollController();

//     List<charts.Series<utils.EntryTotal, String>> seriesData = [
//       charts.Series(
//           id: 'Reported Hours',
//           data: utils.entryTotalsByMonth(viewModel.appointmentData),
//           domainFn: (entryTotal, _) {
//             return Utils.toChartDate(entryTotal.day);
//           },
//           measureFn: (total, _) {
//             return total.value;
//           },
//           colorFn: (total, __) => charts.ColorUtil.fromDartColor(
//               Theme.of(context).colorScheme.primary),
//           // Set a label accessor to control the text of the bar label.
//           labelAccessorFn: (total, _) => total.value.toString()),
//     ];

//     return ScrollConfiguration(
//         behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
//           PointerDeviceKind.touch,
//           PointerDeviceKind.mouse,
//         }),
//         child: ResponsiveBuilder(
//         builder: (context, sizingInformation) => SingleChildScrollView(
//           controller: controller,
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               SizedBox(
//                 width: sizingInformation.isDesktop
//                 ?
//                 MediaQuery.of(context).size.width
//                 : 1000,
//                   height: 450,
//                   child: ChartPage(
//                     seriesData: seriesData,
//                   )),
//             ],
//           ),
//         )));
//   }

// }

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppPadding.p12, AppPadding.p24, AppPadding.p12, AppPadding.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          TotalReportedTimeWidget(
            label: 'Total Reported Time',
            text: '${utils.getMonthTotalReportedHours(timeblocks)}hrs',
          ),
          buildChartWidget(context)
        ],
      ),
    );
  }

  Widget buildChartWidget(BuildContext context) {
    //TODO: id:tags.name
    final ScrollController controller = ScrollController();
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.userTimeBlock;

    List<charts.Series<utils.EntryTotal, String>> seriesData = [
      charts.Series(
          id: 'Reported Hours',
          data: utils.entryTotalsByMonth(timeblocks),
          domainFn: (entryTotal, _) {
            return Utils.toChartDate(entryTotal.day);
          },
          measureFn: (total, _) {
            return total.value;
          },
          colorFn: (total, __) => charts.ColorUtil.fromDartColor(
              Theme.of(context).colorScheme.primary),
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (total, _) => total.value.toString()),
    ];

    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: ResponsiveBuilder(
            builder: (context, sizingInformation) => SingleChildScrollView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                          width: sizingInformation.isDesktop
                              ? MediaQuery.of(context).size.width
                              : 1000,
                          height: 450,
                          child: ChartPage(
                            seriesData: seriesData,
                          )),
                    ],
                  ),
                )));
  }
}
