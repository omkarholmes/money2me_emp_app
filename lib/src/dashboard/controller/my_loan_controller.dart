import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/dashboard/models/loan.dart';
import 'package:money2me/src/dashboard/models/ornament.dart';

final loanProvider = FutureProvider.autoDispose
    .family<ListResponse<Loan>, int>((ref, userId) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.loanUrl);
  Map<String, dynamic> body = {
    "Partyid": userId.toString(),
  };
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => loanFromJson(response), response);
});

final ornamentProvider = FutureProvider.autoDispose
    .family<ListResponse<Ornament>, int>((ref, loanId) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.partReleaseUrl);
  Map<String, dynamic> body = {
    "LoanId": loanId.toString(),
  };
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => ornamentFromJson(response), response);
});
