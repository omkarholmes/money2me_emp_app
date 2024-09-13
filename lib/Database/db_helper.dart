import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/auth/Model/user_Model.dart';

class DbHelper {

  static Future<void> saveUserdata(User? user) async {
    print(user?.name);
    sharedPref.setString(SharedPref.userNameKey, user?.partyfullname??"");
    sharedPref.setString(SharedPref.emailKey, user?.emailId??"");
    sharedPref.setString(SharedPref.mobileKey, user?.mobileNo??"");
    sharedPref.setString(SharedPref.partyCodeKey, user?.partyCode??"");
    sharedPref.setInt(SharedPref.partyIdKey, user?.partyId??-1);
  }
}
