import 'package:flutter/material.dart';
import 'package:jamqpwa/Invite.dart';
import 'AboutUs.dart';
import 'InputNumber.dart';
import 'MainPage.dart';
import 'Profile.dart';
import 'Shop.dart';
import 'SplashScreen.dart';
import 'VerifyCode.dart';

void main() => runApp(JamQ());

class JamQ extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'جام کیو',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryIconTheme: IconThemeData(color: Colors.green),
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black))
      ),
      initialRoute: "/SplashScreen",
      routes: {
        "/MainPage" : (context) =>  new Directionality(textDirection: TextDirection.rtl, child:MainPage.none()),
        "/SplashScreen" : (context) =>  new Directionality(textDirection: TextDirection.rtl, child:SplashScreen()),
        "/InputNumber" : (context) =>  new Directionality(textDirection: TextDirection.rtl, child:InputNumber()),
        "/MainPage" : (context) =>  new Directionality(textDirection: TextDirection.rtl, child:MainPage.none()),
        "/VerifyCode" : (context) =>  new Directionality(textDirection: TextDirection.rtl, child:VerifyCode('','')),
        "/Shop" : (context) =>  new Directionality(textDirection: TextDirection.rtl, child:new Directionality(textDirection: TextDirection.rtl, child: Shop())),
        "/Profile" : (context) =>  new Directionality(textDirection: TextDirection.rtl, child:new Directionality(textDirection: TextDirection.rtl, child: profile())),
        "/AboutUs" : (context) =>  new Directionality(textDirection: TextDirection.rtl, child:new Directionality(textDirection: TextDirection.rtl, child: Aboutus.none())),
        "/invite" : (context) =>  new Directionality(textDirection: TextDirection.rtl, child:new Directionality(textDirection: TextDirection.rtl, child: Invite.none())),
      },
    );
  }
}
