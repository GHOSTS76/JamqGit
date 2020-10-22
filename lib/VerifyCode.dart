import 'dart:math';
import 'package:dio/dio.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'InputNumber.dart';
import 'MainPage.dart';
import 'UserInfoClass.dart';

class VerifyCode extends StatefulWidget{

  var Code,Number;

  VerifyCode(this.Code,this.Number);


  VerifyCode.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return verify_numberState();
  }


}


class verify_numberState extends State<VerifyCode> with TickerProviderStateMixin
{
  final myController = TextEditingController();
  var InputTextField,timerText;
  static TextEditingController numberController;
  static String ConfirmCode;
  static String UserNumber;
  static const int kStartValue = 60;
  AnimationController _controller;
  UserInfoClass UserInfo ;
  @override
  Widget build(BuildContext context) {
    var _code;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:  Color.fromRGBO(203, 203, 205, 1),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/inputnumberback.jpg'),
                      fit: BoxFit.fill
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 230,left: 15,right: 15,bottom: 15),child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              margin: EdgeInsets.all(10),
              elevation: 5,
              child:Container(
                color: Colors.white,
                child:  SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(padding:EdgeInsets.only(top:100),child: Row(children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 15,right: 20),child: Text('کد',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),),)
                      ],
                      ),),
                      Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),child:Container(
                        height: 55,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            border: Border.all(color: Color.fromRGBO(19, 2, 102, 1),width: 2)
                        ),
                        child:Stack(
                          children: <Widget>[
                            Align(
                              child:Padding(padding: EdgeInsets.only(left: 5),child: Row(
                                mainAxisAlignment:MainAxisAlignment.end,
                                children: <Widget>[
                                  Image.asset('assets/images/lock.png',height: 45,width: 45,),
                                ],
                              )),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child:Padding(padding: EdgeInsets.only(left: 5),child: new Directionality(textDirection: TextDirection.ltr, child: VerificationCode(
                                textStyle: TextStyle(fontSize: 20.0, color: Colors.deepPurple,),
                                underlineColor: Colors.green,
                                keyboardType: TextInputType.number,
                                length: 4,
                                // clearAll is NOT required, you can delete it
                                // takes any widget, so you can implement your design
                                onCompleted: (String value) {
                                  setState(() {
                                    _code = value;
                                    if(widget.Code.toString() == _code){
                                      GetUserInfo(widget.Number);
                                    }else {

                                      Fluttertoast.showToast(
                                          msg: "کد وارد شده اشتباه میباشد.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  });
                                },
                                onEditing: (bool value) {

                                },
                              ),)),
                              alignment: Alignment.center,
                            ),
                          ],
                        ),

                      ),

                      ),
                      Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 50),child:

                      InkWell(
                        child: Container(
                          height: 60,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(19, 3, 102, 1),
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text('ورود',style:TextStyle(fontSize: 26,color: Colors.white,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        onTap: (){
                          if(widget.Code.toString() == _code){
                            GetUserInfo(widget.Number);
                          }else {
                            Fluttertoast.showToast(
                                msg: "کد وارد شده اشتباه میباشد.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        },
                      )
                      ),
                      Padding(padding: EdgeInsets.only(top: 30,bottom: 20),child: Stack(
                        children: <Widget>[

                          Center(child: Container(
                            height: 60,
                            width: 160,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Color.fromRGBO(4, 185, 204, 1),Color.fromRGBO(1, 38, 106, 1), ],
                                )
                            ),
                          ),),
                          Center(child:    Padding(padding: EdgeInsets.only(top: 5),child:  Container(
                            height: 50,
                            width: 170,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                          ),),),
                          Padding(padding: EdgeInsets.only(top: 10),child:  Center(
                            child: new Countdown(
                              animation: new StepTween(
                                begin: kStartValue,
                                end: 0,
                              ).animate(_controller),
                            ),
                          ),)
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            )),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(padding: EdgeInsets.only(top: 1),
                child: Image.asset('assets/images/applogo.png',height: 250,width: 250,),),
            ),
          ],
        )
    ), onWillPop: () => Future(() => false));

  }

  @override
  void initState() {
    numberController = new TextEditingController();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: kStartValue),
    );
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {

    super.dispose();
  }


  RegisterUser(Number) async {
    FormData formData = FormData.fromMap({
      "PhoneNumber":Number,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Register/RegisterUser",data:formData);
      if (response.data.toString() == 'UserRegistred'){
        UserInfo = new UserInfoClass(response.data);
        GetUserInfo(Number);
      }


    } catch (e) {
      print(e);
    }
  }

  GetUserInfo(Number) async {
    print('AAAAAAAAAA'+ Number);
    _openLoadingDialog(context);
    FormData formData = FormData.fromMap({
      "usernumber":Number,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetUserInfoByPhone",data:formData);
      print(response.data.toString());
      if(response.data.toString() == 'user does not exist'){
        RegisterUser(Number);
      }else{
        UserInfo = new UserInfoClass(response.data);
        print('ALLLLOOO');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('IsLoggedIn', Number);
        _controller?.dispose();

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  MainPage(response.data))),(Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e);
    }
  }
}
void _openLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(padding: EdgeInsets.only(top: 20,left: 10),child:  Text('...لطفا صبر کنید',style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: 'IRANSans'),),)
              ],
            )
        ),
      );
    },
  );
}

class Countdown extends AnimatedWidget {
  Countdown({ Key key, this.animation }) : super(key: key, listenable: animation);
  Animation<int> animation;
  @override
  build(BuildContext context){
    final Image retryLogo=new Image(image: AssetImage('assets/images/retry.png'),fit: BoxFit.contain,width: 40,height: 40);
    if(animation.value == 0){
      return new InkWell(
        child:retryLogo,
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  InputNumber())),(Route<dynamic> route) => false);
        },
      );

    }else{
      return new Padding(padding: EdgeInsets.only(top: 10),child: Text(
        animation.value.toString(),
        style: new TextStyle(fontSize: 22.0,color:Color.fromRGBO(1, 38, 106, 1)),
      ),);
    }

  }

}
