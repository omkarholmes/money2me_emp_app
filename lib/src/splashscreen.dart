import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/common/widget/background.dart';
import 'package:money2me/common/widget/button.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/auth/controller/auth_controller.dart';
import 'package:money2me/src/versionUpgradeController.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  bool isOldVersion = false;
  String appLink = "";
  AuthController authController = AuthController();
  dynamic route;
  String deviceId = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterAlignment: AlignmentDirectional.centerEnd,
        persistentFooterButtons: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : isOldVersion
                  ? KTextButton(
                      onPressed: () {
                        print(appLink);
                        launchUrl(
                          Uri.parse(
                              appLink),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      text: 'Update',
                    )
                  : KTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, route);
                      },
                      text: 'Get Started',
                    ),
        ],
        body: Background(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16).r,
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/money_to_me_logo.png",
                      width: 250.h,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Image.asset(
                      "assets/images/gold_loan_logo.png",
                      width: 280.h,
                      fit: BoxFit.fitWidth,
                    ),
                  ]),
            ),
          ),
        ));
  }

  void checkDeviceId() async {
    try {
      deviceId = (await authController.getId())!;
      if (deviceId != null) {
        await authController.checkIfDeviceIdExist(deviceId);
        sharedPref.setBool(SharedPref.isMPinSetKey, true);
        route = "/m_pin";
      }
    } on PlatformException catch (_) {
      DialogHelper.showAlert(context, "Error ", "Something went wrong", () {
        Navigator.pop(context);
      });
      route = "/login";
      sharedPref.setBool(SharedPref.isMPinSetKey, false);
    } on AppException catch (_) {
      route = "/login";
      sharedPref.setBool(SharedPref.isMPinSetKey, false);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.version);
    await checkVersion(packageInfo.version);
    checkDeviceId();
  }

  Future checkVersion(String version) async{
    await VersionUpgraderController().checkVersion(version).then((value) {

      setState(() {
        isOldVersion = false;
      });
    }).catchError((onError) {
      print(onError.toString());
      if (onError is AppException && onError.errCode == 412) {
        setState(() {
          isOldVersion = true;
          appLink = onError.message ?? "";
        });
      }
    });
  }
}
