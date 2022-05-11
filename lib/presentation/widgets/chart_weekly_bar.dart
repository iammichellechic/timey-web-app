import 'package:flutter/material.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';

//THIS IS NO LONGER NEEDED//
class ChartBar extends StatelessWidget {
  final String label;
  final int reportedHours;
  final double reportedPctOfTotal;

  ChartBar(this.label, this.reportedHours, this.reportedPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          //height: AppSize.s20,
          padding: EdgeInsets.only(top: AppPadding.p20),
          child: Container(
            child: FittedBox(
              child: Text('${reportedHours.toStringAsFixed(0)} Hrs',
               style: Theme.of(context).textTheme.subtitle1),
            ),
          ),
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        Container(
          height: AppSize.s250,
          width: AppSize.s80,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.blue, width:AppSize.s1_5),
                  // color: Color.fromRGBO(220, 220, 220, 1),
                  color:ColorManager.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(AppSize.s14),
                ),
              ),
              FractionallySizedBox(
                heightFactor: reportedPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.blue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(AppSize.s14),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        Text(label, style: Theme.of(context).textTheme.subtitle1),
        SizedBox(
          height: AppSize.s20,
        ),
      ],
    );
  }
}
