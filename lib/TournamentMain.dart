import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:jamqpwa/TournamentQuestion.dart';
import 'package:jamqpwa/TournamentSetterClass.dart';
import 'package:jamqpwa/TrWinnersList.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'MainPage.dart';
import 'Shop.dart';
import 'UserInfoClass.dart';

class TournamentMain extends StatefulWidget{
  var UIC,TrData;
  TournamentMain(this.UIC,this.TrData);
  TournamentMain.none();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TournamentMainState();
  }
}
class TournamentMainState extends State<TournamentMain>{
  var AddedTime1 ;
  var AddedTime2 ;
  var AddedTime3 ;
  var   selectedColor = Color.fromRGBO(80, 0, 131, 1);
  TournamentSetter TournamentData;
  UserInfoClass UserInfo ;
  Future loadfuture;
  var   UnselectedColor = Colors.white;
  CountdownTimerController controller1;
  CountdownTimerController controller2;
  CountdownTimerController controller3;
  var Timer1;
  var Timer2;
  var Timer3;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
    TournamentData = new TournamentSetter(widget.TrData);
    Timer1=TournamentData.GetSpecialLeageData('Time');
    Timer2=TournamentData.GetSpeedLeageData('Time');
    Timer3=TournamentData.GetTodayOne('Time');
    AddedTime1 = TournamentData.GetSpecialLeageData('TrExpireDate');
    AddedTime2 = TournamentData.GetSpeedLeageData('TrExpireDate');
    AddedTime3 = TournamentData.GetTodayOne('TrExpireDate');
    AddedTime1 = AddedTime1.split('/');
    AddedTime2 = AddedTime2.split('/');
    AddedTime3 = AddedTime3.split('/');
    var  AddedDate1  = AddedTime1[0]+'-'+AddedTime1[1]+'-'+AddedTime1[2];
    var  AddedDate2  = AddedTime2[0]+'-'+AddedTime2[1]+'-'+AddedTime2[2];
    var  AddedDate3  = AddedTime3[0]+'-'+AddedTime3[1]+'-'+AddedTime3[2];
    print(AddedDate1);
    print(AddedDate2);
    print(AddedDate3);
    int endTime1 = DateTime.parse(AddedDate1+' '+Timer1.toString()).millisecondsSinceEpoch  ;
    int endTime2 = DateTime.parse(AddedDate2+' '+Timer2.toString()).millisecondsSinceEpoch   ;
    int endTime3 = DateTime.parse(AddedDate3+' '+Timer3.toString()).millisecondsSinceEpoch   ;
    print(endTime1);
    print(endTime2);
    print(endTime3);
    controller1 = CountdownTimerController(endTime: endTime1, onEnd: (){print('Ended'); });
    controller2 = CountdownTimerController(endTime: endTime2, onEnd: (){print('Ended'); });
    controller3 = CountdownTimerController(endTime: endTime3, onEnd: (){print('Ended'); });
    loadfuture = GetTournaments();

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double P_height = MediaQuery.of(context).size.height*0.6;
    double P_width = MediaQuery.of(context).size.width*0.6;
    var pink = Color.fromRGBO(249, 211, 248, 1);
    var themeColor = Color.fromRGBO(19, 2, 102, 1);
    var purplecolor = Color.fromRGBO(80, 0, 131,1);
    var Green = Color.fromRGBO(3, 170, 2,1);
    return FutureBuilder(
        future:loadfuture,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          var appscaffold;
          if(snapshot.data == true){
            appscaffold = new  Scaffold(
              body:  LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
                      return Scaffold(
                        body:  Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/shopback.jpg'),
                                    fit: BoxFit.fill)
                            ),
                            child: SingleChildScrollView  (
                              child: Column(
                                children: [
                                  Padding(
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          child:  Image.asset('assets/images/backico.png',height: 40,width: 40,),
                                          onTap: (){
                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(widget.UIC))),(Route<dynamic> route) => false);

                                          },
                                        )
                                      ],
                                    ),padding: EdgeInsets.only(top: 20,left: 10),),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            child:  Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 10,
                                              child:Container(
                                                height: 250,
                                                color: Colors.white,
                                              ),
                                            ),
                                            padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                child: Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(45),
                                                  ),
                                                  margin: EdgeInsets.all(10),
                                                  elevation: 10,
                                                  child:Container(
                                                    width: 190,
                                                    height: 40,
                                                    color: themeColor,
                                                    child: Center(
                                                        child:
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: <Widget>[
                                                            Padding(padding: EdgeInsets.only(right: 5),
                                                              child:  CountdownTimer(

                                                                controller: controller1,
                                                                widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
                                                                  if (time == null) {
                                                                    return Text('00:00:00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),);
                                                                  }
                                                                  List<Widget> list = [];
                                                                  if (time.sec != null) {
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text(time.sec.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }
                                                                  list.add( Text(' : ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),);
                                                                  if (time.min != null) {
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text(time.min.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }else{
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text('00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }
                                                                  list.add( Text(' : ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),);

                                                                  if (time.hours != null) {
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text(time.hours.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }else{
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text('00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }




                                                                  return Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: list,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Image.asset('assets/images/whitetimer.png',height: 25,width: 25),
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(left: 60),
                                              ),

                                            ],
                                          ),
                                          Padding(
                                            child:   Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  child:Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpecialLeageData('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 22,fontWeight: FontWeight.bold),),),
                                                  padding: EdgeInsets.only(left: 60),
                                                ),

                                              ],
                                            ),
                                            padding: EdgeInsets.only(top: 100),
                                          ),
                                          Padding(
                                            child:    Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(padding: EdgeInsets.only(left: 5),child:  Text('جوایز',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                                Padding(
                                                  child: Card(
                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(45),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 10,
                                                    child:Container(
                                                      width: 190,
                                                      height: 40,
                                                      color: purplecolor,
                                                      child: Center(
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: <Widget>[
                                                              Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpecialLeageData('Prize')+'  '+'تومان',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),

                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(left: 60),
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.only(top: 140,right: 25),
                                          ),
                                          Padding(
                                            child:   Center(
                                                child: InkWell(
                                                  child: Card(

                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(45),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 20,
                                                    child:Container(
                                                      width: 180,
                                                      height: 60,
                                                      color: Green,
                                                      child: Center(
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Padding(padding: EdgeInsets.only(right: 5),child:  Text('شروع بازی',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),

                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: (){
                                                    print('FALALALAL0');
                                                    print(TournamentData.GetSpecialLeageData('Id'));
                                                    StartMatch(P_width,Green,TournamentData.GetSpecialLeageData('Title'),TournamentData.GetSpecialLeageData('Icon'),TournamentData.GetSpecialLeageData('TrText'),TournamentData.GetSpecialLeageData('Prize'),'Gold',TournamentData.GetSpecialLeageData('Id'),TournamentData.GetSpecialLeageData('SingleState'));
                                                  },
                                                )
                                            ),
                                            padding: EdgeInsets.only(top: 230),
                                          ),
                                          Padding(
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Card(
                                                      semanticContainer: true,
                                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight:  Radius.circular(80),bottomLeft:  Radius.circular(80),topRight:  Radius.circular(15)),
                                                      ),
                                                      margin: EdgeInsets.all(10),
                                                      elevation: 10,
                                                      child:Container(
                                                          width: 150,
                                                          height:190,
                                                          color: themeColor,
                                                          child:Column(
                                                            children: [
                                                              Padding(padding: EdgeInsets.only(top: 15),child:  Text(TournamentData.GetSpecialLeageData('Category'),style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                              Padding(padding: EdgeInsets.only(top: 15),child:
                                                              Image.network(TournamentData.GetSpecialLeageData('Icon'),height: 100,width: 100,),
                                                              ),
                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[

                                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpecialLeageData('PlayersInGame'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                                        Image.asset('assets/images/userico.png',height: 25,width: 25),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],),
                                            padding: EdgeInsets.only(top: 20,left: 25),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Padding(
                                            child:  Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 10,
                                              child:Container(
                                                height: 250,
                                                color: Colors.white,
                                              ),
                                            ),
                                            padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                child: Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(45),
                                                  ),
                                                  margin: EdgeInsets.all(10),
                                                  elevation: 10,
                                                  child:Container(
                                                    width: 190,
                                                    height: 40,
                                                    color: themeColor,
                                                    child: Center(
                                                        child:
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: <Widget>[
                                                            CountdownTimer(

                                                              controller: controller2,
                                                              widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
                                                                if (time == null) {
                                                                  return Text('00:00:00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),);
                                                                }
                                                                List<Widget> list = [];
                                                                if (time.sec != null) {
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text(time.sec.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }
                                                                list.add( Text(' : ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),);
                                                                if (time.min != null) {
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text(time.min.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }else{
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text('00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }
                                                                list.add( Text(' : ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),);
                                                                print(')))))))))))))))))');
                                                                print(')))))))))))))))))');
                                                                print(time.hours);
                                                                if (time.hours != null) {
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text(time.hours.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }else{
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text('00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }




                                                                return Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: list,
                                                                );
                                                              },
                                                            ),
                                                            Image.asset('assets/images/whitetimer.png',height: 25,width: 25),
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(left: 60),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            child:   Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  child:Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpeedLeageData('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 22,fontWeight: FontWeight.bold),),),
                                                  padding: EdgeInsets.only(left: 60),
                                                ),

                                              ],
                                            ),
                                            padding: EdgeInsets.only(top: 100),
                                          ),
                                          Padding(
                                            child:    Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(padding: EdgeInsets.only(left: 5),child:  Text('جوایز',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                                Padding(
                                                  child: Card(
                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(45),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 10,
                                                    child:Container(
                                                      width: 190,
                                                      height: 40,
                                                      color: purplecolor,
                                                      child: Center(
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: <Widget>[
                                                              Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpeedLeageData('Prize').toString()+'  '+'تومان',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),

                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(left: 60),
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.only(top: 140,right: 25),
                                          ),
                                          Padding(
                                            child:   Center(
                                              child: Card(
                                                semanticContainer: true,
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(45),
                                                ),
                                                margin: EdgeInsets.all(10),
                                                elevation: 20,
                                                child:Container(
                                                  width: 180,
                                                  height: 60,
                                                  color: Green,
                                                  child: Center(
                                                      child:InkWell(
                                                        child:Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            Padding(padding: EdgeInsets.only(right: 5),child:  Text('شروع بازی',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),

                                                          ],
                                                        ),
                                                        onTap: (){
                                                          print('ThisClicked');
                                                          StartMatch(P_width,Green,TournamentData.GetSpeedLeageData('Title'),TournamentData.GetSpeedLeageData('Icon'),TournamentData.GetSpeedLeageData('TrText'),TournamentData.GetSpeedLeageData('Prize'),'Gold',TournamentData.GetSpeedLeageData('Id'),TournamentData.GetSpeedLeageData('SingleState'));
                                                        },
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                            padding: EdgeInsets.only(top: 230),
                                          ),
                                          Padding(
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Card(
                                                      semanticContainer: true,
                                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight:  Radius.circular(80),bottomLeft:  Radius.circular(80),topRight:  Radius.circular(15)),
                                                      ),
                                                      margin: EdgeInsets.all(10),
                                                      elevation: 10,
                                                      child:Container(
                                                          width: 150,
                                                          height:190,
                                                          color: themeColor,
                                                          child:Column(
                                                            children: [
                                                              Padding(padding: EdgeInsets.only(top: 15),child:  Text(TournamentData.GetSpeedLeageData('Category'),style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                              Padding(padding: EdgeInsets.only(top: 15),child: Image.network(TournamentData.GetSpeedLeageData('Icon'),height: 100,width: 100,),
                                                              ),
                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[

                                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpeedLeageData('PlayersInGame'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                                        Image.asset('assets/images/userico.png',height: 25,width: 25),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],),
                                            padding: EdgeInsets.only(top: 20,left: 25),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Center(
                                            child:  Padding(
                                              child: Image.asset('assets/images/gamebox.png',),
                                              padding: EdgeInsets.all(20),
                                            ),
                                          ),
                                          Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(top: 30),
                                                  child: Column(
                                                    children: [
                                                      Card(
                                                        semanticContainer: true,
                                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(45),
                                                        ),
                                                        margin: EdgeInsets.all(10),
                                                        elevation: 10,
                                                        child:Container(
                                                          width: 180,
                                                          height: 35,
                                                          color: Colors.white,
                                                          child: Center(
                                                              child:
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: <Widget>[
                                                                  CountdownTimer(

                                                                    controller: controller3,
                                                                    widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
                                                                      if (time == null) {
                                                                        return Text('00:00:00',style: TextStyle(color:themeColor,fontSize: 16,fontWeight: FontWeight.bold),);
                                                                      }
                                                                      List<Widget> list = [];
                                                                      if (time.sec != null) {
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text(time.sec.toString(),style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }
                                                                      list.add( Text(' : ',style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),);
                                                                      if (time.min != null) {
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text(time.min.toString(),style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }else{
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text('00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }
                                                                      list.add( Text(' : ',style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),);

                                                                      if (time.hours != null) {
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text(time.hours.toString(),style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }else{
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text('00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }




                                                                      return Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: list,
                                                                      );
                                                                    },
                                                                  ),
                                                                  Image.asset('assets/images/whitetimer.png',height: 25,width: 25,color: themeColor,),
                                                                ],
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Padding(padding: EdgeInsets.only(right: 5),child:  Text('بازی امروز',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),
                                                          Padding(padding: EdgeInsets.only(right: 30),child:  Text(SetTodayPrize(int.parse(TournamentData.GetTodayOne('Prize')),int.parse(TournamentData.GetTodayTwo('Prize'))).toString()+' تومان ',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),
                                                        ],
                                                      )
                                                    ],
                                                  ))
                                          ),

                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(top: 30),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          InkWell(
                                                            child:  Card(
                                                              semanticContainer: true,
                                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(25),
                                                              ),
                                                              margin: EdgeInsets.all(10),
                                                              elevation: 10,
                                                              child:Container(
                                                                  width: 200,
                                                                  height:150,
                                                                  color: Colors.white,
                                                                  child:Column(
                                                                    children: [
                                                                      Stack(
                                                                        children: [
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Image.asset('assets/images/trtournament.png'),
                                                                              padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                                                                            ),
                                                                            alignment: Alignment.topCenter,
                                                                          ),
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Image.network(TournamentData.GetTodayOne('Icon'),height: 50,width: 50,),
                                                                              padding: EdgeInsets.only(right: 25 ,top: 15),
                                                                            ),
                                                                            alignment: Alignment.topRight,
                                                                          ),
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Text(TournamentData.GetTodayOne('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 15,fontWeight: FontWeight.bold),),
                                                                              padding: EdgeInsets.only(right:35,top: 25),
                                                                            ),
                                                                            alignment: Alignment.topCenter,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Image.asset('assets/images/trprizeico.png',height: 30,width: 30,),
                                                                          Padding(
                                                                            child: Text('جوایز : ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
                                                                            padding: EdgeInsets.only(right: 5),
                                                                          )

                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        child:   Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(TournamentData.GetTodayOne('Prize')+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ),
                                                                        padding: EdgeInsets.only(top: 10),
                                                                      )
                                                                    ],
                                                                  )
                                                              ),
                                                            ),
                                                            onTap: (){
                                                              StartMatch(P_width,Green,TournamentData.GetTodayOne('Title'),TournamentData.GetTodayOne('Icon'),TournamentData.GetTodayOne('TrText'),TournamentData.GetTodayOne('Prize'),'Blue',TournamentData.GetTodayOne('Id'),TournamentData.GetTodayOne('SingleState'));

                                                            },
                                                          ),
                                                          InkWell(
                                                            child:  Card(
                                                              semanticContainer: true,
                                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(25),
                                                              ),
                                                              margin: EdgeInsets.all(10),
                                                              elevation: 10,
                                                              child:Container(
                                                                  width: 200,
                                                                  height:150,
                                                                  color: Colors.white,
                                                                  child:Column(
                                                                    children: [
                                                                      Stack(
                                                                        children: [
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Image.asset('assets/images/trtournament.png'),
                                                                              padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                                                                            ),
                                                                            alignment: Alignment.topCenter,
                                                                          ),
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Image.network(TournamentData.GetTodayTwo('Icon'),height: 50,width: 50,),
                                                                              padding: EdgeInsets.only(right: 25 ,top: 15),
                                                                            ),
                                                                            alignment: Alignment.topRight,
                                                                          ),
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Text(TournamentData.GetTodayTwo('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 15,fontWeight: FontWeight.bold),),
                                                                              padding: EdgeInsets.only(right:35,top: 25),
                                                                            ),
                                                                            alignment: Alignment.topCenter,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Image.asset('assets/images/trprizeico.png',height: 30,width: 30,),
                                                                          Padding(
                                                                            child: Text('جوایز : ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                            padding: EdgeInsets.only(right: 5),
                                                                          )

                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        child:   Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(TournamentData.GetTodayTwo('Prize')+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ),
                                                                        padding: EdgeInsets.only(top: 10),
                                                                      )
                                                                    ],
                                                                  )
                                                              ),
                                                            ),
                                                            onTap: (){
                                                              StartMatch(P_width,Green,TournamentData.GetTodayTwo('Title'),TournamentData.GetTodayTwo('Icon'),TournamentData.GetTodayTwo('TrText'),TournamentData.GetTodayTwo('Prize'),'Blue',TournamentData.GetTodayTwo('Id'),TournamentData.GetTodayTwo('SingleState'));
                                                            },
                                                          )

                                                        ],
                                                      )
                                                    ],
                                                  ))
                                          ),

                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Center(
                                            child:  Padding(
                                              child: Image.asset('assets/images/gamebox.png',),
                                              padding: EdgeInsets.all(20),
                                            ),
                                          ),
                                          Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(top: 80),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Padding(padding: EdgeInsets.only(right: 5),child:  Text('بازی فردا',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),
                                                          Padding(padding: EdgeInsets.only(right: 30),child:  Text(SetTodayPrize(int.parse(TournamentData.GetTomorrowOne('Prize')),int.parse(TournamentData.GetTomorrowTwo('Prize'))).toString()+' تومان ',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),
                                                        ],
                                                      )
                                                    ],
                                                  ))
                                          ),

                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(top: 30),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Card(
                                                            semanticContainer: true,
                                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(25),
                                                            ),
                                                            margin: EdgeInsets.all(10),
                                                            elevation: 10,
                                                            child:Container(
                                                                width: 200,
                                                                height:150,
                                                                color: Colors.grey,
                                                                child:Column(
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        Align(
                                                                          child: Padding(
                                                                            child: Image.asset('assets/images/trtournament.png'),
                                                                            padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                                                                          ),
                                                                          alignment: Alignment.topCenter,
                                                                        ),
                                                                        Align(
                                                                          child: Padding(
                                                                            child:  Image.network(TournamentData.GetTomorrowOne('Icon'),height: 50,width: 50,),
                                                                            padding: EdgeInsets.only(right: 25 ,top: 15),
                                                                          ),
                                                                          alignment: Alignment.topRight,
                                                                        ),
                                                                        Align(
                                                                          child: Padding(
                                                                            child: Text(TournamentData.GetTomorrowOne('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 15,fontWeight: FontWeight.bold),),
                                                                            padding: EdgeInsets.only(right:35,top: 25),
                                                                          ),
                                                                          alignment: Alignment.topCenter,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Image.asset('assets/images/trprizeico.png',height: 30,width: 30,),
                                                                        Padding(
                                                                          child: Text('جوایز : ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                          padding: EdgeInsets.only(right: 5),
                                                                        )

                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      child:   Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(TournamentData.GetTomorrowOne('Prize')+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                        ],
                                                                      ),
                                                                      padding: EdgeInsets.only(top: 10),
                                                                    )
                                                                  ],
                                                                )
                                                            ),
                                                          ),
                                                          Card(
                                                            semanticContainer: true,
                                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(25),
                                                            ),
                                                            margin: EdgeInsets.all(10),
                                                            elevation: 10,
                                                            child:Container(
                                                                width: 200,
                                                                height:150,
                                                                color: Colors.grey,
                                                                child:Column(
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        Align(
                                                                          child: Padding(
                                                                            child: Image.asset('assets/images/trtournament.png'),
                                                                            padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                                                                          ),
                                                                          alignment: Alignment.topCenter,
                                                                        ),
                                                                        Align(
                                                                          child: Padding(
                                                                            child:  Image.network(TournamentData.GetTomorrowTwo('Icon'),height: 50,width: 50,),
                                                                            padding: EdgeInsets.only(right: 25 ,top: 15),
                                                                          ),
                                                                          alignment: Alignment.topRight,
                                                                        ),
                                                                        Align(
                                                                          child: Padding(
                                                                            child: Text(TournamentData.GetTomorrowTwo('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 15,fontWeight: FontWeight.bold),),
                                                                            padding: EdgeInsets.only(right:35,top: 25),
                                                                          ),
                                                                          alignment: Alignment.topCenter,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Image.asset('assets/images/trprizeico.png',height: 30,width: 30,),
                                                                        Padding(
                                                                          child: Text('جوایز : ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                          padding: EdgeInsets.only(right: 5),
                                                                        )

                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      child:   Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(TournamentData.GetTomorrowTwo('Prize')+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                        ],
                                                                      ),
                                                                      padding: EdgeInsets.only(top: 10),
                                                                    )
                                                                  ],
                                                                )
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ))
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ),
                      );
                    } else {
                      return Scaffold(
                        body:  Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/shopback.jpg'),
                                    fit: BoxFit.fill)
                            ),
                            child: SingleChildScrollView  (
                              child: Column(
                                children: [
                                  Padding(
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          child:  Image.asset('assets/images/backico.png',height: 40,width: 40,),
                                          onTap: (){
                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(widget.UIC))),(Route<dynamic> route) => false);

                                          },
                                        )
                                      ],
                                    ),padding: EdgeInsets.only(top: 20,left: 10),),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            child:  Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 10,
                                              child:Container(
                                                height: 250,
                                                color: Colors.white,
                                              ),
                                            ),
                                            padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                child: Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(45),
                                                  ),
                                                  margin: EdgeInsets.all(10),
                                                  elevation: 10,
                                                  child:Container(
                                                    width: 170,
                                                    height: 40,
                                                    color: themeColor,
                                                    child: Center(
                                                        child:
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: <Widget>[
                                                            Padding(padding: EdgeInsets.only(right: 5),
                                                              child:  CountdownTimer(

                                                                controller: controller1,
                                                                widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
                                                                  if (time == null) {
                                                                    return Text('00:00:00',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),);
                                                                  }
                                                                  List<Widget> list = [];
                                                                  if (time.sec != null) {
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text(time.sec.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }
                                                                  list.add( Text(' : ',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),);
                                                                  if (time.min != null) {
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text(time.min.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }else{
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text('00',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }
                                                                  list.add( Text(' : ',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),);

                                                                  if (time.hours != null) {
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text(time.hours.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }else{
                                                                    list.add(Row(
                                                                      children: <Widget>[
                                                                        Text('00',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ));
                                                                  }
                                                                  return Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: list,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Image.asset('assets/images/whitetimer.png',height: 25,width: 25),
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(right: 20),
                                              ),

                                            ],
                                          ),
                                          Padding(
                                            child:   Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  child:Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpecialLeageData('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 22,fontWeight: FontWeight.bold),),),
                                                  padding: EdgeInsets.only(right: 30),
                                                ),

                                              ],
                                            ),
                                            padding: EdgeInsets.only(top: 70),
                                          ),
                                          Padding(
                                            child:    Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(padding: EdgeInsets.only(left: 5),child:  Text('جوایز',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),),
                                                Padding(
                                                  child: Card(
                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(45),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 10,
                                                    child:Container(
                                                      width: 140,
                                                      height: 40,
                                                      color: purplecolor,
                                                      child: Center(
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: <Widget>[
                                                              Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpecialLeageData('Prize')+'  '+'تومان',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),),

                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(left: 60),
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.only(top: 140,right: 25),
                                          ),
                                          Padding(
                                            child:   Center(
                                                child: InkWell(
                                                  child: Card(

                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(45),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 20,
                                                    child:Container(
                                                      width: 160,
                                                      height: 50,
                                                      color: Green,
                                                      child: Center(
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Padding(padding: EdgeInsets.only(right: 5),child:  Text('شروع بازی',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),

                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: (){
                                                    print('FALALALAL0');
                                                    print(TournamentData.GetSpecialLeageData('Id'));
                                                    StartMatch(P_width,Green,TournamentData.GetSpecialLeageData('Title'),TournamentData.GetSpecialLeageData('Icon'),TournamentData.GetSpecialLeageData('TrText'),TournamentData.GetSpecialLeageData('Prize'),'Gold',TournamentData.GetSpecialLeageData('Id'),TournamentData.GetSpecialLeageData('SingleState'));
                                                  },
                                                )
                                            ),
                                            padding: EdgeInsets.only(top: 230),
                                          ),
                                          Padding(
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Card(
                                                      semanticContainer: true,
                                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight:  Radius.circular(80),bottomLeft:  Radius.circular(80),topRight:  Radius.circular(15)),
                                                      ),
                                                      margin: EdgeInsets.all(10),
                                                      elevation: 10,
                                                      child:Container(
                                                          width: 140,
                                                          height:160,
                                                          color: themeColor,
                                                          child:Column(
                                                            children: [
                                                              Padding(padding: EdgeInsets.only(top: 15),child:  Text(TournamentData.GetSpecialLeageData('Category'),style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                              Padding(padding: EdgeInsets.only(top: 15),child: Image.network(TournamentData.GetSpecialLeageData('Icon'),height: 100,width: 100,),
                                                              ),
                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[

                                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpecialLeageData('PlayersInGame'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                                        Image.asset('assets/images/userico.png',height: 25,width: 25),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],),
                                            padding: EdgeInsets.only(top: 20,left: 25),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Padding(
                                            child:  Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 10,
                                              child:Container(
                                                height: 250,
                                                color: Colors.white,
                                              ),
                                            ),
                                            padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                child: Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(45),
                                                  ),
                                                  margin: EdgeInsets.all(10),
                                                  elevation: 10,
                                                  child:Container(
                                                    width: 170,
                                                    height: 40,
                                                    color: themeColor,
                                                    child: Center(
                                                        child:
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: <Widget>[
                                                            CountdownTimer(

                                                              controller: controller2,
                                                              widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
                                                                if (time == null) {
                                                                  return Text('00:00:00',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),);
                                                                }
                                                                List<Widget> list = [];
                                                                if (time.sec != null) {
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text(time.sec.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }
                                                                list.add( Text(' : ',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),);
                                                                if (time.min != null) {
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text(time.min.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }else{
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text('00',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }
                                                                list.add( Text(' : ',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),);
                                                                print(')))))))))))))))))');
                                                                print(')))))))))))))))))');
                                                                print(time.hours);
                                                                if (time.hours != null) {
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text(time.hours.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }else{
                                                                  list.add(Row(
                                                                    children: <Widget>[
                                                                      Text('00',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  ));
                                                                }




                                                                return Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: list,
                                                                );
                                                              },
                                                            ),
                                                            Image.asset('assets/images/whitetimer.png',height: 25,width: 25),
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(right: 20),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            child:   Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  child:Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpeedLeageData('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                  padding: EdgeInsets.only(right: 30),
                                                ),

                                              ],
                                            ),
                                            padding: EdgeInsets.only(top: 60),
                                          ),
                                          Padding(
                                            child:    Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(padding: EdgeInsets.only(left: 5),child:  Text('جوایز',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),),
                                                Padding(
                                                  child: Card(
                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(45),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 10,
                                                    child:Container(
                                                      width: 150,
                                                      height: 40,
                                                      color: purplecolor,
                                                      child: Center(
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: <Widget>[
                                                              Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpeedLeageData('Prize').toString()+'  '+'تومان',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 13,fontWeight: FontWeight.bold),),),

                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(left: 60),
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.only(top: 140,right: 25),
                                          ),
                                          Padding(
                                            child:   Center(
                                              child: Card(
                                                semanticContainer: true,
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(45),
                                                ),
                                                margin: EdgeInsets.all(10),
                                                elevation: 20,
                                                child:Container(
                                                  width: 160,
                                                  height: 50,
                                                  color: Green,
                                                  child: Center(
                                                      child:InkWell(
                                                        child:Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            Padding(padding: EdgeInsets.only(right: 5),child:  Text('شروع بازی',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),

                                                          ],
                                                        ),
                                                        onTap: (){
                                                          print('ThisClicked2');
                                                          print('ThisClicked2');
                                                          print('ThisClicked2');
                                                          print(TournamentData.GetSpeedLeageData('SingleState'));

                                                          StartMatch(P_width,Green,TournamentData.GetSpeedLeageData('Title'),TournamentData.GetSpeedLeageData('Icon'),TournamentData.GetSpeedLeageData('TrText'),TournamentData.GetSpeedLeageData('Prize'),'Gold',TournamentData.GetSpeedLeageData('Id'),TournamentData.GetSpeedLeageData('SingleState'));
                                                        },
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                            padding: EdgeInsets.only(top: 230),
                                          ),
                                          Padding(
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Card(
                                                      semanticContainer: true,
                                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight:  Radius.circular(80),bottomLeft:  Radius.circular(80),topRight:  Radius.circular(15)),
                                                      ),
                                                      margin: EdgeInsets.all(10),
                                                      elevation: 10,
                                                      child:Container(
                                                          width: 140,
                                                          height:160,
                                                          color: themeColor,
                                                          child:Column(
                                                            children: [
                                                              Padding(padding: EdgeInsets.only(top: 15),child:  Text(TournamentData.GetSpeedLeageData('Category'),style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                              Padding(padding: EdgeInsets.only(top: 15),child: Image.network(TournamentData.GetSpeedLeageData('Icon'),height: 100,width: 100,),
                                                              ),
                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[

                                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text(TournamentData.GetSpeedLeageData('PlayersInGame'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                                        Image.asset('assets/images/userico.png',height: 25,width: 25),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],),
                                            padding: EdgeInsets.only(top: 20,left: 25),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Center(
                                            child:  Padding(
                                              child: Image.asset('assets/images/gamebox.png',),
                                              padding: EdgeInsets.all(20),
                                            ),
                                          ),
                                          Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(top: 25),
                                                  child: Column(
                                                    children: [
                                                      Card(
                                                        semanticContainer: true,
                                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(45),
                                                        ),
                                                        margin: EdgeInsets.all(10),
                                                        elevation: 10,
                                                        child:Container(
                                                          width: 170,
                                                          height: 35,
                                                          color: Colors.white,
                                                          child: Center(
                                                              child:
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: <Widget>[
                                                                  CountdownTimer(

                                                                    controller: controller3,
                                                                    widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
                                                                      if (time == null) {
                                                                        return Text('00:00:00',style: TextStyle(color:themeColor,fontSize: 16,fontWeight: FontWeight.bold),);
                                                                      }
                                                                      List<Widget> list = [];
                                                                      if (time.sec != null) {
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text(time.sec.toString(),style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }
                                                                      list.add( Text(' : ',style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),);
                                                                      if (time.min != null) {
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text(time.min.toString(),style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }else{
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text('00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }
                                                                      list.add( Text(' : ',style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),);

                                                                      if (time.hours != null) {
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text(time.hours.toString(),style: TextStyle(color: themeColor,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }else{
                                                                        list.add(Row(
                                                                          children: <Widget>[
                                                                            Text('00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ));
                                                                      }




                                                                      return Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: list,
                                                                      );
                                                                    },
                                                                  ),
                                                                  Image.asset('assets/images/whitetimer.png',height: 25,width: 25,color: themeColor,),
                                                                ],
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Padding(padding: EdgeInsets.only(right: 5),child:  Text('بازی امروز',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),),
                                                          Padding(padding: EdgeInsets.only(right: 30),child:  Text(SetTodayPrize(int.parse(TournamentData.GetTodayOne('Prize')),int.parse(TournamentData.GetTodayTwo('Prize'))).toString()+' تومان ',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),),
                                                        ],
                                                      )
                                                    ],
                                                  ))
                                          ),

                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(top: 30),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              child:  Card(
                                                                semanticContainer: true,
                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(25),
                                                                ),
                                                                margin: EdgeInsets.all(10),
                                                                elevation: 10,
                                                                child:Container(
                                                                    width: 165,
                                                                    height:140,
                                                                    color: Colors.white,
                                                                    child:Column(
                                                                      children: [
                                                                        Stack(
                                                                          children: [
                                                                            Align(
                                                                              child: Padding(
                                                                                child: Image.asset('assets/images/trtournament.png'),
                                                                                padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                                                                              ),
                                                                              alignment: Alignment.topCenter,
                                                                            ),
                                                                            Align(
                                                                              child: Padding(
                                                                                child: Image.network(TournamentData.GetTodayOne('Icon'),height: 30,width: 30,),
                                                                                padding: EdgeInsets.only(right: 30 ,top: 15),
                                                                              ),
                                                                              alignment: Alignment.topRight,
                                                                            ),
                                                                            Align(
                                                                              child: Padding(
                                                                                child: Text(TournamentData.GetTodayOne('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 15,fontWeight: FontWeight.bold),),
                                                                                padding: EdgeInsets.only(right:35,top: 20),
                                                                              ),
                                                                              alignment: Alignment.topCenter,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Image.asset('assets/images/trprizeico.png',height: 30,width: 30,),
                                                                            Padding(
                                                                              child: Text('جوایز : ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                                                              padding: EdgeInsets.only(right: 5),
                                                                            )

                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          child:   Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(TournamentData.GetTodayOne('Prize')+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                                                            ],
                                                                          ),
                                                                          padding: EdgeInsets.only(top: 10),
                                                                        )
                                                                      ],
                                                                    )
                                                                ),
                                                              ),
                                                              onTap: (){
                                                                StartMatch(P_width,Green,TournamentData.GetTodayOne('Title'),TournamentData.GetTodayOne('Icon'),TournamentData.GetTodayOne('TrText'),TournamentData.GetTodayOne('Prize'),'Blue',TournamentData.GetTodayOne('Id'),TournamentData.GetTodayOne('SingleState'));

                                                              },
                                                            ),
                                                            InkWell(
                                                              child:  Card(
                                                                semanticContainer: true,
                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(25),
                                                                ),
                                                                margin: EdgeInsets.all(10),
                                                                elevation: 10,
                                                                child:Container(
                                                                    width: 165,
                                                                    height:140,
                                                                    color: Colors.white,
                                                                    child:Column(
                                                                      children: [
                                                                        Stack(
                                                                          children: [
                                                                            Align(
                                                                              child: Padding(
                                                                                child: Image.asset('assets/images/trtournament.png'),
                                                                                padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                                                                              ),
                                                                              alignment: Alignment.topCenter,
                                                                            ),
                                                                            Align(
                                                                              child: Padding(
                                                                                child: Image.network(TournamentData.GetTodayTwo('Icon'),height: 30,width: 30,),
                                                                                padding: EdgeInsets.only(right: 30 ,top: 20),
                                                                              ),
                                                                              alignment: Alignment.topRight,
                                                                            ),
                                                                            Align(
                                                                              child: Padding(
                                                                                child: Text(TournamentData.GetTodayTwo('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                                                                padding: EdgeInsets.only(right:35,top: 20),
                                                                              ),
                                                                              alignment: Alignment.topCenter,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Image.asset('assets/images/trprizeico.png',height: 30,width: 30,),
                                                                            Padding(
                                                                              child: Text('جوایز : ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                                                              padding: EdgeInsets.only(right: 5),
                                                                            )

                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          child:   Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(TournamentData.GetTodayTwo('Prize')+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                                                            ],
                                                                          ),
                                                                          padding: EdgeInsets.only(top: 10),
                                                                        )
                                                                      ],
                                                                    )
                                                                ),
                                                              ),
                                                              onTap: (){
                                                                StartMatch(P_width,Green,TournamentData.GetTodayTwo('Title'),TournamentData.GetTodayTwo('Icon'),TournamentData.GetTodayTwo('TrText'),TournamentData.GetTodayTwo('Prize'),'Blue',TournamentData.GetTodayTwo('Id'),TournamentData.GetTodayTwo('SingleState'));
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      )

                                                    ],
                                                  ))
                                          ),

                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Center(
                                            child:  Padding(
                                              child: Image.asset('assets/images/gamebox.png',),
                                              padding: EdgeInsets.all(20),
                                            ),
                                          ),
                                          Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(top: 65),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Padding(padding: EdgeInsets.only(right: 5),child:  Text('بازی فردا',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),),
                                                          Padding(padding: EdgeInsets.only(right: 30),child:  Text(SetTodayPrize(int.parse(TournamentData.GetTomorrowOne('Prize')),int.parse(TournamentData.GetTomorrowTwo('Prize'))).toString()+' تومان ',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),),
                                                        ],
                                                      )
                                                    ],
                                                  ))
                                          ),

                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(top: 30),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Card(
                                                              semanticContainer: true,
                                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(25),
                                                              ),
                                                              margin: EdgeInsets.all(10),
                                                              elevation: 10,
                                                              child:Container(
                                                                  width: 165,
                                                                  height:140,
                                                                  color: Colors.grey,
                                                                  child:Column(
                                                                    children: [
                                                                      Stack(
                                                                        children: [
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Image.asset('assets/images/trtournament.png'),
                                                                              padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                                                                            ),
                                                                            alignment: Alignment.topCenter,
                                                                          ),
                                                                          Align(
                                                                            child: Padding(
                                                                              child:  Image.network(TournamentData.GetTomorrowOne('Icon'),height: 30,width: 30,),
                                                                              padding: EdgeInsets.only(right: 30 ,top: 20),
                                                                            ),
                                                                            alignment: Alignment.topRight,
                                                                          ),
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Text(TournamentData.GetTomorrowOne('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                                                              padding: EdgeInsets.only(right:35,top: 20),
                                                                            ),
                                                                            alignment: Alignment.topCenter,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Image.asset('assets/images/trprizeico.png',height: 30,width: 30,),
                                                                          Padding(
                                                                            child: Text('جوایز : ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                                                            padding: EdgeInsets.only(right: 5),
                                                                          )

                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        child:   Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(TournamentData.GetTomorrowOne('Prize')+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ),
                                                                        padding: EdgeInsets.only(top: 10),
                                                                      )
                                                                    ],
                                                                  )
                                                              ),
                                                            ),
                                                            Card(
                                                              semanticContainer: true,
                                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(25),
                                                              ),
                                                              margin: EdgeInsets.all(10),
                                                              elevation: 10,
                                                              child:Container(
                                                                  width: 170,
                                                                  height:140,
                                                                  color: Colors.grey,
                                                                  child:Column(
                                                                    children: [
                                                                      Stack(
                                                                        children: [
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Image.asset('assets/images/trtournament.png'),
                                                                              padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                                                                            ),
                                                                            alignment: Alignment.topCenter,
                                                                          ),
                                                                          Align(
                                                                            child: Padding(
                                                                              child:  Image.network(TournamentData.GetTomorrowTwo('Icon'),height: 30,width: 30,),
                                                                              padding: EdgeInsets.only(right: 30 ,top: 20),
                                                                            ),
                                                                            alignment: Alignment.topRight,
                                                                          ),
                                                                          Align(
                                                                            child: Padding(
                                                                              child: Text(TournamentData.GetTomorrowTwo('Title'),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 12,fontWeight: FontWeight.bold),),
                                                                              padding: EdgeInsets.only(right:35,top: 20),
                                                                            ),
                                                                            alignment: Alignment.topCenter,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Image.asset('assets/images/trprizeico.png',height: 30,width: 30,),
                                                                          Padding(
                                                                            child: Text('جوایز : ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
                                                                            padding: EdgeInsets.only(right: 5),
                                                                          )

                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        child:   Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(TournamentData.GetTomorrowTwo('Prize')+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),
                                                                          ],
                                                                        ),
                                                                        padding: EdgeInsets.only(top: 10),
                                                                      )
                                                                    ],
                                                                  )
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ),
                      );
                    }
                  }
              ),);
          }else{
            appscaffold = Scaffold(
              body:  Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/shopback.jpg'),
                          fit: BoxFit.fill)
                  ),
                  child: Center(
                      child:Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text('تورنمت فعالی وجود ندارد.',style: TextStyle(color: Colors.white,fontSize: 20),),
                          InkWell(
                            child:  Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              ),
                              margin: EdgeInsets.all(10),
                              elevation: 10,
                              child:Container(
                                width: 180,
                                height: 60,
                                color: Green,
                                child: Center(
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text('بازگشت',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),

                                      ],
                                    )
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(widget.UIC))),(Route<dynamic> route) => false);

                            },
                          )
                        ],
                      )
                  )
              ),
            );
          }
          return snapshot.hasData ?
          new  Scaffold(body: appscaffold)  :  new Center(child: CircularProgressIndicator(),);
        });
  }
    GetTournaments() async {
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/GetActiveTournaments");
      print(response.data);
      if(response.data== 'NoTournament'){
        return false;
      }else {
        return true;
      }

    } catch (e) {
      print(e);
    }
  }
  SetTodayPrize(Prize1,Prize2){
    var result;
    result =  Prize1 + Prize2;
    return result;
  }
  StartMatch(width,Green,Title,Icon,DescText,Prize,Type,TournamentId,SingleIlimnation){
    Row TicketRow;
    var Gold='assets/images/goldentico.png';
    var Blue = 'assets/images/blueico.png';
    var Ticket = '';
    var TicketNo;
    var TicketTextColor;
    print('________________');
    print(SingleIlimnation);
    print('________________');
    print(TournamentId);
    print('________________');
    print(Type);
    if(Type == 'Blue'){
      Ticket = Blue;
      TicketNo = 'بلیط آبی';
      TicketTextColor = Colors.white;
    }else if(Type == 'Gold'){
      Ticket = Gold;
      TicketNo = 'بلیط طلایی';
      TicketTextColor = Colors.black;
    }
    if(SingleIlimnation =='True'){

      TicketRow= Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Text('ورودی',style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
         Stack(
           children: [

             Image.asset(Ticket,width: 50,height:50,),
             Padding(
               child: Text('1',style: TextStyle(color:TicketTextColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
               padding: EdgeInsets.only(left: 22,top: 12),
             )
           ],
         ),
         Text(TicketNo,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
       ],
     );

    }else{

      TicketRow = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('',style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
        ],
      );

    }
    Alert(
      context: context,
      image: Container(
        alignment: Alignment.center,
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: NetworkImage(
                  Icon,
                ), )
          ),
        ),
      ),
      title:  Title,style: AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
      ),
    ),
      desc: DescText,
      content: Column(
        children: [
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
            margin: EdgeInsets.all(10),
            elevation: 10,
            child:Container(
              width: width,
              height: 60,
              color: Colors.white60,
              child: Center(
                  child:
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 5),child:  Text(' تومان '+Prize,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),),

                        Padding(padding: EdgeInsets.only(right: 5),child:  Text('جایزه امروز ',style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 14,fontWeight: FontWeight.bold),),),

                      ],
                    ),
                  )
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10),child:TicketRow

            ,)

        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "جدول برندگان",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed:(){
            WinnersList(UserInfo.GetPhoneNumber(),TournamentId);
          },
          color: Colors.cyan,
          radius: BorderRadius.circular(10),
        ),
        DialogButton(
          child: Text(
            "شروع بازی",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed:(){
            print('KALALALALA');
            print(TournamentId);
            JoinTournament(UserInfo.GetPhoneNumber(),TournamentId,Type);
          },
          color: Green,
          radius: BorderRadius.circular(10),
        ),
      ],
    ).show();
  }
  JoinTournament(Pid,TournamentId,TicketType) async {
    print('Shapalangha');
    print(Pid);
    print(TournamentId);
    FormData formData = FormData.fromMap({
      "PlayerID":Pid,
      "Tid":TournamentId,
      "TicketType":TicketType,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/JoinTournament",data: formData);
      print(response.data);
      if(response.data== 'NotEnoghTicket'){
        Alert(
          context: context,
          type: AlertType.info,
          title: "خطا",
          desc:  'برای ورود به بلیط  نیاز داری! بلیط  رو میتونی از فروشگاه بدست بیاری',
          buttons: [
            DialogButton(
              child: Text(
                "بستن",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>  Navigator.pop(context),
              color: Colors.brown,
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
              color: Colors.green,
              radius: BorderRadius.circular(5.0),
            ),
          ],
        ).show();
      }else if(response.data == 'TournamentUnavilable'){
        Alert(
          context: context,
          type: AlertType.info,
          title: "خطا",
          desc:  'تورنمنت مورد نظر شما غیرفعال است ، لطفا تا فعال سازی دوباره تورنمنت صبر کنید.',
          buttons: [
            DialogButton(
              child: Text(
                "بستن",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>  Navigator.pop(context),
              color: Colors.brown,
              radius: BorderRadius.circular(5.0),
            ),
          ],
        ).show();
      }else if(response.data == 'AlreadyPlayed'){
        Alert(
          context: context,
          type: AlertType.info,
          title: "خطا",
          desc:  'شما در این تورنومنت شرکت کرده اید لطفا تا شروع تورنومنت بعدی صبر کنید',
          buttons: [
            DialogButton(
              child: Text(
                "بستن",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>  Navigator.pop(context),
              color: Colors.brown,
              radius: BorderRadius.circular(5.0),
            ),
          ],
        ).show();
      }

      else{
        print('__________________');
        print(response.data);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: TournamentQuestion(widget.UIC,response.data))),(Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e);
    }
  }
  WinnersList(UserId,TournamentID) async {
    List Winners;
    try {
      FormData formData = FormData.fromMap({
        "UserId":UserId,
        "TournamentId":TournamentID,
      });
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/GetWinnersList",data: formData);
      if(response.data == 'NotIn'){
        Alert(
          context: context,
          type: AlertType.info,
          title: "خطا",
          desc:  'فقط افراد حاظر در تورنومنت قادر به دیدن لیست برندگان هستند.',
          buttons: [
            DialogButton(
              child: Text(
                "بستن",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>  Navigator.pop(context),
              color: Colors.brown,
              radius: BorderRadius.circular(5.0),
            ),
          ],
        ).show();
      }else if(response.data == 'NoWinners'){
        Alert(
          context: context,
          type: AlertType.info,
          title: "خطا",
          desc:  'این تورنومنت فعلا برنده ای ندارد.',
          buttons: [
            DialogButton(
              child: Text(
                "بستن",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>  Navigator.pop(context),
              color: Colors.brown,
              radius: BorderRadius.circular(5.0),
            ),
          ],
        ).show();
      }else{

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:TrWinnerlist(response.data,widget.UIC))),(Route<dynamic> route) => false);

      }
    } catch (e) {
      print(e);
    }
  }

}