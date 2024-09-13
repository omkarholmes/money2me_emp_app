import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';

class DialogHelper {
  static showAlert(
      BuildContext context, String title, String message, VoidCallback action) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              surfaceTintColor: kWhiteColor,
              actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 6).r,
              actionsAlignment: MainAxisAlignment.end,
              alignment: Alignment.center,
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 10).r,
              contentPadding: const EdgeInsets.fromLTRB(14, 16, 14, 6).r,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              title: title.isNotEmpty
                  ? Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: kBlackColor),
                    )
                  : null,
              content: SizedBox(
                  height: 40.h,
                  width: 280.h,
                  child: Text(message,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: kGreyColor),
                      textAlign: TextAlign.start)),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12)
                          .r,
                      backgroundColor: kWhiteColor,
                    ),
                    onPressed: () {
                      action();
                    },
                    child: Text(
                      "Ok",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                    )),
              ]);
        },
        barrierDismissible: false);
  }

  static showAlertWithActions(
      BuildContext context,
      String title,
      String message,
      VoidCallback primaryAction,
      VoidCallback secondaryAction,
      String primary,
      String secondary) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              surfaceTintColor: kWhiteColor,
              actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 6).r,
              actionsAlignment: MainAxisAlignment.end,
              alignment: Alignment.center,
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 10).r,
              contentPadding: const EdgeInsets.fromLTRB(14, 16, 14, 6).r,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              title: title.isNotEmpty
                  ? Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: kBlackColor),
                    )
                  : null,
              content: SizedBox(
                  height: 40.h,
                  width: 280.h,
                  child: Text(message,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: kGreyColor),
                      textAlign: TextAlign.start)),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12)
                          .r,
                      backgroundColor: kWhiteColor,
                    ),
                    onPressed: secondaryAction,
                    child: Text(
                      secondary,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600, color: kRedColor),
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12)
                          .r,
                      backgroundColor: kWhiteColor,
                    ),
                    onPressed: primaryAction,
                    child: Text(
                      primary,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                    )),
              ]);
        },
        barrierDismissible: false);
  }

  static showLoadingIndicator(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
  }

  static hide(context) {
    Navigator.pop(context);
  }
}
