
import 'package:money2me/common/response_model.dart';

ListResponse<SchemeWiseRepledge> schemeWiseRepledgeFromJson(Map<String,dynamic> data) => ListResponse.fromJson(data, (list) => List<SchemeWiseRepledge>.from(list.map((e) => SchemeWiseRepledge.fromJson(e))));

class SchemeWiseRepledge extends Serializable{
  String? loanNo;
  String? loanDate;
  int? maxLoan;
  int? loanAmtEligible;
  int? existingLoanSettlement;
  String? schemeName;
  int? finalDisAmt;
  int? days;
  int? repledge;
  String? rate;
  int? ratePerGram;
  int? schemeId;

  SchemeWiseRepledge({
    this.loanNo,
    this.loanDate,
    this.maxLoan,
    this.loanAmtEligible,
    this.existingLoanSettlement,
    this.schemeName,
    this.finalDisAmt,
    this.days,
    this.repledge,
    this.rate,
    this.ratePerGram,
    this.schemeId
  });

  factory SchemeWiseRepledge.fromJson(Map<String, dynamic> json) => SchemeWiseRepledge(
    loanNo: json["LoanNo"],
    loanDate: json["LoanDate"],
    maxLoan: json["MaxLoan"],
    loanAmtEligible: json["LoanAmtEligible"],
    existingLoanSettlement: json["ExistingLoanSettlement"],
    schemeName: json["SchemeName"],
    schemeId: json["SchemeID"],
    finalDisAmt: json["FinalDisAmt"],
    days: json["days"],
    repledge: json["Repledge"],
    rate: json["Rate"],
    ratePerGram: json["RatePerGram"],
  );

  Map<String, dynamic> toJson() => {
    "LoanNo": loanNo,
    "LoanDate": loanDate,
    "MaxLoan": maxLoan,
    "LoanAmtEligible": loanAmtEligible,
    "ExistingLoanSettlement": existingLoanSettlement,
    "SchemeName": schemeName,
    "SchemeID":schemeId,
    "FinalDisAmt": finalDisAmt,
    "days": days,
    "Repledge": repledge,
    "Rate": rate,
    "RatePerGram": ratePerGram,
  };
}
