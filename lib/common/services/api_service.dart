import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/src/dashboard/models/document_type.dart';

class ApiService {
  Future<dynamic> get(Uri uri, {Map<String, String>? headers}) async {
    final Map<String, String> _headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    try {
      final response = await http
          .get(uri, headers: headers ?? _headers)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection.");
    }
  }

  Future<dynamic> post(Uri uri, dynamic body,
      {Map<String, String>? headers}) async {
    final Map<String, String> _headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    print(body);
    try {
      final response = await http
          .post(uri, body: body, headers: headers ?? _headers)
          .timeout(const Duration(minutes: 1));
      print(response);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection.");
    }
  }

  Future<dynamic> postMultiPart(Uri uri, DocumentType body,
      {Map<String, String>? headers}) async {
    try {
      var request = new http.MultipartRequest("POST", uri);
      request.files
          .add(await http.MultipartFile.fromPath("imageFile", body.filePath!));
      request.fields.addAll({"imageName": body.docUnderID.toString()});
      return request.send().then((response) async {
        return _returnResponse(await http.Response.fromStream(response));
      });
    } on SocketException {
      throw FetchDataException("No Internet Connection.");
    }
  }

  // dynamic _returnResponse(http.Response response) {
  //
  //   switch (response.statusCode) {
  //     case 200:
  //       var responseJson = json.decode(response.body.toString().toString());
  //       return responseJson;
  //     case 400:
  //       throw BadRequestException(json.decode(response.body)["message"],400);
  //     case 404:
  //       throw BadRequestException(json.decode(response.body)["message"],404);
  //     case 401:
  //       throw UnauthorisedException(response.body.toString(), response.statusCode);
  //     case 403:
  //       throw UnauthorisedException(response.body.toString(), response.statusCode);
  //     case 500:
  //     default:
  //       throw FetchDataException(
  //           'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  //   }
  // }

  dynamic _returnResponse(http.Response response) {
    if (response.statusCode == 200) {
      var _response = jsonDecode(response.body);
      print(_response);
      switch (int.parse(_response["statuscode"])) {
        case 200:
          var responseJson = _response;
          return responseJson;
        case 400:
          throw BadRequestException(_response["statusmessage"], 400);
        case 412:
          throw BadRequestException(
              _response["statusmessage"], 412, _response["data"].toString());
        case 403:
          throw UnauthorisedException(
              response.body.toString(), response.statusCode);
        case 500:
        default:
          throw FetchDataException(
              'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } else {
      print(response.body.toString());
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
