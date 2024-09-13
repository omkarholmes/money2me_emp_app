import 'package:money2me/common/response_model.dart';

ApiResponse<CheckLimit> checkLimitFromJson(dynamic data) =>
    ApiResponse.fromJson(data, (value) => CheckLimit.fromJson(value.first));
List<dynamic> checkLimitToJson(List<CheckLimit> data) =>
    List<dynamic>.from(data.map((x) => x.toJson()));

class CheckLimit extends Serializable {
  int loanId;
  double todaysLimit;

  CheckLimit({
    required this.loanId,
    required this.todaysLimit,
  });

  factory CheckLimit.fromJson(Map<String, dynamic> json) => CheckLimit(
        loanId: json["loanid"],
        todaysLimit: double.parse(json["Todayslimit"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "loanid": loanId,
        "Todayslimit": todaysLimit,
      };
}
