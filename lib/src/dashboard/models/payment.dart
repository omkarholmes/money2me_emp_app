
import 'dart:convert';
import 'package:money2me/src/dashboard/models/loan_details.dart';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  String? orderId;
  int? loanId;
  int? partyId;
  double? amount;
  int? pgId;
  String? transDate;
  bool? isTransComp;
  bool? isPaymentRced;
  String? orderStatus;
  String? comments;
  String? alteredDate;
  double? noticecharges;
  double? delaycharges;
  double? interest;
  double? prvunpaid;
  double? principle;
  double? noticechargesPaid;
  double? delaychargesPaid;
  double? interestPaid;
  double? prvunpaidPaid;
  double? principlePaid;
  double? unpaid;
  int? unpaidDays;
  String? van;
  String? inttype;
  int? noOfDays;
  int? delayDays;
  String? paymentFlag;
  int? paymentgetway;

  Payment({
    this.orderId,
    this.loanId,
    this.partyId,
    this.amount,
    this.pgId,
    this.transDate,
    this.isTransComp,
    this.isPaymentRced,
    this.orderStatus,
    this.comments,
    this.alteredDate,
    this.noticecharges,
    this.delaycharges,
    this.interest,
    this.prvunpaid,
    this.principle,
    this.noticechargesPaid,
    this.delaychargesPaid,
    this.interestPaid,
    this.prvunpaidPaid,
    this.principlePaid,
    this.unpaid,
    this.unpaidDays,
    this.van,
    this.inttype,
    this.noOfDays,
    this.delayDays,
    this.paymentFlag,
    this.paymentgetway,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      Payment(
        loanId: json["LoanId"],
        partyId: json["PartyId"],
        amount: json["Amount"],
        pgId: json["PG_Id"],
        transDate: json["TransDate"],
        isTransComp: json["isTransComp"],
        isPaymentRced: json["isPaymentRced"],
        orderStatus: json["OrderStatus"],
        comments: json["Comments"],
        alteredDate: json["AlteredDate"],
        noticecharges: json["Noticecharges"],
        delaycharges: json["Delaycharges"],
        interest: json["Interest"],
        prvunpaid: json["Prvunpaid"],
        principle: json["Principle"],
        noticechargesPaid: json["NoticechargesPaid"],
        delaychargesPaid: json["DelaychargesPaid"],
        interestPaid: json["InterestPaid"],
        prvunpaidPaid: json["PrvunpaidPaid"],
        principlePaid: json["PrinciplePaid"],
        unpaid: json["Unpaid"],
        unpaidDays: json["UnpaidDays"],
        van: json["Van"],
        inttype: json["inttype"],
        noOfDays: json["NoOfDays"],
        delayDays: json["DelayDays"],
        paymentFlag: json["PaymentFlag"],
        paymentgetway: json["Paymentgetway"],
      );

  Map<String, dynamic> toJson() =>
      {
        "orderId": orderId.toString(),
        "LoanId": loanId.toString(),
        "PartyId": partyId.toString(),
        "Amount": amount.toString(),
        "PG_Id": pgId.toString(),
        "TransDate": transDate.toString(),
        "isTransComp": isTransComp.toString(),
        "isPaymentRced": isPaymentRced.toString(),
        "OrderStatus": orderStatus.toString(),
        "Comments": comments.toString(),
        "AlteredDate": alteredDate.toString(),
        "Noticecharges": noticecharges.toString(),
        "Delaycharges": delaycharges.toString(),
        "Interest": interest.toString(),
        "Prvunpaid": prvunpaid.toString(),
        "Principle": principle.toString(),
        "NoticechargesPaid": noticechargesPaid.toString(),
        "DelaychargesPaid": delaychargesPaid.toString(),
        "InterestPaid": interestPaid.toString(),
        "PrvunpaidPaid": prvunpaidPaid.toString(),
        "PrinciplePaid": principlePaid.toString(),
        "Unpaid": unpaid.toString(),
        "UnpaidDays": unpaidDays.toString(),
        "Van": van.toString(),
        "inttype": inttype.toString(),
        "NoOfDays": noOfDays.toString(),
        "DelayDays": delayDays.toString(),
        "PaymentFlag": paymentFlag.toString(),
        "Paymentgetway": paymentgetway.toString(),
      };


  copyWithLoanData(LoanDetails data) {
    loanId = data.loanId;
    noticecharges = data.noticeCharges;
    delaycharges = data.delayCharge;
    interest = data.tillDateInterestAmt;
    prvunpaid = data.preUnpaidAmt;
    principle = data.balancePrinciple;
    van = data.van;
    noOfDays = data.noOfDays;
    delayDays = data.delayDays;
    noticechargesPaid = 0;
    delaychargesPaid = 0;
    interestPaid = 0;
    prvunpaidPaid = 0;
    principlePaid = 0;
    unpaidDays = data.preUnpaidDays;
  }

}