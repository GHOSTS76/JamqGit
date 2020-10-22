import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/helpers/show_radio_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:jalali_date/jalali_date.dart';
import 'package:shimmer/shimmer.dart';
import 'MainPage.dart';
import 'UserInfoClass.dart';

class profile extends StatefulWidget{

  var UIC;
  profile(this.UIC);
  profile.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }
}

class ProfileState extends State<profile>{
  var picdecode;
  var img64;
  var imageimg64;
  var jsonimg64;
  bool ispic = false;
  bool InfoUpdated;
    var inputstate;
    var userData;
    var name = 'aa',family,banknumber,email,birthdate,gender;
    var picdef ;
    var profback = AssetImage('assets/images/profback.png');
    UserInfoClass UserInfo ;
    int fail  = 0,success = 0 ;
    var themeColor = Color.fromRGBO(19, 2, 102, 1);
    var purplecolor = Color.fromRGBO(80, 0, 131,1);
    var StateColor = Color.fromRGBO(1, 1, 1,1);
    Future loadfuture;
    PersianDatePickerWidget persianDatePicker;
  var selectedUsState;
  List<String> usStates = <String>[
    'خانم',
    'آقا',
  ];
    final NameInputController = TextEditingController();
    final FamilyInputController = TextEditingController();
    final BankNumberController = TextEditingController();
    final UserNameController = TextEditingController();
    final EmailController = TextEditingController();
    final BirthDayController = TextEditingController();
    final GenderController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
    loadfuture = GetUserInfo();
    persianDatePicker = PersianDatePicker(
      controller: BirthDayController,
      rangeDatePicker: false,
      // datetime: '1397/06/09',
      // finishDatetime: '1397/06/15',
    ).init();
  picdef =  AssetImage('assets/images/question.png');
  print('RRRRR');
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future:loadfuture ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData ?  new Scaffold(
            resizeToAvoidBottomInset: false,
            body: new LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
                  return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/aboutusland.jpg'),
                              fit: BoxFit.fill)
                      ),
                      child:Stack(
                        children: [
                          Align(
                            child: Padding(padding: EdgeInsets.only(top:20,right: 20),child:
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(left: 15),child:InkWell(
                                      child:Image.asset('assets/images/backico.png',height: 40,width: 40,),
                                      onTap: (){
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(userData))),(Route<dynamic> route) => false);
                                      },
                                    ) )
                                  ],
                                ),//دکمه بازگشت
                              ],
                            ),//هدر
                            ),
                            alignment: Alignment.topCenter,
                          ),
                          Align(
                              child:Padding(padding: EdgeInsets.only(top: 60),child:  Stack(
                                children: <Widget>[
                                  Card(
                                    color: Colors.transparent,
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    child:Container(child:   Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/profileland.png'), fit: BoxFit.fill)),)),
                                  ),

                                ],
                              ),)
                          ),
                          Padding(padding: EdgeInsets.only(top: 80),child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundImage: profback,
                                      radius: 70,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.deepPurple,
                                        radius: 60,
                                        backgroundImage:  picdef,
                                      ),
                                    ),
                                    onTap: (){
                                      if(inputstate){
                                        UploadImage();
                                      }else{
                                      }

                                    },
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(left: 80,right: 80),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/name.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            controller: NameInputController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: 'نام خود را وارد کنید',
                                            ),
                                          ))),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                      height: 1,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/name.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            controller: FamilyInputController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: 'نام خانوادگی خود را وارد کنید',
                                            ),
                                          ))),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                      height: 1,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/banknumberico.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            controller: BankNumberController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: 'شماره حساب خود را وارد کنید',
                                            ),
                                          ))),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                      height: 1,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/emailico.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            controller: EmailController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: ' ایمیل خود را وارد کنید',
                                            ),
                                          ))),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                      height: 1,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/phoneico.png',width: 35,height: 35,),
                                      Padding(padding: EdgeInsets.only(right: 10),child: Row(children: [
                                        Padding(padding: EdgeInsets.only(right: 5),child:    Text(
                                          'شماره همراه',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontFamily: 'MyFont'
                                          ),
                                        ),),

                                        Text(
                                          ':',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black87,
                                              fontFamily: 'MyFont'
                                          ),
                                        ),

                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text(
                                          userData[0][0]['PhoneNumber'].toString(),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black87,
                                              fontFamily: 'MyFont'
                                          ),
                                        ),),
                                      ],),)
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 10), child: Container(
                                      height: 1,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top:10), child: Row(  children: [
                                      Image.asset('assets/images/dateico.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            onTap: (){
                                              FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening default keyboard
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return persianDatePicker;
                                                  });
                                            },
                                            controller: BirthDayController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: ' تاریخ تولد خود را وارد کنید',
                                            ),
                                          ))),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                      height: 1,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top:10),child:InkWell(
                                      child:Container(
                                        child:  Row(  children: [
                                          Image.asset('assets/images/genderico.png',width: 35,height: 35,),
                                          new Flexible(
                                              fit: FlexFit.loose,
                                              child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                                controller: GenderController,
                                                textAlign: TextAlign.right,
                                                keyboardType: TextInputType.text,
                                                enabled: false,
                                                cursorColor: Colors.deepPurple,
                                                style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.black,
                                                  border: InputBorder.none,
                                                  hintText: 'جنسیت خود را وارد کنید',
                                                ),
                                              ))),
                                        ],
                                        ),
                                      ),
                                      onTap: (){
                                        if(inputstate){
                                          showMaterialRadioPicker(
                                            context: context,
                                            cancelText: 'کنسل',
                                            headerTextColor: Colors.white,
                                            confirmText: 'تایید',
                                            title: "جنسیت",
                                            headerColor: Colors.purple,
                                            items: usStates,
                                            selectedItem: selectedUsState,
                                            onChanged: (value) => setState(() =>   GenderController.text = value),
                                          );
                                        }else{

                                        }

                                      },
                                    )
                                    ),
                                  ],
                                ),)
                            ],
                          )),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:     Padding(padding: EdgeInsets.only(bottom: 60),child:  Container(
                              height: 60,
                              width: 350,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [purplecolor,themeColor, ],
                                  )
                              ),
                              child:InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text('ذخیره',style:TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'MyFont'),),
                                  ],
                                ),
                                onTap: (){
                                  if(inputstate){
                                    checkInputs();
                                  }else{
                                    Fluttertoast.showToast(
                                        msg: "اطلاعات شما بروز است.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.yellow,
                                        textColor: Colors.black,
                                        fontSize: 16.0
                                    );
                                  }
                                },
                              )
                            ),),
                          )
                        ],
                      )
                  );
                } else {
                  return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/aboutusport.jpg'),
                              fit: BoxFit.fill)
                      ),
                      child:Stack(
                        children: [
                          Align(
                            child: Padding(padding: EdgeInsets.only(top:20,right: 20),child:
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(left: 15),child:InkWell(
                                      child:Image.asset('assets/images/backico.png',height: 40,width: 40,),
                                      onTap: (){
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(userData))),(Route<dynamic> route) => false);
                                      },
                                    ) )
                                  ],
                                ),//دکمه بازگشت
                              ],
                            ),//هدر
                            ),
                            alignment: Alignment.topCenter,
                          ),
                          Align(
                              child:Padding(padding: EdgeInsets.only(top: 60),child:  Stack(
                                children: <Widget>[
                                  Card(
                                    color: Colors.transparent,
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    child:Container(child:   Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/profileport.png'), fit: BoxFit.fill)),)),
                                  ),

                                ],
                              ),)
                          ),
                          Padding(padding: EdgeInsets.only(top: 20),child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundImage: profback,
                                      radius: 70,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.deepPurple,
                                        radius: 60,
                                        backgroundImage:  picdef,
                                      ),
                                    ),
                                    onTap: (){
                                      if(inputstate){
                                        UploadImage();
                                      }else{

                                      }

                                    },
                                  )
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/name.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            controller: NameInputController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: 'نام خود را وارد کنید',
                                            ),
                                          ))),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                    height: 1,
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.black45,
                                    ),
                                  ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/name.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            controller: FamilyInputController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: 'نام خانوادگی خود را وارد کنید',
                                            ),
                                          ))),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                    height: 1,
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.black45,
                                    ),
                                  ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/banknumberico.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            controller: BankNumberController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: ' شماره حساب خود را وارد کنید',
                                            ),
                                          ))),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                      height: 1,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/name.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            controller: UserNameController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: 'نام کاربری خود را وارد نمایید.',
                                            ),
                                          ))),
                                  ],
                                  ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                    height: 1,
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.black45,
                                    ),
                                  ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                      Image.asset('assets/images/emailico.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            controller: EmailController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: ' ایمیل خود را وارد کنید',
                                            ),
                                          ))),
                                  ],
                                  ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                    height: 1,
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.black45,
                                    ),
                                  ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: Row(  children: [
                                    Image.asset('assets/images/phoneico.png',width: 35,height: 35,),
                                      Padding(padding: EdgeInsets.only(right: 10),child: Row(children: [
                                        Padding(padding: EdgeInsets.only(right: 5),child:    Text(
                                          'شماره همراه',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontFamily: 'MyFont'
                                          ),
                                        ),),

                                        Text(
                                          ':',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontFamily: 'MyFont'
                                          ),
                                        ),

                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text(
                                          userData[0][0]['PhoneNumber'].toString(),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontFamily: 'MyFont'
                                          ),
                                        ),),
                                      ],),)
                                  ],
                                  ),),
                                    Padding(padding: EdgeInsets.only(top: 10), child: Container(
                                        height: 1,
                                        child: Divider(
                                          thickness: 2,
                                          color: Colors.black45,
                                        ),
                                      ),),
                                    Padding(padding: EdgeInsets.only(top:10), child: Row(  children: [
                                      Image.asset('assets/images/dateico.png',width: 35,height: 35,),
                                      new Flexible(
                                          fit: FlexFit.loose,
                                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                            onTap: (){
                                              FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening default keyboard
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return persianDatePicker;
                                                  });
                                            },
                                            controller: BirthDayController,
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.text,
                                            enabled: inputstate,
                                            cursorColor: Colors.deepPurple,
                                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: InputBorder.none,
                                              hintText: ' تاریخ تولد خود را وارد کنید',
                                            ),
                                          ))),

                                  ],
                                  ),),
                                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                    height: 1,
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.black45,
                                    ),
                                  ),),
                                    Padding(padding: EdgeInsets.only(top:10),child: InkWell(
                                      child:Container(
                                        child:  Row(  children: [
                                          Image.asset('assets/images/genderico.png',width: 35,height: 35,),
                                          new Flexible(
                                              fit: FlexFit.loose,
                                              child: new Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: new TextField(
                                                controller: GenderController,
                                                textAlign: TextAlign.right,
                                                keyboardType: TextInputType.text,
                                                enabled: false,
                                                cursorColor: Colors.deepPurple,
                                                style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.black,
                                                  border: InputBorder.none,
                                                  hintText: 'جنسیت خود را وارد کنید',
                                                ),
                                              ))),
                                        ],
                                        ),
                                      ),
                                      onTap: (){

                                        if(inputstate){
                                          showMaterialRadioPicker(
                                            context: context,
                                            cancelText: 'کنسل',
                                            headerTextColor: Colors.white,
                                            confirmText: 'تایید',
                                            title: "جنسیت",
                                            headerColor: Colors.purple,
                                            items: usStates,
                                            selectedItem: selectedUsState,
                                            onChanged: (value) => setState(() =>   GenderController.text = value),
                                          );
                                        }else{

                                        }



                                      },
                                    )
                                  ),
                                ],
                              ),)
                            ],
                          )),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:     Padding(padding: EdgeInsets.only(bottom: 60),child:  Container(
                              height: 60,
                              width: 350,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [purplecolor,themeColor, ],
                                  )
                              ),
                              child:InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text('ذخیره',style:TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'MyFont'),),
                                  ],
                                ),
                                onTap: (){
                                  print('Clickedddd');
                                  if(inputstate){
                                    checkInputs();
                                  }else{
                                    Fluttertoast.showToast(
                                        msg: "اطلاعات شما بروز است.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.yellow,
                                        textColor: Colors.black,
                                        fontSize: 16.0
                                    );
                                  }

                                },
                              )
                            ),),
                          ),

                        ],
                      )
                  );
                }
              }
          )

        ) : new Center(child: CircularProgressIndicator(),);
      },

    );

  }

    selectPic() async{

    }

    SetGender(State) {
      if (State) {
        return 'آقا';
      } else {
        return 'خانم';
      }
    }

    Convertdate(String Date){
      var DateArray =  Date.split('/');
      var DateForConvert = DateArray[0]+''+DateArray[1]+''+DateArray[2];

      return  PersianDate.fromGregorianString(DateForConvert.toString());
    }

    GetUserInfo() async {
  print(UserInfo.GetPhoneNumber());
      FormData formData = FormData.fromMap({
        "usernumber":UserInfo.GetPhoneNumber(),
      });
      try {
        Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetUserInfoByPhone",data:formData);
        if(response.data == '' || response.data == null){
          //log out user
       }else{
          userData = response.data;
          if(response.data[0][0]['UserName']== 'کاربر مهمان'){
            name = 'تعیین نشده است';
             family = 'تعیین نشده است.';
             banknumber = 'تعیین نشده است.';
             email = 'تعیین نشده است.';
             birthdate = 'تعیین نشده است.';
             gender = 'تعیین نشده است.';
            inputstate = true;
          }else{
            inputstate = false;
             name   = response.data[0][0]['Name'].toString();
             NameInputController.text = 'نام : '+name;
            family = response.data[0][0]['Family'].toString();
            FamilyInputController.text= 'نام خانوادگی : '+family;
            banknumber = response.data[0][0]['BankNumber'].toString();
            BankNumberController.text = ' شماره حساب :'+banknumber;

            UserNameController.text = ' نام کاربری  :'+response.data[0][0]['UserName'].toString();
            picdef = NetworkImage( response.data[0][0]['ProfilePicture'].toString());
            email = response.data[0][0]['Email'].toString();
            EmailController.text = ' ایمیل : '+email ;
            birthdate = response.data[0][0]['BirthDate'].toString();
            BirthDayController.text = ' تاریخ تولد : '+Convertdate(birthdate).toString();
            print('hereitcomes');
            gender = response.data[0][0]['Gender'];
            if(gender){
              GenderController.text =  ' جنسیت : آقا';

            }else{
              GenderController.text =  ' جنسیت : خانم';
            }

            setState(() {

            });
          }
          return userData;
        }

      } catch (e) {
        print(e);
      }
    }


    checkInputs(){
  if(UserNameController.text == '' || UserNameController.text == null || NameInputController.text == '' || NameInputController.text == null || FamilyInputController.text == '' || FamilyInputController.text == null  || EmailController.text == '' || EmailController.text == null || ispic == false){
    Fluttertoast.showToast(
        msg: "لطفا ورودی های خود را بررسی کنید.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }else{
   // _openLoadingDialog(context);
    UpdateInformation();
  }
    }


    UploadImage() async {
      Uint8List imagee  = await ImagePickerWeb.getImage(outputType: ImageType.bytes);
      img64 = base64Encode(imagee);
      jsonimg64 = jsonEncode(img64);
      picdecode = base64Decode(img64);
      setState(() {
        ispic = true;
        picdef = MemoryImage(imagee);
      });
    }

    UpdateInformation() async {
  var Gen;
  if(BirthDayController.text == 'آقا'){
    Gen = true;
  }else{
    Gen = false;
  }
      FormData formData = FormData.fromMap({
        "usernumber":UserInfo.GetPhoneNumber(),
        "UserName":UserNameController.text,
        "Name":NameInputController.text,
        "BankNumber":BankNumberController.text,
        "Family":FamilyInputController.text,
        "ProfilePic":jsonimg64,
        "Email":EmailController.text,
        "Gender":GenderController.text,
        "BirthDate":Gen,
      });
      try {
        Response response = await Dio().post("http://jamq.ir:3000/Mainuser/UpdateProfile",data:formData);
        print(response.data);
        if(response.data == '' || response.data == null){
          //log out user
        }else {
            GetUserInfo();
        }
      } catch (e) {
        print(e);
      }
    }


}


