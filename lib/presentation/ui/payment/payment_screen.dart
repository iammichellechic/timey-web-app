import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/ui/payment/payment_page.dart';



class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTableItems(context);
  }

  Widget buildTableItems(BuildContext context) {
    final ScrollController controller = ScrollController();

    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: Scaffold(
            body: ResponsiveBuilder(
          builder: (context, sizingInformation) => SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.vertical,
            child: Center(
                child: SizedBox(
                    width: sizingInformation.isDesktop
                        ? MediaQuery.of(context).size.width * 0.8
                        : 1000,
                    height: 1300,
                    child: PaymentTable())),
          ),
        )));
  }
}
