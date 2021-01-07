import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:jamqpwa/TournamentSetterClass.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'MainPage.dart';

class TournamentMain extends StatefulWidget{
  var UIC;
  TournamentMain(this.UIC);
  TournamentMain.none();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TournamentMainState();
  }

}
class TournamentMainState extends State<TournamentMain>{
  var   selectedColor = Color.fromRGBO(80, 0, 131, 1);
  TournamentSetter TournamentData;

  Future loadfuture;
  var   UnselectedColor = Colors.white;
  CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch  * 13200 ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('EndTime');
    print(endTime);
    print(DateTime.now().toString());

    controller = CountdownTimerController(endTime: endTime, onEnd: (){print('Ended'); });
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


    // TODO: implement build
    return FutureBuilder(
        future:loadfuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var appscaffold;
          if(snapshot.data == true){
            appscaffold = Scaffold(
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

                                                      controller: controller,
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
                                                        }
                                                        list.add( Text(' : ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),);

                                                        if (time.hours != null) {
                                                          list.add(Row(
                                                            children: <Widget>[
                                                              Text(time.hours.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                          Alert(
                                            context: context,
                                            image: CircleAvatar(
                                              backgroundImage:  AssetImage('assets/images/profback.png'),
                                              radius: 70,
                                            ),
                                            title: "لیگ ویژه",style: AlertStyle(
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
                                            desc: 'این یک متن تستی برای تست متن تورنمنت میباشد و فاقد هرگونه ارزش مادی و معنوی دیگری میباشد',
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
                                                    width: P_width,
                                                    height: 60,
                                                    color: Colors.white60,
                                                    child: Center(
                                                        child:
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10,right: 10),
                                                          child:   Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: <Widget>[
                                                              Padding(padding: EdgeInsets.only(right: 5),child:  Text(' تومان '+'500000' ,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),

                                                              Padding(padding: EdgeInsets.only(right: 5),child:  Text('جایزه امروز ',style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),

                                                            ],
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Padding(padding: EdgeInsets.only(top: 10),child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('ورودی',style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
                                                    Stack(
                                                      children: [

                                                        Image.asset('assets/images/goldentico.png',width: 50,height:50,),
                                                        Padding(
                                                          child: Text('1',style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
                                                          padding: EdgeInsets.only(left: 22,top: 12),
                                                        )
                                                      ],
                                                    ),
                                                    Text('بلیط طلایی',style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
                                                  ],
                                                ),)
                                              ],
                                            ),
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "جدول برندگان",
                                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                                ),
                                                onPressed:(){
                                                  Navigator.pop(context);
                                                },
                                                color: Colors.cyan,
                                                radius: BorderRadius.circular(10),
                                              ),
                                              DialogButton(
                                                child: Text(
                                                  "شروع بازی",
                                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                                ),
                                                onPressed:(){
                                                  Navigator.pop(context);
                                                },
                                                color: Green,
                                                radius: BorderRadius.circular(10),
                                              ),
                                            ],
                                          ).show();
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
                                                  Padding(padding: EdgeInsets.only(right: 5),child:  Text('4  :  23  :  13',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
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
                                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text('4  :  23  :  13',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
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
                                                Padding(padding: EdgeInsets.only(right: 30),child:  Text('1,000,000'+' تومان ',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),
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
                                                                  child: Image.asset('assets/images/artico.png',height: 50,width: 50,),
                                                                  padding: EdgeInsets.only(right: 25 ,top: 15),
                                                                ),
                                                                alignment: Alignment.topRight,
                                                              ),
                                                              Align(
                                                                child: Padding(
                                                                  child: Text('هنر',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                  padding: EdgeInsets.only(right:30,top: 25),
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
                                                                Text('1000000'+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
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
                                                                  child: Image.asset('assets/images/artico.png',height: 50,width: 50,),
                                                                  padding: EdgeInsets.only(right: 25 ,top: 15),
                                                                ),
                                                                alignment: Alignment.topRight,
                                                              ),
                                                              Align(
                                                                child: Padding(
                                                                  child: Text('هنر',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                  padding: EdgeInsets.only(right:30,top: 25),
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
                                                                Text('1000000'+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
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
                                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text('4  :  23  :  13',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                                        Image.asset('assets/images/whitetimer.png',height: 25,width: 25,color: themeColor,),
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(padding: EdgeInsets.only(right: 5),child:  Text('بازی فردا',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),
                                                Padding(padding: EdgeInsets.only(right: 30),child:  Text('1,000,000'+' تومان ',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),),
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
                                                                  child: Image.asset('assets/images/artico.png',height: 50,width: 50,),
                                                                  padding: EdgeInsets.only(right: 25 ,top: 15),
                                                                ),
                                                                alignment: Alignment.topRight,
                                                              ),
                                                              Align(
                                                                child: Padding(
                                                                  child: Text('هنر',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                  padding: EdgeInsets.only(right:30,top: 25),
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
                                                                Text('1000000'+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
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
                                                                  child: Image.asset('assets/images/artico.png',height: 50,width: 50,),
                                                                  padding: EdgeInsets.only(right: 25 ,top: 15),
                                                                ),
                                                                alignment: Alignment.topRight,
                                                              ),
                                                              Align(
                                                                child: Padding(
                                                                  child: Text('هنر',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                                                  padding: EdgeInsets.only(right:30,top: 25),
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
                                                                Text('1000000'+'   تومان ',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
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
          new  Scaffold(body: appscaffold,)  :  new Center(child: CircularProgressIndicator(),);
        });

  }

  GetTournaments() async {
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/GetActiveTournaments");
      print(response.data);
      if(response.data== 'NoTournament'){
        return false;
      }else {
        TournamentData = new TournamentSetter(response.data);
      }
      return true;
    } catch (e) {
      print(e);
    }
  }

  SetTimer(){

  }

}