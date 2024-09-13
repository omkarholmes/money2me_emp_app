import 'package:flutter/material.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/src/dashboard/screens/profile/update_profile_details_form.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Profile Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfielDetailsForms(),
                      ),
                    );
                  },
                  child: Container(
                    color: kPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: kWhiteColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "EDIT",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: kWhiteColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Container(
          //         color: kPrimaryColor,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 20.0, vertical: 10),
          //           child: Text(
          //             "Submit",
          //             style: TextStyle(
          //                 color: kWhiteColor,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
