import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/dashboard/models/callback_model.dart';

class CallbackController {
  ApiService apiService = ApiService();

  Future<ApiResponse<CallbackResponseModel>> submitCallback(CallbackModel data) async {
    Uri uri = Uri.parse(ApiConfig.callbackUrl);
    final content = await apiService.post(uri, data.toJson());
    return callbackResponseJson(content);
  }
}
