import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/dashboard/models/statement.dart';


final statementProvider = FutureProvider.autoDispose.family<ListResponse<Statement>,String>((ref,loanId) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.loanWiseStatementUrl);
  Map<String,dynamic> body = {
    "LoanId": loanId,
  };
  final dynamic response = await apiService.post(uri,body);
  return compute((response) => statementFromJson(response), response);
});
