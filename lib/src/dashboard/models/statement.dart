
import 'package:money2me/common/response_model.dart';

ListResponse<Statement> statementFromJson(Map<String, dynamic> data) =>
    ListResponse<Statement>.fromJson(data,
        (list) => List<Statement>.from(list.map((x) => Statement.fromJson(x))));

List<dynamic> statementToJson(List<Statement> data) =>
    List<dynamic>.from(data.map((x) => x.toJson()));

class Statement extends Serializable {
  int? loanid;
  DateTime receiptDate;
  double? totalPay;
  double? principlepaid;
  double? interestPaid;
  int? paidDays;
  double? loanRoi;
  String? partyName;

  Statement({
    required this.loanid,
    required this.receiptDate,
    required this.totalPay,
    required this.principlepaid,
    required this.interestPaid,
    required this.paidDays,
    required this.loanRoi,
    required this.partyName,
  });

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
        loanid: json["Loanid"],
        receiptDate: DateTime.parse(json["ReceiptDate"]),
        totalPay: json["TotalPay"],
        principlepaid: json["Principlepaid"],
        interestPaid: json["InterestPaid"],
        paidDays: json["PaidDays"],
        loanRoi: json["LoanROI"]?.toDouble(),
        partyName: json["PartyName"],
      );

  Map<String, dynamic> toJson() => {
        "Loanid": loanid,
        "ReceiptDate": receiptDate,
        "TotalPay": totalPay,
        "Principlepaid": principlepaid,
        "InterestPaid": interestPaid,
        "PaidDays": paidDays,
        "LoanROI": loanRoi,
        "PartyName": partyName,
      };
}
