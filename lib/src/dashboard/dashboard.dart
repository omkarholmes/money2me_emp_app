import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/widget/background.dart';
import 'package:money2me/src/dashboard/Controller/dashboard_controller.dart';
import 'package:money2me/src/dashboard/screens/home/home.dart';
import 'package:money2me/src/dashboard/screens/my_loan/my_loan.dart';
import 'package:money2me/src/dashboard/screens/profile/profile.dart';
import 'package:money2me/src/dashboard/screens/repay_loan/repay_loan.dart';
import 'package:money2me/src/dashboard/screens/statement/statement.dart';

class Dashboard extends StatefulWidget {
  const Dashboard( {
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

   late List<Widget> _pages ;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _pages =  [
       HomeScreen(),
       MyLoanScreen(),
       RepayLoanScreen(),
       StatementScreen(),
       ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Consumer(
          builder: (context,ref,child) {
            return _pages[ref.watch(dashboardProvider).selectedIndex];
          }
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context,ref,child) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  activeIcon: Icon(Icons.home),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.attach_money_rounded,
                  ),
                  activeIcon: Icon(
                    Icons.attach_money_rounded,
                  ),
                  label: "My Loan"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.credit_card,
                  ),
                  activeIcon: Icon(
                    Icons.credit_card,
                  ),
                  label: "Repay Loan"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.receipt_rounded,
                  ),
                  activeIcon: Icon(
                    Icons.receipt_rounded,
                  ),
                  label: "Statement"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  activeIcon: Icon(
                    Icons.person,
                  ),
                  label: "Profile"),
            ],
            type: BottomNavigationBarType.shifting,
            useLegacyColorScheme: true,
            iconSize: 22.sp,
            elevation: 0,
            currentIndex: ref.watch(dashboardProvider).selectedIndex,
            unselectedLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(color: kLightGrey,fontWeight: FontWeight.w500,),
            selectedLabelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: kWhiteColor,fontWeight: FontWeight.w600),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedItemColor: kWhiteColor,
            unselectedItemColor: kLightGrey,
            onTap: (index) {
              ref.read(dashboardProvider).changeIndex(index);
            },
          );
        },
      ),
    );
  }
}
