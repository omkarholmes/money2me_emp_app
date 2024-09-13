import 'dart:convert';

import 'package:money2me/common/response_model.dart';

ListResponse<Loan> loanFromJson(Map<String, dynamic> data) =>
    ListResponse.fromJson(
        data, (list) => List<Loan>.from(list.map((x) => Loan.fromJson(x))));

String loanToJson(List<Loan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Loan extends Serializable {
  int loanId;
  String vanNo;
  String loanNo;
  DateTime loanDate;
  double loanAmount;
  String schemeName;
  String lastRecciptDate;
  DateTime loanDueDate;
  String loanTenureDate;
  String partyName;
  double loanRoi;
  bool forCloser;
  bool forPartRelease;

  Loan({
    required this.loanId,
    required this.vanNo,
    required this.loanNo,
    required this.loanDate,
    required this.loanAmount,
    required this.schemeName,
    required this.lastRecciptDate,
    required this.loanDueDate,
    required this.loanTenureDate,
    required this.partyName,
    required this.loanRoi,
    required this.forPartRelease,
    required this.forCloser,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        loanId: json["LoanID"],
        vanNo: json["VanNo"],
        loanNo: json["LoanNo"],
        loanDate: DateTime.parse(json["LoanDate"]),
        loanAmount: json["LoanAmount"],
        schemeName: json["SchemeName"],
        lastRecciptDate: json["LastRecciptDate"],
        loanDueDate: DateTime.parse(json["LoanDueDate"]),
        loanTenureDate: json["LoanTenureDate"],
        partyName: json["PartyName"],
        loanRoi: json["LoanROI"],
        forCloser: json["forCloser"] == "NO" ? false : true,
        forPartRelease: json["forpartrelease"] == "NO" ? false : true,
      );

  Map<String, dynamic> toJson() => {
        "LoanID": loanId,
        "VanNo": vanNo,
        "LoanNo": loanNo,
        "LoanDate": loanDate,
        "LoanAmount": loanAmount,
        "SchemeName": schemeName,
        "LastRecciptDate": lastRecciptDate,
        "LoanDueDate": loanDueDate,
        "LoanTenureDate": loanTenureDate,
        "PartyName": partyName,
        "LoanROI": loanRoi,
      };
}
