import 'dart:convert';

import 'package:money2me/common/response_model.dart';

ListResponse<Ornament> ornamentFromJson(Map<String, dynamic> data) =>
    ListResponse.fromJson(data,
        (list) => List<Ornament>.from(list.map((x) => Ornament.fromJson(x))));

String ornamentToJson(List<Ornament> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ornament extends Serializable {
  int cAMID;
  int cAMItemID;
  int itemID;
  String itemName;
  int noOfItems;
  double grossWtGrm;

  Ornament(
      {required this.cAMID,
      required this.cAMItemID,
      required this.itemID,
      required this.itemName,
      required this.noOfItems,
      required this.grossWtGrm});

  factory Ornament.fromJson(Map<String, dynamic> json) => Ornament(
        cAMID: json['CAMID'],
        cAMItemID: json['CAMItemID'],
        itemID: json['ItemID'],
        itemName: json['ItemName'],
        noOfItems: json['NoOfItems'],
        grossWtGrm: json['GrossWtGrm'],
      );

  Map<String, dynamic> toJson() => {
        'CAMID': this.cAMID,
        'CAMItemID': this.cAMItemID,
        'ItemID': this.itemID,
        'ItemName': this.itemName,
        'NoOfItems': this.noOfItems,
        'GrossWtGrm': this.grossWtGrm,
      };
}
