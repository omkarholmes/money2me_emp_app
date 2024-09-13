import 'dart:convert';

import 'package:money2me/common/response_model.dart';

ApiResponse<Consent> consentFromJson(Map<String,dynamic> data) => ApiResponse.fromJson(data, (data) => Consent.fromJson(data.first));

// String consentToJson(Consent data) => json.encode(data.toJson());

class Consent extends Serializable{
  String? consentDesc;

  Consent({
    this.consentDesc,
  });

  factory Consent.fromJson(Map<String, dynamic> json) => Consent(
    consentDesc: json["ConsentDesc"],
  );

  Map<String, dynamic> toJson() => {
    "ConsentDesc": consentDesc,
  };
}
