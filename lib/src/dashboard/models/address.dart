import 'package:money2me/common/response_model.dart';

ListResponse<Address> addressFromJson(Map<String, dynamic> data) =>
    ListResponse.fromJson(
      data,
      (data) => List<Address>.from(
        data.map(
          (x) => Address.fromJson(x),
        ),
      ),
    );

List<dynamic> addressJson(List<Address> data) =>
    List<dynamic>.from(data.map((x) => x.toJson()));

class Address extends Serializable {
  String city;
  String address;
  String lat;
  String long;

  Address({
    required this.city,
    required this.address,
    required this.lat,
    required this.long,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["BranchName"],
        address: json["Citydesc"],
        lat: json["Lat"],
        long: json["Long"],
      );

  Map<String, dynamic> toJson() => {
        "BranchName": city,
        "Citydesc": address,
        "Lat": lat,
        "Long": long,
      };
}
