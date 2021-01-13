import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:confetti/confetti.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:jamqpwa/TournamentSetterClass.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'MainPage.dart';
import 'Shop.dart';
import 'UserInfoClass.dart';

class TournamentQuestion extends StatefulWidget{
  var UIC,questions,TournamentSettings;
  TournamentQuestion(this.UIC,this.questions,this.TournamentSettings);
  TournamentQuestion.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TournamentQuestionState();
  }

}
class TournamentQuestionState extends State<TournamentQuestion>{
  var   selectedColor = Color.fromRGBO(80, 0, 131, 1);
  TournamentSetter TournamentData;
  UserInfoClass UserInfo ;
  Future loadfuture;
  var   UnselectedColor = Colors.white;
  CountDownController _controller;
  ConfettiController _controllerCenter;
  var qstime = 0 ;
  var OtherHelp = '0';
  var BoxColor1,BoxColor2;
  var QuestionsAsked=0;
  var _ParsedData;
  var SingleElimanation;
  int QuestionTime;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    print('________________________');
    print(widget.questions);
    print('________________________');
    print('________________________');
    print('________________________');
     _ParsedData =  jsonDecode(widget.TournamentSettings);
    print('________________________');
    print('________________________');
    print('________________________');
    print('________________________');
    print(widget.UIC);
    print('________________________');
    print(DateTime.now().toString());
    print('________________________');
    UserInfo = new UserInfoClass(widget.UIC);
    _controller = CountDownController();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 3));
    SingleElimanation = _ParsedData['TrSingleelimination'];
    loadfuture = GetQuestionData(widget.questions);

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double P_height = MediaQuery.of(context).size.height*0.9;
    double P_width = MediaQuery.of(context).size.width*0.9;
    var pink = Color.fromRGBO(249, 211, 248, 1);
    var themeColor = Color.fromRGBO(19, 2, 102, 1);
    var purplecolor = Color.fromRGBO(80, 0, 131,1);
    var Green = Color.fromRGBO(3, 170, 2,1);
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
      print('ThatRans');
      print(_ParsedData['TrAnsweringTime']);

      qstime =int.parse(_ParsedData['TrAnsweringTime']);
      QuestionTime =int.parse(_ParsedData['TrAnsweringTime']);
    }
    if(QuestionsAsked == 99){
      print('EndTr');
    }

    // TODO: implement build
    return  FutureBuilder(
        future:loadfuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ?
          new Scaffold(body: new   Scaffold(
            body:  Container(
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
                            Padding(child:Row(
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
                            Padding(child:
                            CircularCountDownTimer(
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
                                print('Countdown Ended');
                              },
                            ),padding: EdgeInsets.only(top: 30),),
                            Padding(child:     Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(snapshot.data['QSText'],style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 22,fontWeight: FontWeight.bold),),
                              ],),padding: EdgeInsets.only(top: 20),),
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
                              child:CustomRadioButton(
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
                                  snapshot.data['QSChoice1'],
                                  snapshot.data['QSChoice2'],
                                  snapshot.data['QSChoice3'],
                                  snapshot.data['QSChoice4'],
                                ],
                                buttonValues: [
                                  '1',
                                  '2',
                                  '3',
                                  '4',
                                ],
                                radioButtonValue: (values) {
                                  AnalayzeQuestion(widget.questions[QuestionsAsked],values,UserInfo.GetPhoneNumber(), _ParsedData['TournamentId']);
                                },
                                horizontal: true,
                                width: 100,
                                selectedColor: selectedColor,
                                padding: 10,
                                spacing: 0.0,
                                // enableShape: true,
                              ),
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
                                              colors: [themeColor,purplecolor ],
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
            ),
          )	) : new Center(child: CircularProgressIndicator(),);

        });

  }

  AnalayzeQuestion(QsId,UserChoice,PlayerId,TrID) async {
    try {
      FormData formData = FormData.fromMap({
        "QsId":QsId,
        "UserChoice":UserChoice,
        "PlayerId":PlayerId,
        "TrID":TrID,
      });
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/QuestionAnalyzer",data: formData);

    } catch (e) {
      print(e);
    }
  }

  GetQuestionData(questions) async {
    print('RansRhouthg Hre');
    try {
      FormData formData = FormData.fromMap({
        "QsId":questions[QuestionsAsked],
      });
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/GetQsData",data: formData);
      print(response);
      if(QuestionsAsked < questions.length){
        QuestionsAsked = QuestionsAsked+1;
      }else{
        QuestionsAsked = 99;
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

}