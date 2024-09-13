// To parse this JSON data, do
//
//     final schemes = schemesFromJson(jsonString);

import 'dart:convert';

import 'package:money2me/common/response_model.dart';

ListResponse<Scheme> schemesFromJson(dynamic data) => ListResponse.fromJson(data,(data)=>List<Scheme>.from(data.map((x) => Scheme.fromJson(x))));

String schemesToJson(List<Scheme> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Scheme extends Serializable{
  String schemeName;
  double perMonthRoi;
  int ratePerGram;

  Scheme({
    required this.schemeName,
    required this.perMonthRoi,
    required this.ratePerGram,
  });

  factory Scheme.fromJson(Map<String, dynamic> json) => Scheme(
    schemeName: json["SchemeName"],
    perMonthRoi: json["PerMonthROI"]?.toDouble(),
    ratePerGram: json["RatePerGram"],
  );

  Map<String, dynamic> toJson() => {
    "SchemeName": schemeName,
    "PerMonthROI": perMonthRoi,
    "RatePerGram": ratePerGram,
  };
}
