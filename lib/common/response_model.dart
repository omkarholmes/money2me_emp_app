class ApiResponse<T extends Serializable> {
  bool? status;
  String? message;
  T? data;
  ApiResponse({this.status, this.message, this.data});

  factory ApiResponse.fromJson(dynamic json, Function(dynamic) create) {
    return ApiResponse<T>(
      status: json["status"],
      message: json["message"],
      data: create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": this.status,
        "message": this.message,
        "data": this.data?.toJson(),
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}

class ListResponse<T extends Serializable> {
  bool? status;
  String? message;
  List<T>? data;

  ListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ListResponse.fromJson(Map<String, dynamic> data, Function(List) create) {
    return ListResponse<T>(
        status: data["status"], message: data["message"], data: create(data['data']));
  }
}
