import 'package:money2me/common/response_model.dart';

ApiResponse<Faq> checkLimitFromJson(dynamic data) =>
    ApiResponse.fromJson(data, (value) => Faq.fromJson(value.first));

List<dynamic> checkLimitToJson(List<Faq> data) =>
    List<dynamic>.from(data.map((x) => x.toJson()));

class Faq extends Serializable {
  String title;
  String description;

  Faq({
    required this.title,
    required this.description,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
