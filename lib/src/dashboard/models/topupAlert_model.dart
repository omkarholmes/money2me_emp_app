import 'package:money2me/common/response_model.dart';

ListResponse<TopupAlert> topupAlertFromJson(Map<String, dynamic> data) =>
    ListResponse<TopupAlert>.fromJson(
        data,
        (list) =>
            List<TopupAlert>.from(list.map((e) => TopupAlert.fromJson(e))));

class TopupAlert extends Serializable {
  int? loanId;
  String? loanNo;
  DateTime loanDate;
  bool? isProcessed;

  TopupAlert({this.loanId, this.loanNo, required this.loanDate, this.isProcessed});

  factory TopupAlert.fromJson(Map<String, dynamic> json) => TopupAlert(
        loanId: json["LoanID"],
        loanNo: json["LoanNo"],
        loanDate: DateTime.parse(json["LoanDate"]),
        isProcessed: json["IsProcessed"],
      );

  Map<String, dynamic> toJson() => {
        "LoanID": loanId,
        "LoanNo": loanNo,
        "LoanDate": loanDate,
        "IsProcessed": isProcessed
      };
}
