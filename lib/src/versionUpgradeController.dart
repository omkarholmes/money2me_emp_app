import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';

class VersionUpgraderController {
  ApiService apiService = ApiService();
  Future<dynamic> checkVersion(String version) async {
    Uri uri = Uri.parse(ApiConfig.versionUrl);
    final content = await apiService.post(uri, {
      "passversion": version,
    });
    return content;
  }
}
