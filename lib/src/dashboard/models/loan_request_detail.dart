// To parse this JSON data, do
//
//     final loanReferenceDetailModal = loanReferenceDetailModalFromJson(jsonString);

import 'dart:convert';

import 'package:money2me/common/response_model.dart';

ApiResponse<LoanReferenceDetailModal> loanReferenceDetailModalFromJson(Map<String,dynamic> data) => ApiResponse.fromJson(data, (data) => LoanReferenceDetailModal.fromJson(data.first));

String loanReferenceDetailModalToJson(LoanReferenceDetailModal data) => json.encode(data.toJson());

class LoanReferenceDetailModal extends Serializable{
  int? reqId;
  String? schemeid;
  String? loanamount;
  String? houseno;
  String? streetaddress;
  String? landmark;
  String? pincode;
  String? createddate;
  String? createdby;
  bool? isGetStarted;
  DateTime? scheduledate;
  String? refno;

  LoanReferenceDetailModal({
    this.reqId,
    this.schemeid,
    this.loanamount,
    this.houseno,
    this.streetaddress,
    this.landmark,
    this.pincode,
    this.createddate,
    this.createdby,
    this.isGetStarted,
    this.scheduledate,
    this.refno,
  });

  factory LoanReferenceDetailModal.fromJson(Map<String, dynamic> json) => LoanReferenceDetailModal(
    reqId: json["ReqId"],
    schemeid: json["Schemeid"],
    loanamount: json["Loanamount"],
    houseno: json["Houseno"],
    streetaddress: json["Streetaddress"],
    landmark: json["Landmark"],
    pincode: json["Pincode"],
    createddate: json["Createddate"],
    createdby: json["Createdby"],
    isGetStarted: json["IsGetStarted"],
    scheduledate: DateTime.parse(json["Scheduledate"]),
    refno: json["Refno"],
  );

  Map<String, dynamic> toJson() => {
    "ReqId": reqId,
    "Schemeid": schemeid,
    "Loanamount": loanamount,
    "Houseno": houseno,
    "Streetaddress": streetaddress,
    "Landmark": landmark,
    "Pincode": pincode,
    "Createddate": createddate,
    "Createdby": createdby,
    "IsGetStarted": isGetStarted,
    "Scheduledate": scheduledate,
    "Refno": refno,
  };
}
