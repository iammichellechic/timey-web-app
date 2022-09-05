import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:timey_web/model/timeblock.dart';
import 'package:timey_web/pdf/save_pdf.dart';

import '../presentation/resources/formats_manager.dart';

class PdfInvoice {
  static Future<File> generate(TimeBlock invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        // buildTitle(invoice),
        // buildInvoice(invoice),
        Divider(),
        //buildTotal(invoice),
      ],
      // footer: (context) => //buildFooter(invoice),
    ));

    return SavePdf.saveDocument(name: 'timereport_invoice.pdf', pdf: pdf);
  }


  static Widget buildHeader(TimeBlock invoice) => Column(children: [
        Text('Hi'),
        SizedBox(height: 10),
        Text(Utils.convertInttoString(invoice.hours!)),
        SizedBox(height: 10),
        Text('Hi'),
        SizedBox(height: 10),
      ]);
}
