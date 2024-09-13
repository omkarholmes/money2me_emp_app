import 'package:money2me/common/response_model.dart';

ListResponse<LoanAddress> addressFromJson(Map<String, dynamic> data) =>
    ListResponse.fromJson(
        data,
        (data) =>
            List<LoanAddress>.from(data.map((x) => LoanAddress.fromJson(x))));

class LoanAddress extends Serializable {
  String branchAddress;
  String contactNo;
  String lat;
  String long;

  LoanAddress({
    required this.branchAddress,
    required this.contactNo,
    required this.lat,
    required this.long,
  });

  factory LoanAddress.fromJson(Map<String, dynamic> json) => LoanAddress(
        branchAddress: json["BranchAddress"],
        contactNo: json["Contactno"],
        lat: json["Lat"],
        long: json["Long"],
      );

  Map<String, dynamic> toJson() => {
        "BranchAddress": branchAddress,
        "Contactno": contactNo,
        "Lat": lat,
        "Long": long,
      };
}
