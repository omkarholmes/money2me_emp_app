import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/new_loan/model/Consent.dart';
import 'package:money2me/src/new_loan/model/LoanRefence.dart';
import 'package:money2me/src/new_loan/model/LoanRequest.dart';
import 'package:money2me/src/new_loan/model/schemes.dart';
import 'package:money2me/src/new_loan/model/time.dart';

final schemesProvider = FutureProvider.autoDispose<ListResponse<Scheme>>((ref) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.schemeListUrl);
  final dynamic response = await apiService.get(uri);
  return compute((response) => schemesFromJson(response), response);
});

final timeProvider = FutureProvider.autoDispose<ListResponse<Slot>>((ref) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.getTimeSlotsUrl);
  final dynamic response = await apiService.get(uri);
  return compute((response) => slotFromJson(response), response);
});

final consentProvider = FutureProvider.autoDispose<ApiResponse<Consent>>((ref) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.consentUrl);
  final dynamic response = await apiService.get(uri);
  return compute((response)=>consentFromJson(response),response);
});

class NewLoanService{
  ApiService apiService = ApiService();
  Future<ApiResponse<LoanReference>> requestLoan(LoanRequest data)async {
    Uri uri = Uri.parse(ApiConfig.requestLoanUrl);
    final content = await apiService.post(uri, data.toJson());
    return loanReferenceFromJson(content);
  }
}