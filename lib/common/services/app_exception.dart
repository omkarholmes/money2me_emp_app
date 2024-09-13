class AppException implements Exception {
  String? message;
  String? prefix;
  int? errCode;
  dynamic data;

  AppException([this.message, this.prefix, this.errCode, this.data]);

  @override
  String toString() {
    return "$prefix $message $errCode";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message, errorCode, data])
      : super(message, "Invalid Request: ", errorCode, data);
}

class UnauthorisedException extends AppException {
  UnauthorisedException(message, errorCode)
      : super(message, "Unauthorised: ", errorCode);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
