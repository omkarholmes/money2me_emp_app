import 'package:money2me/common/response_model.dart';

ApiResponse<CallbackModel> callbackFromJson(Map<String, dynamic> data) =>
    ApiResponse.fromJson(data, (data) => CallbackModel.fromJson(data.first));

ApiResponse<CallbackResponseModel> callbackResponseJson(
        Map<String, dynamic> data) =>
    ApiResponse.fromJson(
        data, (data) => CallbackResponseModel.fromJson(data.first));

class CallbackModel extends Serializable {
  String reason;
  String partyId;

  CallbackModel({
    required this.reason,
    required this.partyId,
  });

  factory CallbackModel.fromJson(Map<String, dynamic> json) => CallbackModel(
        reason: json["remarks"],
        partyId: json["partyid"],
      );

  Map<String, dynamic> toJson() => {
        "remarks": reason,
        "partyId": partyId,
      };
}

class CallbackResponseModel extends Serializable {
  String colSuccess;

  CallbackResponseModel({
    required this.colSuccess,
  });

  factory CallbackResponseModel.fromJson(Map<String, dynamic> json) =>
      CallbackResponseModel(
        colSuccess: json["ColSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "ColSuccess": colSuccess,
      };
}
