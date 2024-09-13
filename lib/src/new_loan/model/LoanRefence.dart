import 'dart:convert';

import 'package:money2me/common/response_model.dart';

ApiResponse<LoanReference> loanReferenceFromJson(Map<String,dynamic> data) => ApiResponse.fromJson(data, (data) => LoanReference.fromJson(data.first));

String loanReferenceToJson(LoanReference data) => json.encode(data.toJson());

class LoanReference extends Serializable{
  String? referenceNumber;

  LoanReference({
    this.referenceNumber,
  });

  factory LoanReference.fromJson(Map<String, dynamic> json) => LoanReference(
    referenceNumber: json["ReferenceNumber"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "ReferenceNumber": referenceNumber,
  };
}
