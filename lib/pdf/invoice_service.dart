// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../model/timeblock.dart';
import '../presentation/resources/formats_manager.dart';

class PdfInvoiceService {
  static Future<void> createPDF(TimeBlock invoice) async {
    //Create a PDF document
    PdfDocument document = PdfDocument();
    //Add a page and draw text
    final page = document.pages.add();

    final result = drawHeader(invoice, page);

    drawGrid(invoice, page, result);

    drawFooter(invoice, page);

    //Save the document
    List<int> bytes = await document.save();
    //Dispose the document
    document.dispose();
    //Download the output file
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "invoice.pdf")
      ..click();
  }

  static PdfLayoutResult drawHeader(TimeBlock invoice, PdfPage page) {
    final pageSize = page.getClientSize();

    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90),
    );

    page.graphics.drawString(
      'INVOICE',
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle),
    );

    page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
      brush: PdfSolidBrush(PdfColor(65, 104, 205)),
    );

    final price = '\$' + (invoice.reportedMinutes! * 200).toStringAsFixed(2);
    page.graphics.drawString(
      price,
      PdfStandardFont(PdfFontFamily.helvetica, 18),
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
      brush: PdfBrushes.white,
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
      ),
    );

    final contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

    page.graphics.drawString(
      'Amount',
      contentFont,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.bottom,
      ),
    );

    final now = DateFormat.yMMMMd().format(DateTime.now());
    final invoiceNumber = 'Invoice Number: 2058557939\r\n\r\nDate: $now';
    final contentSize = contentFont.measureString(invoiceNumber);
    const address = '''Bill To: \r\n\r\nCustomer Name, 
        \r\n\r\nAddress Line 1, 
        \r\n\r\nAddress Line 2, \r\n\r\n123456789''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
          contentSize.width + 30, pageSize.height - 120),
    );

    return PdfTextElement(text: address, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
        30,
        120,
        pageSize.width - (contentSize.width + 30),
        pageSize.height - 120,
      ),
    )!;
  }

  static void drawGrid(
      TimeBlock invoice, PdfPage page, PdfLayoutResult result) {
    final grid = PdfGrid();
    grid.columns.add(count: 5);

    final headerRow = grid.headers.add(1)[0];
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Date';
    headerRow.cells[1].value = 'ID';
    headerRow.cells[2].value = 'Reported Hours';
    headerRow.cells[3].value = 'Rate';
    headerRow.cells[4].value = 'Amount';
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);

    final row = grid.rows.add();

    row.cells[0].value = Utils.toDateTime(invoice.startDate);
    row.cells[1].value = invoice.id;
    row.cells[2].value = Utils.convertInttoString(invoice.reportedMinutes!);
    row.cells[3].value = '200 SEK/hr';
    row.cells[4].value = (invoice.reportedMinutes! * 200).toStringAsFixed(2);

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);

    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }

    for (int i = 0; i < grid.rows.count; i++) {
      final row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final cell = row.cells[j];

        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }

    result = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0),
    )!;
  }

  static void drawFooter(TimeBlock invoice, PdfPage page) {
    final pageSize = page.getClientSize();
    final color = PdfColor(142, 170, 219, 255);
    final linePen = PdfPen(color, dashStyle: PdfDashStyle.solid);
    final yLine = pageSize.height - 100;

    page.graphics.drawLine(
      linePen,
      Offset(0, yLine),
      Offset(pageSize.width, yLine),
    );

    const String footerContent = '''Business Address Line 1
        
Business Address Line 2
Any Questions? mail.com''';

    final xText = pageSize.width - 30;
    final yText = pageSize.height - 70;

    page.graphics.drawString(
      footerContent,
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(xText, yText, 0, 0),
    );
  }
}
