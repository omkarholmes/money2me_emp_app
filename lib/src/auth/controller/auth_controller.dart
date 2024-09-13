

import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/src/auth/Model/ForgetCRNModel.dart';
import 'package:money2me/src/auth/Model/LoginRequestModel.dart';
import 'package:money2me/src/auth/Model/SetMpinRequestModel.dart';
import 'package:money2me/src/auth/Model/VerifyMpinRequestModel.dart';
import 'package:money2me/src/auth/Model/otp_request_model.dart';
import 'package:money2me/src/auth/Model/user_Model.dart';

class AuthController {
  ApiService apiService = ApiService();


  Future<ApiResponse<User>> login(LoginRequestModel data) async {
    Uri uri = Uri.parse(ApiConfig.loginUrl);
    final content = await apiService.post(uri, data.toJson());
    return userFromJson(content);
  }
  Future<dynamic> forgetCrn(ForgetCRNModel data) async {
    Uri uri = Uri.parse(ApiConfig.forgetCrnUrl);
    final content = await apiService.post(uri, data.toJson());
    return content;
  }

  Future<dynamic> sendOTP(String number) async {
    Uri uri = Uri.parse(ApiConfig.sendOTPUrl);
    Map<String,dynamic> data = {
      "mobileno":number
    };
    final content = await apiService.post(uri, data);
    return content;
  }
  Future<dynamic> verifyOTP(OTPRequestModel data) async {
    Uri uri = Uri.parse(ApiConfig.verifyOTPUrl);
    final content = await apiService.post(uri, data.toJson());
    return content;
  }


  Future<ApiResponse<User>> verifyMPin(VerifyMPINRequestModel data) async{
    Uri uri = Uri.parse(ApiConfig.verifyMPinUrl);
    final content = await apiService.post(uri, data.toJson());
    return userFromJson(content);
  }

  Future<dynamic> setMPin(SetMPINRequestModel data) async{
    Uri uri = Uri.parse(ApiConfig.setMPinUrl);
    final content = await apiService.post(uri, data.toJson());
    return content;
  }
  Future<dynamic> checkIfDeviceIdExist(String deviceId) async{
    Uri uri = Uri.parse(ApiConfig.checkIfDeviceIdExistUrl);
    Map<String,dynamic> data={"deviceid":deviceId};
    final content = await apiService.post(uri, data);
    return content;
  }

  Future<String?> getId() async {
    const androidIdPlugin = AndroidId();
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isIOS) { // import 'dart:io'
        var iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else {
        String deviceId =(await androidIdPlugin.getId())?? "NA";
        // String deviceId =(await UniqueIdentifier.serial)?? "NA";
        // String deviceId =(await PlatformDeviceId.getDeviceId)?? "NA";
        return deviceId; // unique ID on Android
      }
    }catch(e){
      rethrow;
    }
  }

}