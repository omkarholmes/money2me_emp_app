// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

import 'package:money2me/common/response_model.dart';

ListResponse<Transaction> transactionsFromJson(Map<String,dynamic> data) => ListResponse.fromJson(data,(list) => List<Transaction>.from(list.map((value) => Transaction.fromJson(value))));

String transactionToJson(List<Transaction> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaction extends Serializable{
  String voucherNo;
  String voucherDate;
  double disburseAmount;
  double priniciple;
  double interestAmount;
  double dealyAmount;
  double legalCharge;
  double prevunpaidAmount;
  double noticeCharges;
  int noOfDays;
  int delayDays;
  double roi;
  double balancePriniple;

  Transaction({
    required this.voucherNo,
    required this.voucherDate,
    required this.disburseAmount,
    required this.priniciple,
    required this.interestAmount,
    required this.dealyAmount,
    required this.legalCharge,
    required this.prevunpaidAmount,
    required this.noticeCharges,
    required this.noOfDays,
    required this.delayDays,
    required this.roi,
    required this.balancePriniple,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    voucherNo: json["VoucherNo"],
    voucherDate: json["VoucherDate"],
    disburseAmount: double.parse(json["DisburseAmount"].toString()),
    priniciple: double.parse(json["Priniciple"].toString()),
    interestAmount: double.parse(json["InterestAmount"].toString()),
    dealyAmount: double.parse(json["DealyAmount"].toString()),
    legalCharge: double.parse(json["LegalCharge"].toString()),
    prevunpaidAmount: double.parse(json["PrevunpaidAmount"].toString()),
    noticeCharges: double.parse(json["NoticeCharges"].toString()),
    noOfDays: json["NoOfDays"],
    delayDays: json["DelayDays"],
    roi: double.parse(json["ROI"].toString()),
    balancePriniple: double.parse(json["BalancePriniple"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "VoucherNo": voucherNo,
    "VoucherDate": voucherDate,
    "DisburseAmount": disburseAmount,
    "Priniciple": priniciple,
    "InterestAmount": interestAmount,
    "DealyAmount": dealyAmount,
    "LegalCharge": legalCharge,
    "PrevunpaidAmount": prevunpaidAmount,
    "NoticeCharges": noticeCharges,
    "NoOfDays": noOfDays,
    "DelayDays": delayDays,
    "ROI": roi,
    "BalancePriniple": balancePriniple,
  };
}
