import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/dashboard/models/address.dart';

final addressProvider = FutureProvider.autoDispose<ListResponse<Address>>((ref) async {
  ApiService apiService = ApiService();
  final Uri uri = Uri.parse(ApiConfig.addressUrl);
  final dynamic response = await apiService.get(uri);
  return compute((response) => addressFromJson(response), response);
});
