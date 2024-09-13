import 'package:money2me/common/response_model.dart';

ApiResponse<LoanDetails> loanDetailsFromJson(Map<String,dynamic> data) => ApiResponse.fromJson(data, (data)=> LoanDetails.fromJson(data.first));

dynamic loanDetailsToJson(List<LoanDetails> data) => List<dynamic>.from(data.map((x) => x.toJson()));

class LoanDetails extends Serializable{
  int loanId;
  String loanNo;
  String van;
  double balancePrinciple;
  double delayCharge;
  double tillDateInterestAmt;
  String paymentSelection;
  double preUnpaidAmt;
  int delayDays;
  int noOfDays;
  int preUnpaidDays;
  double noticeCharges;
  double totalPay;

  LoanDetails({
    required this.loanId,
    required this.loanNo,
    required this.van,
    required this.balancePrinciple,
    required this.delayCharge,
    required this.tillDateInterestAmt,
    required this.paymentSelection,
    required this.preUnpaidAmt,
    required this.delayDays,
    required this.noOfDays,
    required this.preUnpaidDays,
    required this.noticeCharges,
    required this.totalPay,
  });

  factory LoanDetails.fromJson(Map<String, dynamic> json) => LoanDetails(
    loanId: json["LoanID"],
    loanNo: json["LoanNo"],
    van: json["VAN"],
    balancePrinciple: double.parse(json["BalancePrinciple"].toString()),
    delayCharge:double.parse(json["DelayCharge"].toString()),
    tillDateInterestAmt: double.parse(json["TillDateInterestAmt"].toString()),
    paymentSelection: json["PaymentSelection"],
    preUnpaidAmt: double.parse(json["PreUnpaidAmt"].toString()),
    delayDays: json["DelayDays"],
    noOfDays: json["NoOfDays"],
    preUnpaidDays:json["PreUnpaidDays"],
    noticeCharges: double.parse(json["NoticeCharges"].toString()),
    totalPay: double.parse(json["TotalPay"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "LoanID": loanId,
    "LoanNo": loanNo,
    "VAN": van,
    "BalancePrinciple": balancePrinciple,
    "DelayCharge": delayCharge,
    "TillDateInterestAmt": tillDateInterestAmt,
    "PaymentSelection": paymentSelection,
    "PreUnpaidAmt": preUnpaidAmt,
    "DelayDays": delayDays,
    "NoOfDays": noOfDays,
    "PreUnpaidDays": preUnpaidDays,
    "NoticeCharges": noticeCharges,
    "TotalPay": totalPay,
  };
}
