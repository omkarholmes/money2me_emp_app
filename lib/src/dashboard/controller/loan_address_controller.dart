import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/dashboard/models/loan_address.dart';

final loanAddressProvider =
    FutureProvider.family<ListResponse<LoanAddress>, int>((ref, userId) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.loanAddressUrl);
  Map<String, dynamic> body = {
    "partyid": userId.toString(),
  };
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => addressFromJson(response), response);
});
