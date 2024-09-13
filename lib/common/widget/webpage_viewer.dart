
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';

class WebpageViewer extends StatelessWidget{
  String title;
  String url;
  WebpageViewer(this.url,this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 24.sp,color: kWhiteColor,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: kPrimaryColor,
        title: Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: kWhiteColor),),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8).r,
        child: InAppWebView(initialUrlRequest: URLRequest(url:Uri.parse(url)),),
      ),
    );
  }



}
