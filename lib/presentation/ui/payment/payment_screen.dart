import 'package:flutter/material.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return buildPaymentWidget(context);
  }
}

Widget buildPaymentWidget(BuildContext context){
   return SizedBox(child: Center(child: Text('This is the payment section')));
}
