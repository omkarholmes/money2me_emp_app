import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/src/dashboard/dashboard.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PaymentScreen extends StatelessWidget {
  final String transId;
  final DateTime transTime;
  final double amount;
  final String loanNo;
  const PaymentScreen(
      {super.key,
      required this.amount,
      required this.transId,
      required this.transTime,
      required this.loanNo});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName("/home"));

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: kWhiteColor,
            ),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName("/home"));
            },
          ),
          backgroundColor: kPrimaryColor,
          title: Text(
            "Payment",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: kWhiteColor),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 100.h,
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12).r,
              color: kWhiteColor,
              child: Image.asset(
                "assets/images/payment_logo.png",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 16).r,
              color: kPrimaryColor,
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: kWhiteColor,
                    size: 28.sp,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    "Transaction Successfully ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: kWhiteColor),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: kLightGrey.withOpacity(0.2),
              padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transaction Reference Number",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kMidGrey, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    transId,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: kBlackColor),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    "Transaction Date Time",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kMidGrey, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "${DateFormat.yMMMMEEEEd().format(transTime)} ${DateFormat.jm().format(transTime)}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: kBlackColor),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    "Transaction Amount",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kMidGrey, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "$amount",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: kBlackColor),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12).r,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: const BeveledRectangleBorder()),
                icon: Icon(
                  Icons.download,
                  color: kWhiteColor,
                  size: 20.sp,
                ),
                label: Text("DOWNLOAD RECEIPT",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: kWhiteColor)),
                onPressed: () {
                  createPDF();
                },
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12).r,
                child: Text(
                  "Thanks for the payment, Receipt May lake up lo 2-3 working days to he reflected in your Account",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: kBlackColor),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> createPDF() async {
    final pdf = pw.Document();
    final logoImage = (await rootBundle.load('assets/images/payment_logo.png'))
        .buffer
        .asUint8List();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Center(
                child: pw.Image(
                  pw.MemoryImage(logoImage),
                  height: 55,
                  width: 265,
                ),
              ),
              pw.Container(height: 28),
              pw.Container(
                  height: 60,
                  width: double.infinity,
                  color: PdfColors.deepPurple,
                  child: pw.Center(
                      child: pw.Text('Order Detail',
                          style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 32,
                              fontNormal: pw.Font.timesBold())))),
              pw.Container(height: 28),
              pw.Column(children: [
                //transaction_id
                pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 5),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                          bottom:
                              pw.BorderSide(color: PdfColors.grey, width: 0.5)),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Transaction id',
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.timesBold())),
                        pw.Text(transId,
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.times())),
                      ],
                    )),
                //Amount
                pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 5),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                          bottom:
                              pw.BorderSide(color: PdfColors.grey, width: 0.5)),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Amount',
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.timesBold())),
                        pw.Text(amount.toStringAsFixed(2),
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.times())),
                      ],
                    )),
                //loan_no
                pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 5),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                          bottom:
                              pw.BorderSide(color: PdfColors.grey, width: 0.5)),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Loan no.',
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.timesBold())),
                        pw.Text(loanNo,
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.times())),
                      ],
                    )),
                //order_date
                pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 5),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                          bottom:
                              pw.BorderSide(color: PdfColors.grey, width: 0.5)),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('order date',
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.timesBold())),
                        pw.Text(DateFormat.yMMMMEEEEd().format(transTime),
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.times())),
                      ],
                    )),
                //transaction_date
                pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 5),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                          bottom:
                              pw.BorderSide(color: PdfColors.grey, width: 0.5)),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Transaction date',
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.timesBold())),
                        pw.Text(DateFormat.yMMMMEEEEd().format(transTime),
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 20,
                                fontNormal: pw.Font.times())),
                      ],
                    )),
              ])
            ],
          );
        })); // Page
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/payment.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFilex.open("${output.path}/payment.pdf");
  }
}
