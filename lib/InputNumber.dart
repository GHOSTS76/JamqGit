import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import 'VerifyCode.dart';
class InputNumber extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InputNumberState();
  }

}
class InputNumberState extends State<InputNumber>{
  final numberController = TextEditingController();
  final invitecodecontroller = TextEditingController();
   var RedColor = Colors.red;
   var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var InputNumberColor = Color.fromRGBO(19, 2, 102, 1);
   @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor:  Color.fromRGBO(203, 203, 205, 1),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/inputnumberback.jpg'),
                  alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth
                )
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 240,left: 15,right: 15,bottom: 15),child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            margin: EdgeInsets.all(10),
            elevation: 5,
            child:Container(
             color: Colors.white,
              child: SingleChildScrollView(
                child:Column(
                  children: <Widget>[
                    Padding(padding:EdgeInsets.only(top: 30),child: Row(children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 15,right: 20),child: Text('شماره همراه ',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),),)
                    ],
                    ),),
                    Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),child:Container(
                      height: 55,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          border: Border.all(color: InputNumberColor,width: 2)
                      ),
                      child:Stack(
                        children: <Widget>[
                          Align(
                            child:Padding(padding: EdgeInsets.only(left: 5),child: Row(
                              mainAxisAlignment:MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left: 5),child: Text('+98',style: TextStyle(color: Colors.black45,fontFamily: 'MyFont',fontSize: 16),),),
                                Image.asset('assets/images/number.png',height: 45,width: 45,),
                              ],
                            )),
                            alignment: Alignment.centerLeft,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20),child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Flexible(
                                  fit: FlexFit.loose,
                                  child: new Padding(padding: EdgeInsets.fromLTRB(0, 5, 40, 5),child: new TextField(
                                    controller: numberController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.deepPurple,
                                    style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '9180000000',
                                    ),
                                  ))),
                            ],),)
                        ],
                      ),

                    ),),
                    Row(children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 15,right: 20),child: Text('کد معرف',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),),)
                    ],
                    ),
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

                                Image.asset('assets/images/identifiercode.png',height: 45,width: 45,),
                              ],
                            )),
                            alignment: Alignment.centerLeft,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20),child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Flexible(
                                  fit: FlexFit.loose,
                                  child: new Padding(padding: EdgeInsets.fromLTRB(40, 5, 40, 5),child: new TextField(
                                    controller: invitecodecontroller,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.deepPurple,
                                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                    decoration: new InputDecoration(
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                      hintText: '1234',
                                    ),
                                  ))),
                            ],),)
                        ],
                      ),

                    ),),
                    Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 50),child:
                    InkWell(
                      child:  Container(
                        height: 60,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(19, 3, 102, 1),
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child:new Text('شروع بازی',style:TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'MyFont'),),
                              onTap: (){

                              },
                            )

                          ],
                        ),
                      ),
                      onTap: (){
                        if(numberController.text == ''|| numberController.text == null || numberController.text.length != 10){
                          setState(() {
                            InputNumberColor = RedColor;
                            Fluttertoast.showToast(
                                msg: "لطفا ورودی های خود را بررسی کنید.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.yellow,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          });
                        }else{
                          InputNumberColor = themeColor;
                          _openLoadingDialog(context);
                          SendSms();
                        }

                      },
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top:40,right: 0),child: Text('عضویت و شرکت در مسابقات جام کیو کاملا رایگان است و \n ثبت نام به منزله پذیرفتن و قبول قوانین می باشد.',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MyFont',fontSize: 15,color: Colors.black),),)
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 40,bottom: 10),child:  Container(
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color.fromRGBO(4, 185, 204, 1),Color.fromRGBO(1, 38, 106, 1), ],
                          )
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text('مشاهده قوانین',style:TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'MyFont'),),
                        ],
                      ),
                    ),)
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
    );
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


  void SendSms() async {
    FormData formData = FormData.fromMap({
      "userNumber": numberController.text,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Sms/SendSms",data:formData);
      print(response);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: VerifyCode(response.data.toString(),numberController.text))),(Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }
}