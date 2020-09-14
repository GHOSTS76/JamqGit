import 'package:dio/dio.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppUtility.dart';
import 'InputNumber.dart';
import 'MainPage.dart';
import 'UserInfoClass.dart';
class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }

}
class SplashScreenState extends State<SplashScreen>{
var dio;
AppUtility Utility = new AppUtility();
UserInfoClass UserInfo ;
SharedPreferences LoginState;
SharedPreferences prefs ;

var alertStyle;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    dio = Dio()..interceptors.add(RetryInterceptor(
        options: const RetryOptions(
          retries: 0, // Number of retries before a failure
          retryInterval: const Duration(seconds: 10), // Interval between each retry
        )
    ));
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
     alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.deepPurple,
      ),
    );
    checkInternet();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Align(
        alignment: Alignment.topCenter,
        child: new Container(
          child: Center(
            child:
           Padding(padding: EdgeInsets.all(30),child:  Container(
             decoration: BoxDecoration(
                 image: DecorationImage(image: AssetImage('assets/images/applogo.png'))
             ),
           ),)
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splashback.png'),
                  fit: BoxFit.fill)
          ),
        ),
      )
    );
}

  checkInternet() async {
   var ConnectionState =true;// await Utility.CheckInternet();
   if(ConnectionState){
  var AppAvilabilityResponse =   await Utility.CheckApplicationAvilability();
  print('BLOWME');
  print(AppAvilabilityResponse.toString());
 var AVIsAvilable = AppAvilabilityResponse['AVIsAvilable'];
 if(AVIsAvilable){
   checkLogin(context);
 }else
   {
     Alert(
       context: context,
       style: alertStyle,
       type: AlertType.error,
       title: "برنامه از دسترس خارج میباشد",
       desc:  AppAvilabilityResponse['AVMessage'],
       buttons: [
         DialogButton(
           child: Text(
             "خروج",
             style: TextStyle(color: Colors.white, fontSize: 20),
           ),
           onPressed: () =>  SystemNavigator.pop(),
           color: Colors.red,
           radius: BorderRadius.circular(5.0),
         ),
       ],
     ).show();
   }
   }else{
     Alert(
       context: context,
       style: alertStyle,
       type: AlertType.error,
       title: "اینترنت شما متصل نیست",
       desc: "لطفا دوباره امتحان کنید",
       buttons: [
         DialogButton(
           child: Text(
           "خروج",
           style: TextStyle(color: Colors.white, fontSize: 20),
         ),
         onPressed: () => SystemNavigator.pop(),
         width: 120,
         color:Colors.red,
       ),
         DialogButton(
           child: Text(
             "امتحان دوباره",
             style: TextStyle(color: Colors.white, fontSize: 20),
           ),
           onPressed: () => checkInternet(),
           width: 120,
           color:Colors.green,
         ),
       ],
     ).show();
   }
  }
  checkLogin(context) async {
     LoginState = await SharedPreferences.getInstance();
     var  login = LoginState.getString('IsLoggedIn') ?? 'def';
     if(login.length ==10){
       GetUserInfo(LoginState.getString('IsLoggedIn'));
     }else{
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  InputNumber())),(Route<dynamic> route) => false);
     }
  }
  GetUserInfo(Number) async {
    print('lAAAAAAAogin');
    FormData formData = FormData.fromMap({
      "usernumber":Number,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetUserInfoByPhone",data:formData);
      print(response.data);
      if(response.data.toString() ==''){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  InputNumber())),(Route<dynamic> route) => false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  MainPage(response.data))),(Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

}


