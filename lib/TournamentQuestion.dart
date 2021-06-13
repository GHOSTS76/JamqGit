import 'dart:async';
import 'dart:convert';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:confetti/confetti.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamqpwa/Shop.dart';
import 'package:jamqpwa/TournamentMain.dart';
import 'package:jamqpwa/TournamentSetterClass.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'UserInfoClass.dart';

class TournamentQuestion extends StatefulWidget{
  var UIC,TrData;
  TournamentQuestion(this.UIC,this.TrData);
  TournamentQuestion.none();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TournamentQuestionState();
  }
}

class TournamentQuestionState extends State<TournamentQuestion>{
  var   selectedColor = Color.fromRGBO(80, 0, 131, 1);
  var pink = Color.fromRGBO(249, 211, 248, 1);
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  var   UnselectedColor = Colors.white;
  var Green = Color.fromRGBO(3, 170, 2,1);
  TournamentSetter TournamentData;
  UserInfoClass UserInfo ;
  Future loadfuture;
  CountDownController _controller;
  ConfettiController _controllerCenter;
  var qstime = 0 ;
  var OtherHelp = '0';
  var PresentHelpa = '0';
  var BoxColor1,BoxColor2,BoxColor3,BoxColor4;
  var QuestionsAsked=0;
  var SingleElimanation;
  int QuestionTime;
  var _ParsedData;
  var Questions = [];
  var InprogressQs;
  var LastQs=false;
  var trueAnswerCounnter=0,QuestionScore=0;
  var Qs1Count='0',Qs2Count='0',Qs3Count='0',Qs4Count='0';
  var _visible = false;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();


     _ParsedData =  jsonDecode(widget.TrData);

