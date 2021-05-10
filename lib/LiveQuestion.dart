import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:confetti/confetti.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jamqpwa/LiveMain.dart';
import 'package:jamqpwa/MainPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:socket_io_client/socket_io_client.dart';

class LiveQuestion extends StatefulWidget{

  var Question,QsId,AnsweringTime,MatchId,PlayerId,UIC;
  String Choice1,Choice2,Choice3;
  LiveQuestion(this.Question,this.Choice1,this.Choice2,this.Choice3,this.QsId,this.AnsweringTime,this.MatchId,this.PlayerId,this.UIC);
  LiveQuestion.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LiveQuestionState();
  }

}
class LiveQuestionState extends State<LiveQuestion>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedChoice = '99';
  var s= 0;
  var   selectedColor = Color.fromRGBO(80, 0, 131, 1);
  var   UnselectedColor = Colors.white;
  CountDownController _controller = CountDownController();
  Socket socket;
  String createdViewId = 'map_element';
  List<String> curses = new List();
  ConfettiController _controllerCenter;
  var radiobtn;
  var pink = Color.fromRGBO(249, 211, 248, 1);
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  var ISAnswerd = 'false';
  var profback = AssetImage('assets/images/profback.png');
  Future loadfuture;
  var aho;

  @override
  void initState() {
    // TODO: implement initState
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 2));

    super.initState();
  }
  @override
  void dispose() {
    super.dispose(); // always call super for dispose/initState
    socket.disconnect();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double c_width = MediaQuery.of(context).size.width;
    double c_height = MediaQuery.of(context).size.height*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double P_height = MediaQuery.of(context).size.height*0.6;

    ConnectSocket();
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/aboutusport.jpg'),
                      fit: BoxFit.fill)
              ),
              child: Column(
                children: [
                  Padding(
                    child:   Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      margin: EdgeInsets.all(10),
                      elevation: 10,
                      child:Container(
                        width: c_width,
                        height: P_height,
                        color:Colors.white,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.deepPurple,
                                    radius: 60,
                                    backgroundImage:  profback,
                                  ),
                                  padding: EdgeInsets.only(top: 20),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child:   CircularCountDownTimer(
                                    duration: widget.AnsweringTime,
                                    controller: _controller,
                                    width: 150,
                                    height: 150,
                                    color: Colors.white,
                                    fillColor: purplecolor,
                                    backgroundColor: null,
                                    strokeWidth: 5.0,
                                    textStyle: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
                                    isReverse: false,
                                    isReverseAnimation: false,
                                    isTimerTextShown: false,
                                    onComplete: () {
                                      print('Countdown Ended');
                                      print(ISAnswerd);
                                      if(ISAnswerd =='false'){
                                        ISAnswerd = 'true';
                                        sendQS(widget.QsId,widget.MatchId,selectedChoice);
                                      }else{

                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.Question,style: TextStyle(
                                    color: themeColor,
                                    fontSize: 20,
                                    fontFamily: 'MyFont'
                                ),)
                              ],
                            ),
                            ConfettiWidget(
                              confettiController: _controllerCenter,
                              blastDirectionality: BlastDirectionality.explosive, // d
                              maxBlastForce: 25,// on't specify a direction, blast randomly
                              numberOfParticles: 50,
                              shouldLoop:
                              false, // start again as soon as the animation is finished
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
                                elevation: 5  ,
                                height: 50,
                                selectedBorderColor:selectedColor,
                                unSelectedColor: UnselectedColor,
                                unSelectedBorderColor: UnselectedColor,
                                enableShape: true,
                                enableButtonWrap: true,
                                buttonLables: [
                                  widget.Choice1,
                                  widget.Choice2,
                                  widget.Choice3,
                                ],
                                buttonValues: [
                                  widget.Choice1,
                                  widget.Choice2,
                                  widget.Choice3,
                                ],
                                radioButtonValue: (values) {
                                  print(values);
                                  selectedChoice = values;
                                  print(selectedChoice);
                                  setState(() {

                                  });
                                },
                                horizontal: true,
                                width: 100,
                                selectedColor: selectedColor,
                                padding: 10,
                                spacing: 0.0,
                                // enableShape: true,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(top:50),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
  sendQS(QsId,MatchId,TrueAnswer) async {
    _controller.pause();
    if(TrueAnswer == widget.Choice1){
      TrueAnswer = '1';
    }else if( TrueAnswer == widget.Choice2){
      TrueAnswer = '2';
    }else if(TrueAnswer == widget.Choice3){
      TrueAnswer = '3';
    }else{
      TrueAnswer = '99';
    }

    FormData formData = FormData.fromMap({
      "QsId":QsId,
      "MatchId": MatchId,
      "TrueAnswer":TrueAnswer,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/LiveMatch/QuestionAnalyzer",data:formData);
      print(response.data.toString());
      if(response.data == 'TrueAnswer'){
        setState(() {
          selectedColor = Colors.green;
          UnselectedColor = Colors.red;
          _controllerCenter.play();
        });
        rightAnswer(context);
      }else if(response.data == 'WrongAnswer'){

        WrongAnswer();
      }

    } catch (e) {
      print(e);
    }
  }

  ConnectSocket() async {
    socket = io('http://jamq.ir:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false, // optional
    });
    socket.connect();
    socket.on('connect', (_) {
      LostState();
    });
  }


  LostState(){
    socket.on('LostState', (data) async =>
        LostStateFunc(data)
    );
  }

  LostStateFunc(data) {

    if(data == "LiveDecreased"){
      Alert(
        context: context,
        type: AlertType.error,
        title: "یه جون ازت کم شد",
        desc:  "میتونی بازی رو ادامه بدی ولی مواظب باش از یه جونت استفاده کردی",
        buttons: [
          DialogButton(
            child: Text(
              "باشه",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: LiveMain(widget.PlayerId,widget.MatchId,widget.UIC))),(Route<dynamic> route) => false),
            color: themeColor,
            radius: BorderRadius.circular(5.0),
          ),
        ],
      ).show();
    }else if(data == "LifeUsed"){
      Alert(
        context: context,
        type: AlertType.error,
        title: "قبلا از یه جون استفاده کردی",
        desc:  "اشکالی نداره تو مسابقه بعدی همدیگه رو میبینیم",
        buttons: [
          DialogButton(
            child: Text(
              "باشه",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () =>  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  MainPage(widget.UIC))),(Route<dynamic> route) => false),
            color: themeColor,
            radius: BorderRadius.circular(5.0),
          ),
        ],
      ).show();
    }else if(data == "NoLife"){
      Alert(
        context: context,
        type: AlertType.error,
        title: "جون نداری!",
        desc:  "قبل از شروع مسابقه بعدی مطمن شو جون اضافه از فروشگاه بگیریو تو مسابقه بعدی میبینمت",
        buttons: [
          DialogButton(
            child: Text(
              "باشه",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () =>  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  MainPage(widget.UIC))),(Route<dynamic> route) => false),
            color: themeColor,
            radius: BorderRadius.circular(5.0),
          ),
        ],
      ).show();
    }

  }

  SendLostMatch(PId,Cntinue){

    Map<String, dynamic> LostMatch = new Map();
    LostMatch['PlayerId'] = PId ;
    LostMatch['MatchID'] =widget.MatchId;
    LostMatch['Continue'] =Cntinue;
    socket.emit('LostMatch', [jsonEncode(LostMatch)]);

  }

  WrongAnswer(){

    SendLostMatch(widget.PlayerId,'No');
    setState(() {

    });
    selectedColor = Colors.red;
    UnselectedColor = Colors.red;
    Alert(
      context: context,

      type: AlertType.error,
      title: "سوال رو اشتباه جواب دادی!",
      desc:  'ایا میخوای با از دست دادن یه جون به بازی برگردی؟',
      buttons: [
        DialogButton(
          child: Text(
            "اره",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () =>SendLostMatch(widget.PlayerId,'Yes') ,
          color: Colors.red,
          radius: BorderRadius.circular(5.0),
        ),
        DialogButton(
          child: Text(
            "نه",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () =>  Alert(
            context: context,
            type: AlertType.error,
            title: "پایان مسابقه",
            desc:  " تو مسابقه بعدی میبینمت",
            buttons: [
              DialogButton(
                child: Text(
                  "باشه",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () =>  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  MainPage(widget.UIC))),(Route<dynamic> route) => false),
                color: themeColor,
                radius: BorderRadius.circular(5.0),
              ),
            ],
          ).show() ,
          color: Colors.red,
          radius: BorderRadius.circular(5.0),
        ),
      ],
    ).show();
  }

  rightAnswer(context)  {

    Timer.periodic(Duration(seconds: 3), (timer) {
      Navigator.of(context, rootNavigator: true).pop(context);
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  LiveMain(widget.MatchId,widget.PlayerId,widget.UIC))),(Route<dynamic> route) => false);

    });

  }
}