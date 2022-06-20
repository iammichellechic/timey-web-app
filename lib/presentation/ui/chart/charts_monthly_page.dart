import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:timey_web/presentation/resources/color_manager.dart';
import 'package:timey_web/presentation/resources/values_manager.dart';
import 'package:timey_web/presentation/widgets/chart_widget.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '/presentation/utils/chart_utils.dart' as utils;
import '../../../data/providers/timeblocks.dart';
import '../../resources/formats_manager.dart';

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text( 'Monthly Time Report',
              style: Theme.of(context).textTheme.headline1),
          ),
          const SizedBox(height:AppPadding.p6),
          Padding(
            padding: EdgeInsets.only(left: AppPadding.p20),
            child: buildTotalReportedHours(context),
          ),
          buildChartWidget(context),
        ],
      ),
    );
  }

  Widget buildChartWidget(BuildContext context) {
    //can also use consumer here than provider.of
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks =
        timeblocksData.getResponseFromQuery(); //list of timeblocks

    //DO: id:tags.name

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
          colorFn: (total, __) =>
              charts.ColorUtil.fromDartColor(ColorManager.primary),
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (total, _) => total.value.toString()),
    ];

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: ChartWidget(
            seriesData: seriesData,
         
    )));
  }

  Widget buildTotalReportedHours(BuildContext context) {
    final timeblocksData = Provider.of<TimeBlocks>(context);
    final timeblocks = timeblocksData.getResponseFromQuery(); 
    return Container(
      width: AppSize.s250,
      height: AppSize.s60,
      decoration: BoxDecoration(
          color: ColorManager.secondaryContainer,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ]),

      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 15),
        title: Text('Total Reported Time:',
            style: makeYourOwnRegularStyle(
                letterSpacing: 1.2,
                fontSize: FontSize.s12,
                color: ColorManager.grey)),
        subtitle: Text('${utils.getMonthTotalReportedHours(timeblocks)}hrs',
            style: makeYourOwnBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.onSecondaryContainer)),   
    ));
  }
}