    UserInfo = new UserInfoClass(widget.UIC);
    _controller = CountDownController();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 3));

    SingleElimanation = _ParsedData['TrSingleelimination'];
    QuestionScore = _ParsedData['TrScorePerQs'];
    Questions =_ParsedData['Questions'];
    PresentHelp(Questions[0]);
    loadfuture =  GetQuestionData(Questions[0]);

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double P_height = MediaQuery.of(context).size.height*0.9;
    double P_width = MediaQuery.of(context).size.width*0.9;

    if(OtherHelp == '1'){
      print('thisRans');
      BoxColor1 = Colors.grey;
      BoxColor2 =Colors.black12;
      qstime = 20;
      _controller.restart(duration:qstime);
      OtherHelp = '2';
    }else if(OtherHelp == '0'){
      BoxColor1 = themeColor;
      BoxColor2 = purplecolor;
      qstime =_ParsedData['TrAnsweringTime'];
      QuestionTime = _ParsedData['TrAnsweringTime'];
    }

    if(PresentHelpa == '1'){
      BoxColor3 = Colors.grey;
      BoxColor4 =Colors.black12;
      _visible = true;
    }else if(PresentHelpa == '0'){
      BoxColor3 = themeColor;
      BoxColor4= purplecolor;
      _visible = false;
    }

    return  FutureBuilder(
        future:loadfuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ?
          new Scaffold(body: new   Scaffold(
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
                    return  Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/shopback.jpg'),
                              fit: BoxFit.fill)
                      ),
                      child:Column(
                        children: [
                          Padding(
                            child:
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              margin: EdgeInsets.all(10),
                              elevation: 10,
                              color: Colors.white,
                              child: Container(
                                width:  P_width,
                                height: P_height,
                                child: Column(
                                  children: [
                                    Padding(
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('سوال شماره ' + QuestionsAsked.toString(),style: TextStyle(color: themeColor,fontFamily: 'Lale',fontSize: 22,fontWeight: FontWeight.bold),),
                                        ],),padding: EdgeInsets.only(top: 20),),
                                    Container(
                                      height: 1,
                                      width: 100,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.purple,
                                      ),
                                    ),
                                    Padding(child: CircularCountDownTimer(
                                      duration: QuestionTime,
                                      controller: _controller,
                                      width: 80,
                                      height: 80,
                                      color: Colors.white,
                                      fillColor: purplecolor,
                                      backgroundColor: null,
                                      strokeWidth: 10.0,
                                      textStyle: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
                                      isReverse: true,
                                      isReverseAnimation: false,
                                      isTimerTextShown: true,
                                      onComplete: () {
                                        Alert(
                                          context: context,
                                          closeFunction: (){

                                          },
                                          type: AlertType.error,
                                          title: "باختی",
                                          desc:  "زمانت تموم شد! میخوای ادامه بدی",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "آره",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              onPressed:(){
                                                print('Continue');
                                                ContinuePlaying();
                                              },
                                              color: selectedColor,
                                              radius: BorderRadius.circular(5.0),
                                            ),
                                            DialogButton(
                                              child: Text(
                                                "نه",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              onPressed:(){
                                                RefreshData(UserInfo.GetPhoneNumber());
                                              },
                                              color: selectedColor,
                                              radius: BorderRadius.circular(5.0),
                                            ),
                                          ],
                                        ).show();
                                      },
                                    ),padding: EdgeInsets.only(top: 30),),
                                    Padding(child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data['QSText'].toString(),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                      ],),
                                      padding: EdgeInsets.only(top: 20),),
                                    Padding(child: ConfettiWidget(
                                        confettiController: _controllerCenter,
                                        blastDirectionality: BlastDirectionality.explosive,
                                        maxBlastForce: 25,// on't specify a direction, blast randomly
                                        numberOfParticles: 50,
                                        shouldLoop: false, // start again as soon as the animation is finished
                                        colors: const [
                                          Colors.green,
                                          Colors.blue,
                                          Colors.pink,
                                          Colors.cyan,
                                          Colors.purple,
                                          Colors.deepPurple,
                                          Colors.yellowAccent
                                        ], // manual
                                        child:Stack(
                                          children: [
                                            CustomRadioButton(
                                              customShape: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: themeColor, width: 2),
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                              ),
                                              elevation: 5  ,
                                              height: 50,
                                              selectedBorderColor:selectedColor,
                                              unSelectedColor: UnselectedColor,
                                              unSelectedBorderColor: UnselectedColor,
                                              enableShape: true,
                                              enableButtonWrap: true,
                                              buttonLables: [
                                                snapshot.data['QSChoice1'].toString(),
                                                snapshot.data['QSChoice2'].toString(),
                                                snapshot.data['QSChoice3'].toString(),
                                                snapshot.data['QSChoice4'].toString(),
                                              ],
                                              buttonValues: [
                                                snapshot.data['QSChoice1'].toString(),
                                                snapshot.data['QSChoice2'].toString(),
                                                snapshot.data['QSChoice3'].toString(),
                                                snapshot.data['QSChoice4'].toString(),
                                              ],
                                              radioButtonValue: (values) {
                                                _openLoadingDialog(context);
                                                AnalayzeQuestion(InprogressQs,values,UserInfo.GetPhoneNumber(), _ParsedData['TournamentId']);

                                              },
                                              horizontal: true,
                                              width: 100,
                                              selectedColor: selectedColor,
                                              padding: 10,
                                              spacing: 0.0,
                                              // enableShape: true,
                                            ),
                                            Align(
                                              child: Padding(
                                                child:  Visibility(
                                                  child: Column(

                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      Padding(
                                                        child:        Text(Qs1Count,style: TextStyle(fontSize: 24,color: Colors.purple),),
                                                        padding: EdgeInsets.only(top: 25),
                                                      ),
                                                      Padding(
                                                        child:        Text(Qs2Count,style: TextStyle(fontSize: 24,color: Colors.purple),),
                                                        padding: EdgeInsets.only(top: 45),
                                                      ),
                                                      Padding(
                                                        child:        Text(Qs3Count,style: TextStyle(fontSize: 24,color: Colors.purple),),
                                                        padding: EdgeInsets.only(top: 45),
                                                      ),
                                                      Padding(
                                                        child:        Text(Qs4Count,style: TextStyle(fontSize: 24,color: Colors.purple),),
                                                        padding: EdgeInsets.only(top: 45),
                                                      ),
                                                    ],
                                                  ),
                                                  visible: _visible,
                                                ),
                                                padding: EdgeInsets.only(left: 20),
                                              ),
                                              alignment: Alignment.centerLeft,
                                            )
                                          ],
                                        )
                                    ),padding: EdgeInsets.only(top: 40),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(children: [
                                          InkWell(
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 5,
                                              child:
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:Color.fromRGBO(255, 255, 255, 1),
                                                    ),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [BoxColor3,BoxColor4 ],
                                                    )
                                                ),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset('assets/images/trotherhelpico.png',width: 80,height: 80,),

                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),

                                            ),
                                            onTap: (){
                                              if(PresentHelpa=='0'){
                                                print('Clicked');
                                                setState(() {
                                                  PresentHelpa = '1';
                                                });
                                              }else{

                                              }
                                            },
                                          ),
                                          Text('کمک حضار',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 22,fontWeight: FontWeight.bold),),
                                        ],
                                        ),
                                        Image.asset('assets/images/trqspic.png',width: 200,height: 200,),
                                        Column(children: [
                                          InkWell(
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 5,
                                              child:
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:Color.fromRGBO(255, 255, 255, 1),
                                                    ),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [BoxColor1,BoxColor2 ],
                                                    )
                                                ),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset('assets/images/trtimerico.png',width: 80,height: 80,),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),

                                            ),
                                            onTap: (){
                                              print('Clicked');
                                              print(OtherHelp);
                                              if(OtherHelp=='0'){
                                                print('Clicked');
                                                setState(() {
                                                  OtherHelp = '1';
                                                });
                                              }else{

                                              }
                                            },
                                          ),
                                          Text('زمان اضافه',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 22,fontWeight: FontWeight.bold),),
                                        ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            padding: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 5),)
                        ],
                      ),
                    );
                  } else {
                    return  Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/shopback.jpg'),
                              fit: BoxFit.fill)
                      ),
                      child:Column(
                        children: [
                          Padding(
                            child:
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              margin: EdgeInsets.all(10),
                              elevation: 10,
                              color: Colors.white,
                              child: Container(
                                width:  P_width,
                                height: P_height,
                                child: Column(
                                  children: [
                                    Padding(
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('سوال شماره ' + QuestionsAsked.toString(),style: TextStyle(color: themeColor,fontFamily: 'Lale',fontSize: 18,fontWeight: FontWeight.bold),),
                                        ],),padding: EdgeInsets.only(top: 20),),
                                    Container(
                                      height: 1,
                                      width: 100,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.purple,
                                      ),
                                    ),
                                    Padding(child: CircularCountDownTimer(
                                      duration: QuestionTime,
                                      controller: _controller,
                                      width: 80,
                                      height: 80,
                                      color: Colors.white,
                                      fillColor: purplecolor,
                                      backgroundColor: null,
                                      strokeWidth: 10.0,
                                      textStyle: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
                                      isReverse: true,
                                      isReverseAnimation: false,
                                      isTimerTextShown: true,
                                      onComplete: () {
                                        Alert(
                                          context: context,
                                          closeFunction: (){

                                          },
                                          type: AlertType.error,
                                          title: "باختی",
                                          desc:  "زمانت تموم شد! میخوای ادامه بدی",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "آره",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              onPressed:(){
                                                print('Continue');
                                                ContinuePlaying();
                                              },
                                              color: selectedColor,
                                              radius: BorderRadius.circular(5.0),
                                            ),
                                            DialogButton(
                                              child: Text(
                                                "نه",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              onPressed:(){
                                                RefreshData(UserInfo.GetPhoneNumber());
                                              },
                                              color: selectedColor,
                                              radius: BorderRadius.circular(5.0),
                                            ),
                                          ],
                                        ).show();
                                      },
                                    ),padding: EdgeInsets.only(top: 20),),
                                    Padding(child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data['QSText'].toString(),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                      ],),
                                      padding: EdgeInsets.only(top: 15),),
                                    Padding(child: ConfettiWidget(
                                        confettiController: _controllerCenter,
                                        blastDirectionality: BlastDirectionality.explosive,
                                        maxBlastForce: 25,// on't specify a direction, blast randomly
                                        numberOfParticles: 50,
                                        shouldLoop: false, // start again as soon as the animation is finished
                                        colors: const [
                                          Colors.green,
                                          Colors.blue,
                                          Colors.pink,
                                          Colors.cyan,
                                          Colors.purple,
                                          Colors.deepPurple,
                                          Colors.yellowAccent
                                        ], // manual
                                        child:Stack(
                                          children: [
                                            CustomRadioButton(
                                              customShape: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: themeColor, width: 2),
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                              ),
                                              elevation: 5  ,
                                              height: 40,
                                              selectedBorderColor:selectedColor,
                                              unSelectedColor: UnselectedColor,
                                              unSelectedBorderColor: UnselectedColor,
                                              enableShape: true,
                                              enableButtonWrap: true,
                                              buttonLables: [
                                                snapshot.data['QSChoice1'].toString(),
                                                snapshot.data['QSChoice2'].toString(),
                                                snapshot.data['QSChoice3'].toString(),
                                                snapshot.data['QSChoice4'].toString(),
                                              ],
                                              buttonValues: [
                                                snapshot.data['QSChoice1'].toString(),
                                                snapshot.data['QSChoice2'].toString(),
                                                snapshot.data['QSChoice3'].toString(),
                                                snapshot.data['QSChoice4'].toString(),
                                              ],
                                              radioButtonValue: (values) {
                                                _openLoadingDialog(context);
                                                AnalayzeQuestion(InprogressQs,values,UserInfo.GetPhoneNumber(), _ParsedData['TournamentId']);

                                              },
                                              horizontal: true,
                                              width: 900,
                                              selectedColor: selectedColor,
                                              padding: 5,
                                              spacing: 0.0,
                                              // enableShape: true,
                                            ),
                                            Align(
                                              child: Padding(
                                                child:  Visibility(
                                                  child: Column(

                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      Padding(
                                                        child:        Text(Qs1Count,style: TextStyle(fontSize: 24,color: Colors.purple),),
                                                        padding: EdgeInsets.only(top: 15),
                                                      ),
                                                      Padding(
                                                        child:        Text(Qs2Count,style: TextStyle(fontSize: 24,color: Colors.purple),),
                                                        padding: EdgeInsets.only(top: 20),
                                                      ),
                                                      Padding(
                                                        child:        Text(Qs3Count,style: TextStyle(fontSize: 24,color: Colors.purple),),
                                                        padding: EdgeInsets.only(top: 25),
                                                      ),
                                                      Padding(
                                                        child:        Text(Qs4Count,style: TextStyle(fontSize: 24,color: Colors.purple),),
                                                        padding: EdgeInsets.only(top: 25),
                                                      ),
                                                    ],
                                                  ),
                                                  visible: _visible,
                                                ),
                                                padding: EdgeInsets.only(left: 20),
                                              ),
                                              alignment: Alignment.centerLeft,
                                            )
                                          ],
                                        )
                                    ),padding: EdgeInsets.only(top: 10),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(children: [
                                          InkWell(
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 5,
                                              child:
                                              Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:Color.fromRGBO(255, 255, 255, 1),
                                                    ),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [BoxColor3,BoxColor4 ],
                                                    )
                                                ),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset('assets/images/trotherhelpico.png',width: 50,height: 50,),

                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),

                                            ),
                                            onTap: (){
                                              if(PresentHelpa=='0'){
                                                print('Clicked');
                                                setState(() {
                                                  PresentHelpa = '1';
                                                });
                                              }else{

                                              }
                                            },
                                          ),
                                          Text('کمک حضار',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                        ],
                                        ),
                                        Image.asset('assets/images/trqspic.png',width: 80  ,height: 80,),
                                        Column(children: [
                                          InkWell(
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 5,
                                              child:
                                              Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:Color.fromRGBO(255, 255, 255, 1),
                                                    ),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [BoxColor1,BoxColor2 ],
                                                    )
                                                ),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset('assets/images/trtimerico.png',width: 50,height: 50,),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),

                                            ),
                                            onTap: (){
                                              print('Clicked');
                                              print(OtherHelp);
                                              if(OtherHelp=='0'){
                                                print('Clicked');
                                                setState(() {
                                                  OtherHelp = '1';
                                                });
                                              }else{

                                              }
                                            },
                                          ),
                                          Text('زمان اضافه',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                        ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            padding: EdgeInsets.only(top: 5,left: 10,right: 10),)
                        ],
                      ),
                    );
                  }
                }
            ),
          )	) : new Center(child: CircularProgressIndicator(),);

        });
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

  AnalayzeQuestion(QsId,UserChoice,PlayerId,TrID) async {
    print('شششششششش');
    print(UserChoice);
    _controller.pause();
    try {
      FormData formData = FormData.fromMap({
        "QsId":QsId,
        "UserChoice":UserChoice,
        "PlayerId":PlayerId,
        "TrID":TrID,
      });
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/QuestionAnalyzer",data: formData);

      print(response.data);
      Navigator.pop(context);
      var QsRes= jsonDecode(response.data);
      if(QsRes['AnswerState'] == true){
        setState(() {
          TrueAnwser();

        });
      }else if(QsRes['AnswerState'] == false){
        print(SingleElimanation.toString());
        if(SingleElimanation){
          WrongAnswer(QsRes['TrueAnswer']);
        }else{
          NexTQuestion();
        }

      }
    } catch (e) {
      print(e);
    }
  }

  GetQuestionData(questionId) async {

    InprogressQs = questionId;
    try {
      FormData formData = FormData.fromMap({
        "QsId":questionId,
      });
        Response response = await Dio().post("http://jamq.ir:3000/Tournament/GetQsData",data: formData);
      Questions.remove(questionId);
      print(response);
      return jsonDecode(response.data);
    } catch (e) {
      print(e);
    }
  }

  NexTQuestion(){

    setState(() {

    });

    selectedColor = Colors.red;
    UnselectedColor = Colors.white;
    if(Questions.length<=0){
      Alert(
        context: context,
        closeFunction: (){

        },
        type: AlertType.error,
        title: "باختی",
        desc:  "اشتباه جواب دادی !دوباره بازی کن تا برنده شی",
        buttons: [
          DialogButton(
            child: Text(
              "بستن",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed:(){
              RefreshData(UserInfo.GetPhoneNumber());
            },
            color: selectedColor,
            radius: BorderRadius.circular(5.0),
          ),
        ],
      ).show();
    }else{
      Alert(
        context: context,
        closeFunction: (){

        },
        type: AlertType.error,
        title: "اشتباه",
        desc:  "اشتباه جواب دادی !",
        buttons: [
          DialogButton(
            child: Text(
              "سوال بعدی",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed:(){
              setState(() {
                selectedColor = Color.fromRGBO(80, 0, 131, 1);
                UnselectedColor = Colors.white;
                Navigator.pop(context);
                loadfuture =     GetQuestionData(Questions[0]);
                _controller.restart(duration:qstime);
              });
            },
            color: selectedColor,
            radius: BorderRadius.circular(5.0),
          ),
        ],
      ).show();
    }
  }
  RefreshData(Number) async {
    print('lAAAAAAAogin');
    FormData formData = FormData.fromMap({
      "usernumber":Number,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetUserInfoByPhone",data:formData);
      GetTournaments(response.data);
    } catch (e) {
      print(e);
    }
  }
  TrueAnwser(){

    selectedColor = Colors.green;
    UnselectedColor = Colors.red;
    if(Questions.length<=0){
      Alert(
        context: context,
        closeFunction: (){

        },
        type: AlertType.error,
        title: "برنده شدی",
        desc:  "تبریک میگم برنده شدی.",
        buttons: [
          DialogButton(
            child: Text(
              "باشه",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed:(){
              if(SingleElimanation){
                SingleWinPrize();
              }else{
                RefreshData(UserInfo.GetPhoneNumber());
              }

            },
            color: selectedColor,
            radius: BorderRadius.circular(5.0),
          ),
        ],
      ).show();
    }else{
      Alert(
        context: context,
        closeFunction: (){

        },
        type: AlertType.error,
        title: "آفرین",
        desc:  "آفرین !!! درست جواب دادی ",
        buttons: [
          DialogButton(
            child: Text(
              "سوال بعدی",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed:(){
              setState(() {
                selectedColor = Color.fromRGBO(80, 0, 131, 1);
                UnselectedColor = Colors.white;
                Navigator.pop(context);
                loadfuture =     GetQuestionData(Questions[0]);
                _controller.restart(duration:qstime);
              });
            },
            color: selectedColor,
            radius: BorderRadius.circular(5.0),
          ),
        ],
      ).show();
    }

  }

  GetTournaments(dt) async {
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/GetActiveTournaments");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:TournamentMain(dt,response.data))),(Route<dynamic> route) => false);

    } catch (e) {
      print(e);
    }
  }

  WrongAnswer(TrueAnswer){

    setState(() {

    });

    selectedColor = Colors.red;
    UnselectedColor = Colors.white;
    if(Questions.length<=0){
      Alert(
        context: context,
        closeFunction: (){

        },
        type: AlertType.error,
        title: "باختی",
        desc:  "اشتباه جواب دادی !دوباره بازی کن تا برنده شی",
        buttons: [
          DialogButton(
            child: Text(
              "بستن",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed:(){
              RefreshData(UserInfo.GetPhoneNumber());
            },
            color: selectedColor,
            radius: BorderRadius.circular(5.0),
          ),
        ],
      ).show();
    }else{
      Alert(
        context: context,
        closeFunction: (){

        },
        type: AlertType.error,
        title: "باختی",
        desc:  "اشتباه جواب دادی ! میخوای ادامه بدی",
        buttons: [
          DialogButton(
            child: Text(
              "آره",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed:(){
              ContinuePlaying();
            },
            color: selectedColor,
            radius: BorderRadius.circular(5.0),
          ),
          DialogButton(
            child: Text(
              "نه",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed:(){
              RefreshData(UserInfo.GetPhoneNumber());
            },
            color: selectedColor,
            radius: BorderRadius.circular(5.0),
          ),
        ],
      ).show();
    }
  }

  ContinuePlaying() async {
    Navigator.pop(context);
    _openLoadingDialog(context);
    FormData formData = FormData.fromMap({
      "PlayerID":UserInfo.GetPhoneNumber(),
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/ContinuePlaying",data:formData);
      Navigator.pop(context);
      if(response.data=='NotEnoughLife'){
        Alert(
          context: context,
          closeFunction: (){

          },
          type: AlertType.error,
          title: "جون نداری ",
          desc:  "جون نداری، میتونی جون رو از فروشگاه تهیه کنی،",
          buttons: [
            DialogButton(
              child: Text(
                "خروج",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed:(){
                RefreshData(UserInfo.GetPhoneNumber());
              },
              color: selectedColor,
              radius: BorderRadius.circular(5.0),
            ),
            DialogButton(
              child: Text(
                "فروشگاه",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed:(){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:Shop(widget.UIC))),(Route<dynamic> route) => false);
              },
              color: selectedColor,
              radius: BorderRadius.circular(5.0),
            ),
          ],
        ).show();
      }else if(response.data == 'LifeDecreased'){
        Alert(
          context: context,
          closeFunction: (){

          },
          type: AlertType.error,
          title: "یه جون ازت کم شد",
          desc:  "میتونی به بازی ادامه بدی",
          buttons: [
            DialogButton(
              child: Text(
                "باشه",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed:(){
                setState(() {
                  selectedColor = Color.fromRGBO(80, 0, 131, 1);
                  UnselectedColor = Colors.white;
                  Navigator.pop(context);
                  loadfuture =     GetQuestionData(Questions[0]);
                  _controller.restart(duration:qstime);
                });
              },
              color: selectedColor,
              radius: BorderRadius.circular(5.0),
            ),
          ],
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }

  PresentHelp(QsId) async {

    FormData formData = FormData.fromMap({
      "QsId":QsId,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/OthersHelp",data:formData);
      Qs1Count = response.data['QSChoice1'].toString();
      Qs2Count = response.data['QSChoice2'].toString();
      Qs3Count = response.data['QSChoice3'].toString();
      Qs4Count = response.data['QSChoice4'].toString();
    } catch (e) {
      print(e);
    }
  }

  SingleWinPrize() async {
    FormData formData = FormData.fromMap({
      "UserId ":UserInfo.GetPhoneNumber(),
      "TournamentId ":_ParsedData['TournamentId'],
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/UserWinSingleElimanation",data:formData);
      RefreshData(UserInfo.GetPhoneNumber());

    } catch (e) {
      print(e);
    }
  }
}