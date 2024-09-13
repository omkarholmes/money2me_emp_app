import 'package:flutter/material.dart';
import 'package:money2me/common/config/theme.dart';

class Background extends StatelessWidget{
 final Widget child;
  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
   return Container(
     height: double.infinity,
     width: double.infinity,
     decoration: const BoxDecoration(
       color: kWhiteColor,
       image: DecorationImage(
         // colorFilter: ColorFilter.mode(Colors.white, BlendMode.clear),
           image: AssetImage("assets/images/app_background.png",),fit: BoxFit.fill,),
     ),
     child: child,
   );
  }

}