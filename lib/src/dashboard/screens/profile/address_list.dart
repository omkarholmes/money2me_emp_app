import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/src/dashboard/controller/address_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressListScreen extends StatefulWidget {
  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Nearest Branch',
            style: TextStyle(
              color: kWhiteColor,
            ),
          ),
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(
            color: kWhiteColor,
          ),
        ),
        body: Consumer(builder: (context, ref, child) {
          return ref.watch(addressProvider).when(data: (value) {
            return ListView.builder(
              itemCount: value.data!.length,
              padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 16).r,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: kWhiteColor,
                  surfaceTintColor: Colors.transparent,
                  child: ListTile(
                    dense: true,
                    title: Text(
                      value.data![index].city,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kBlackColor,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      value.data![index].address,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: kGreyColor,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () => launchUrl(
                        Uri.parse(googleUrl +
                            "${value.data![index].lat},${value.data![index].long}"),
                        mode: LaunchMode.externalApplication,
                      ),
                      child: Icon(
                        Icons.directions,
                        size: 35.sp,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                );
              },
            );
          }, error: (error, stacktrace) {
            if (kDebugMode) {
              print(error);
              print(stacktrace);
            }
            return Container();
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
        }));
  }
}
