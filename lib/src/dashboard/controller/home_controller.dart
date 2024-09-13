import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/dashboard/models/BannerImage.dart';
import 'package:money2me/src/dashboard/models/highestRateAndLowerROI.dart';
import 'package:money2me/src/dashboard/models/loan_request_detail.dart';
import 'package:money2me/src/dashboard/models/topupAlert_model.dart';
import 'package:money2me/src/topup/models/SchemeWiseRepledge.dart';


final highestRateAndLowerROIProvider = FutureProvider.autoDispose<ApiResponse<HighestRateAndLowerROI>>((ref) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.highestRateAndLowerROIUrl);
  final dynamic response = await apiService.get(uri);
  return compute((response) => highestRateAndLowerROIList(response), response);
});

final loanRequestDetailProvider = FutureProvider.autoDispose<ApiResponse<LoanReferenceDetailModal>>((ref) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.getLoanRequestDetailsUrl);
  Map<String,String> data ={
    "mobileno":sharedPref.getString(SharedPref.mobileKey)??"",
  };
  dynamic response = await apiService.post(uri,data);
  return compute((response) => loanReferenceDetailModalFromJson(response), response);
});

final bannerProvider = FutureProvider.autoDispose<ListResponse<BannerImage>>((ref) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.bannerUrl);
  final response = await apiService.get(uri);
  return compute((response) => bannerImageFromJson(response),response);
});

final topUpAlertProvider = FutureProvider.autoDispose<ListResponse<TopupAlert>>((ref) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.topUpAlertUrl);
  Map<String,String> data ={
    "PartyCode":sharedPref.getString(SharedPref.partyCodeKey)??"",
  };
  final response = await apiService.post(uri,data);
  return compute((response) => topupAlertFromJson(response),response);
});

final topUpDetailsProvider = FutureProvider.autoDispose.family<ListResponse<SchemeWiseRepledge>,String>((ref,loanId) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.schemeWiseRepledgeUrl);
  Map<String,String> data = {
    "LoanId":loanId,
  };
  final response = await apiService.post(uri,data);
  return compute((response) => schemeWiseRepledgeFromJson(response),response);
});

