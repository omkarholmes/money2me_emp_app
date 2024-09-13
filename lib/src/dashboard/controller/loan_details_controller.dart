import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/dashboard/models/checkLimit.dart';
import 'package:money2me/src/dashboard/models/checkauction.dart';
import 'package:money2me/src/dashboard/models/loan_detail_request.dart';
import 'package:money2me/src/dashboard/models/loan_details.dart';
import 'package:money2me/src/dashboard/models/transaction.dart';

final interestPaymentProvider = FutureProvider.autoDispose
    .family<ApiResponse<LoanDetails>, LoanDetailRequest>(
        (ref, loanDetailRequest) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.loanDetailsUrl);
  dynamic body = loanDetailRequest.toJson();
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => loanDetailsFromJson(response), response);
});

final loanCloserProvider = FutureProvider.autoDispose
    .family<ApiResponse<LoanDetails>, LoanDetailRequest>(
        (ref, loanDetailRequest) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.loanDetailsUrl);
  Map<String, dynamic> body = loanDetailRequest.toJson();
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => loanDetailsFromJson(response), response);
});

final checkAuctionProvider = FutureProvider.autoDispose
    .family<ApiResponse<Auction>, String>((ref, loanNo) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.checkAuctionUrl);
  Map<String, dynamic> body = {
    "LoanNo": loanNo,
  };
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => auctionFromJson(response), response);
});

final checkLimitInterestPaymentProvider =
    FutureProvider.family<ApiResponse<CheckLimit>, LoanDetailRequest>(
        (ref, loanDetailRequest) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.checkTodaysLimitUrl);
  Map<String, dynamic> body = loanDetailRequest.toJson();
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => checkLimitFromJson(response), response);
});

final checkLimitLoanCloserProvider =
    FutureProvider.family<ApiResponse<CheckLimit>, LoanDetailRequest>(
        (ref, loanDetailRequest) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.checkTodaysLimitUrl);
  Map<String, dynamic> body = loanDetailRequest.toJson();
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => checkLimitFromJson(response), response);
});

final transactionProvider =
    FutureProvider.family<ListResponse<Transaction>, String>(
        (ref, loanId) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.transactionDetailsUrl);
  Map<String, dynamic> body = {
    "LoanId": loanId,
  };
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => transactionsFromJson(response), response);
});

class LoanRepayProvider {
  Future<ApiResponse<CheckLimit>> checkLimit(
      LoanDetailRequest loanDetailRequest) async {
    ApiService apiService = ApiService();
    final Uri uri = Uri.parse(ApiConfig.checkTodaysLimitUrl);
    Map<String, dynamic> body = loanDetailRequest.toJson();
    final dynamic response = await apiService.post(uri, body);
    return compute((response) => checkLimitFromJson(response), response);
  }

  Future<ApiResponse<Auction>> checkAuction(String loanNo) async {
    ApiService apiService = ApiService();
    final Uri uri = Uri.parse(ApiConfig.checkAuctionUrl);
    Map<String, dynamic> body = {
      "LoanNo": loanNo,
    };
    final dynamic response = await apiService.post(uri, body);
    return compute((response) => auctionFromJson(response), response);
  }
}
