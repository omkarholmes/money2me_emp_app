// To parse this JSON data, do
//
//     final loanRequest = loanRequestFromJson(jsonString);

import 'dart:convert';

import 'package:money2me/src/new_loan/model/schemes.dart';

LoanRequest loanRequestFromJson(String str) => LoanRequest.fromJson(json.decode(str));

String loanRequestToJson(LoanRequest data) => json.encode(data.toJson());

class LoanRequest {
  Scheme? scheme;
  String? loanamount;
  DateTime? scheduleddatetime;
  String? houseno;
  String? streetaddress;
  String? landmark;
  String? pincode;
  String? createdby;

  LoanRequest({
    this.scheme,
    this.loanamount,
    this.scheduleddatetime,
    this.houseno,
    this.streetaddress,
    this.landmark,
    this.pincode,
    this.createdby,
  });

  factory LoanRequest.fromJson(Map<String, dynamic> json) => LoanRequest(
    scheme: json["schemeid"],
    loanamount: json["loanamount"],
    scheduleddatetime: json["scheduleddatetime"],
    houseno: json["houseno"],
    streetaddress: json["streetaddress"],
    landmark: json["landmark"],
    pincode: json["pincode"],
    createdby: json["createdby"],
  );

  Map<String, dynamic> toJson() => {
    "schemeid": scheme?.schemeName,
    "loanamount": loanamount,
    "scheduleddatetime": scheduleddatetime.toString(),
    "houseno": houseno,
    "streetaddress": streetaddress,
    "landmark": landmark,
    "pincode": pincode,
    "createdby": createdby,
  };
}
