import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/auth/Model/LoginRequestModel.dart';
import 'package:money2me/src/auth/Model/kyc_details_model.dart';
import 'package:money2me/src/auth/Model/user_Model.dart';
import 'package:money2me/src/dashboard/models/kyc_details.dart';

import '../models/document_type.dart';
import '../models/existing_doc.dart';

final userProfile = FutureProvider.autoDispose
    .family<ApiResponse<User>, LoginRequestModel>(
        (ref, loginRequestmodel) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.loginUrl);
  Map<String, dynamic> body = loginRequestmodel.toJson();
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => userFromJson(response), response);
});

final profielDetails = FutureProvider.autoDispose
    .family<ApiResponse<KYCDetails>, KYCRequestModel>((ref, kycModel) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.profileDetailsUrl);
  Map<String, dynamic> body = kycModel.toJson();
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => kycDetailsFromJson(response), response);
});

final existingDocuments = FutureProvider.autoDispose
    .family<ListResponse<ExistingDoc>, KYCRequestModel>((ref, kycModel) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.existingDocuments);
  Map<String, dynamic> body = kycModel.toJson();
  final dynamic response = await apiService.post(uri, body);
  return compute((response) => existingDocsFromJson(response), response);
});

final documentTypes = FutureProvider.autoDispose
    .family<ListResponse<DocumentType>, KYCRequestModel>((ref, kycModel) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.documentTypes);
  // Map<String, dynamic> body = kycModel.toJson();
  final dynamic response = await apiService.post(uri, {});
  return compute((response) => documentTypeFromJson(response), response);
});

Future<dynamic> uploadDocument(DocumentType doc) async {
  ApiService apiService = ApiService();
  Uri uri = Uri.parse(ApiConfig.uploadImages);
  final content = await apiService.postMultiPart(uri, doc);
  print(content);
  return content["data"][0]["PublicURL"];
}

Future<dynamic> submitKYCDetails(KYCDetails details) async {
  ApiService apiService = ApiService();
  Uri uri = Uri.parse(ApiConfig.partyChangeRequest);
  final content =
      await apiService.post(uri, details.toPartyChaangeRequest().toJson());
  print(content);
  return content["data"][0]["PublicURL"];
}
