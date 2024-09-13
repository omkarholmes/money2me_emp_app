import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/topup/models/topup_request.dart';

import '../../common/services/api_config.dart';

class TopupController{
  ApiService apiService= ApiService();

  Future<dynamic> requestTopup(TopupRequest data) async {
    Uri uri = Uri.parse(ApiConfig.requestTopupUrl);
    final content = await apiService.post(uri, data.toJson());
    return content;
  }

}