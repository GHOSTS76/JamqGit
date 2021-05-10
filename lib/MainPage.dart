import 'dart:ui';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jamqpwa/LiveMain.dart';
import 'package:jamqpwa/OneVsOneMatchPage.dart';
import 'package:jamqpwa/Profile.dart';
import 'package:jamqpwa/Shop.dart';
import 'package:jamqpwa/TournamentMain.dart';
import 'package:jamqpwa/TournamentNextQuestion.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'DrawerLayout.dart';
import 'OneVsOneMatchMainPage.dart';
import 'SelectOpponent.dart';
import 'UserInfoClass.dart';

double height;
const ButtonColor = Color.fromRGBO(39, 51, 109, 1);
class MainPage extends StatefulWidget{
  var UIC;
  MainPage(this.UIC);
  MainPage.none();
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return MainPageState();
  }

}


class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserInfoClass UserInfo ;
  Socket socket;
  List ActiveGamesList;
  var runsocket = 0;
  var pink = Color.fromRGBO(249, 211, 248, 1);
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  Future loadfuture;
  @override
  void initState() {

    UserInfo = new UserInfoClass(widget.UIC);
   loadfuture = GetActiveGames();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    ConnectSocket();
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.4;
    return new FutureBuilder(
      future:loadfuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData ?  new Scaffold(
          body: Scaffold(
            key: _scaffoldKey,
            drawer: BuildDrawerLayout(context,widget.UIC),
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
                    return new  Stack(
                      children: <Widget>[
                        new Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/mainbackland.jpg'),
                                  fit: BoxFit.fill)
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 100),child: SingleChildScrollView(
                            child:Column(
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              child:  Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          child:  InkWell(
                                                            child: CircleAvatar(radius: 35, backgroundImage: NetworkImage(UserInfo.GetProiflePic()),),
                                                            onTap: (){
                                                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: profile(widget.UIC))),(Route<dynamic> route) => false);
                                                            },
                                                          ),
                                                          padding: EdgeInsets.only(right: 10),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                new Text(UserInfo.GetUserName(),style: TextStyle(fontSize: 20,color: Colors.purple,fontFamily: 'MyFont'),),
                                                              ],
                                                            ),

                                                            Row(
                                                              children: [
                                                                Stack(
                                                                  children: <Widget>[
                                                                    Image.asset('assets/images/blueticketmain.png',width:80,),
                                                                    Padding(padding: EdgeInsets.only(top: 2,right: 50),child:   Text(UserInfo.GetBlueTicket().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),)
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Stack(
                                                                  children: <Widget>[
                                                                    Image.asset('assets/images/score.png',width:70,),
                                                                    Padding(padding: EdgeInsets.only(top: 2,right: 35),child:Text(UserInfo.GetScoreAmount().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),)
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10,left: 15),
                                                              child:  Row(
                                                                children: [
                                                                  Stack(
                                                                    children: <Widget>[
                                                                      Image.asset('assets/images/goldenticketmain.png',width:80,),
                                                                      Padding(padding: EdgeInsets.only(top: 2,right: 50),child:Text(UserInfo.GetGoldenTicket().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),)
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Stack(
                                                                    children: <Widget>[
                                                                      Image.asset('assets/images/life.png',width:80,),
                                                                      Padding(padding: EdgeInsets.only(top: 5,right: 40),child:   Text(UserInfo.GetExtraLifeAmount().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),)
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Stack(
                                                                    children: <Widget>[
                                                                      Image.asset('assets/images/coin.png',width:80,),
                                                                      Padding(padding: EdgeInsets.only(top: 5,right: 40),child:   Text(UserInfo.GetCoinAmount().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),)
                                                                    ],
                                                                  )
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                          Image.asset('assets/images/setting.png',height: 45,width: 45,),
                                                        ],
                                                      ),
                                                      padding: EdgeInsets.only(bottom: 20,right:10),
                                                    )
                                                  ],
                                                ),
                                                width: 400,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('assets/images/profile.png'),
                                                        fit: BoxFit.fitWidth
                                                    )
                                                ),
                                              ),
                                              padding: EdgeInsets.only(top:100),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Image.asset('assets/images/applogo.png',height: 200,width:200,),
                                Padding(padding: EdgeInsets.only(top: 10,left: 15,right: 15),child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        AnimatedButton(
                                          height: 80,
                                          width: 80,
                                          color: Colors.white,
                                          child:   Image.asset('assets/images/rankico.png',width: 40,height: 40,),
                                          onPressed: () {},
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10),child: Text('رنکینگ',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.white),),)
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        AnimatedButton(
                                          height: 80,
                                          width: 80,
                                          color: Colors.white,
                                          child:   Image.asset('assets/images/tournementico.png',width: 40,height: 40,),
                                          onPressed: () {
                                            GetTournaments();
                                          },
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10),child: Text('تورنمنت',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.white),),)
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        AnimatedButton(
                                          height: 80,
                                          width: 80,
                                          color: Colors.white,
                                          child:   Image.asset('assets/images/newsico.png',width: 40,height: 40,),
                                          onPressed: () {},
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10),child: Text('اخبار',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.white),),)
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        AnimatedButton(
                                          height: 80,
                                          width: 80,
                                          color: Colors.white,
                                          child:   Image.asset('assets/images/cupico.png',width: 40,height: 40,),
                                          onPressed: () {},
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10),child: Text('جام',style: TextStyle(fontSize: 20,fontFamily: 'MyFont',color: Colors.white),),)
                                      ],
                                    ),
                                  ],
                                ),),
                                Padding(padding:EdgeInsets.only(top: 10,left: 10,right: 10),child: Stack(
                                  children: <Widget>[
                                    InkWell(
                                      child:  Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('assets/images/anuncment.png',),
                                                fit: BoxFit.fill)
                                        ),
                                        width:c_width,
                                        child:Center(
                                          child:Column  (
                                            children: <Widget>[
                                              Padding(padding: EdgeInsets.only(top: 100),child: Text('تا نزدیک ترین  مسابقه جایزه بزرگ',style: TextStyle(fontFamily: 'Lalezar',fontSize: 20,color: Colors.yellow),),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('0',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                  Padding(padding: EdgeInsets.only(left:20,right:20),child: Text(':',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                  Text('0',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                  Padding(padding: EdgeInsets.only(left:20,right:20),child: Text(':',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                  Text('0',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                  Padding(padding: EdgeInsets.only(left:20,right:20),child: Text(':',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                  Text('0',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),

                                                ],
                                              ),
                                              Padding(padding:EdgeInsets.only(left:20),child:  Row(
                                                mainAxisAlignment: MainAxisAlignment.end,

                                                children: [
                                                  Padding(padding:EdgeInsets.only(right:30),child:Image.asset('assets/images/liveico.png',width: 35,height: 35,),),
                                                ],),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('ثانیه',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                  Padding(padding: EdgeInsets.only(left:10,right:10),child: Text('',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                  Text('دقیقه',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                  Padding(padding: EdgeInsets.only(left:10,right:10),child: Text('',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                  Text('ساعت',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                  Padding(padding: EdgeInsets.only(left:10,right:10),child: Text('',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                  Text('روز',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        height: 300
                                        ,
                                      ),
                                      onTap: (){
                                       // SendLiveRequest(UserInfo.GetPhoneNumber());
                                        Fluttertoast.showToast(
                                            msg: "برای بازی کردن لایو لطفا نسخه اندروید و یا ای او اس را نصب کنید .",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.yellowAccent,
                                            textColor: Colors.black,
                                            fontSize: 16.0
                                        );
                                      },
                                    )
                                  ],
                                ),),
                                Padding(padding: EdgeInsets.only(bottom: 80),child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          InkWell(
                                            child:new Card(
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
                                                width: 200,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:Color.fromRGBO(1, 38, 106, 1),
                                                    ),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [Color.fromRGBO(4, 185, 204, 1),Color.fromRGBO(1, 38, 106, 1), ],
                                                    )
                                                ),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    new Text('شروع بازی',style:TextStyle(fontSize: 28,color: Colors.white,fontFamily: 'Lalezar',),),
                                                  ],
                                                ),
                                              ),

                                            ),
                                            onTap: (){
                                              Fluttertoast.showToast(
                                                  msg: "!!!!!!!!بزودی",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.yellowAccent,
                                                  textColor: Colors.black,
                                                  fontSize: 16.0
                                              );
                                          //    _openLoadingDialog(context);
                                           //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:SelectOpponent(widget.UIC))),(Route<dynamic> route) => false);
                                            },
                                          )

                                        ],
                                      ),

                                    ]),),
                              ],
                            )
                        ),),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child:Image.asset('assets/images/downmenuland.png',width: width,),
                        ),//PROFILE BACK
                        Align(
                          alignment: Alignment.bottomCenter,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(bottom: 3,right:100,left:60),child: Image.asset('assets/images/friendico.png',width:60 ,height: 60,),),
                              Padding(padding: EdgeInsets.only(bottom: 5,right: 25,left:60),child: Image.asset('assets/images/Surveyico.png',width:60 ,height:60,),),
                              Padding(padding: EdgeInsets.only(bottom: 5,right: 25,left:60),child: Image.asset('assets/images/teachico.png',width:60 ,height: 60,),),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child:Padding(padding:EdgeInsets.only(bottom: 10),child: Image.asset('assets/images/homeico.png',width:200 ,height: 200,),),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(bottom: 3,left: 25,right:60),child: Image.asset('assets/images/talentico.png',width:60 ,height: 60,),),
                              InkWell(
                                child: Padding(padding: EdgeInsets.only(bottom: 5,left: 25,right:60),child: Image.asset('assets/images/shopico.png',width:60 ,height: 60,),),
                                onTap: (){
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:Shop(widget.UIC))),(Route<dynamic> route) => false);

                                },
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5,left: 100),child: Image.asset('assets/images/groupgame.png',width:60 ,height: 60,),),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child:Padding(padding:EdgeInsets.only(right: 10,top: 45),child: InkWell(
                            child: Image.asset('assets/images/drawer.png',width:40 ,height: 40,),
                            onTap: (){
                              _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return new Center(
                      child: Stack(
                        children: <Widget>[
                          new Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/mainbackport.jpg'),
                                    fit: BoxFit.fill)
                            ),
                          ),
                          SingleChildScrollView(
                              child:Column(
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                child:  Container(
                                                  
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              child:  InkWell(
                                                                child: CircleAvatar(radius: 30, backgroundImage: NetworkImage(UserInfo.GetProiflePic()),),
                                                                onTap: (){
                                                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: profile(widget.UIC))),(Route<dynamic> route) => false);
                                                                },
                                                              ),
                                                              padding: EdgeInsets.only(right: 10),
                                                            ),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    new Text(UserInfo.GetUserName(),style: TextStyle(fontSize: 16,color: Colors.purple,fontFamily: 'MyFont'),),
                                                                  ],
                                                                ),

                                                                Row(
                                                                  children: [
                                                                    Stack(
                                                                      children: <Widget>[
                                                                        Image.asset('assets/images/blueticketmain.png',width:70,),
                                                                        Padding(padding: EdgeInsets.only(right: 40),child:   Text(UserInfo.GetBlueTicket().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 14),),)
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Stack(
                                                                      children: <Widget>[
                                                                        Image.asset('assets/images/score.png',width:70,),
                                                                        Padding(padding: EdgeInsets.only(top:2,right: 40),child:Text(UserInfo.GetScoreAmount().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 14),),)
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(top: 5,left: 15),
                                                                  child:  Row(
                                                                    children: [
                                                                      Stack(
                                                                        children: <Widget>[
                                                                          Image.asset('assets/images/goldenticketmain.png',width:75,),
                                                                          Padding(padding: EdgeInsets.only(right: 40),child:Text(UserInfo.GetGoldenTicket().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 14),),)
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          child: Row(
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Stack(
                                                                        children: <Widget>[
                                                                          Image.asset('assets/images/life.png',width:70,),
                                                                          Padding(padding: EdgeInsets.only(top:3,right: 40),child:   Text(UserInfo.GetExtraLifeAmount().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 13),),)
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Stack(
                                                                        children: <Widget>[
                                                                          Image.asset('assets/images/coin.png',width:70,),
                                                                          Padding(padding: EdgeInsets.only(top: 3,right: 40),child:   Text(UserInfo.GetCoinAmount().toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),)
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),

                                                                ],
                                                              ),
                                                              Image.asset('assets/images/setting.png',height: 45,width: 45,),
                                                            ],
                                                          ),
                                                          padding: EdgeInsets.only(bottom: 20,right:10),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  width: 370,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage('assets/images/profile.png'),
                                                          fit: BoxFit.fitWidth
                                                      )
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(top:100),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Image.asset('assets/images/applogo.png',height: 200,width:200,),
                                  Padding(padding: EdgeInsets.only(top: 10,left: 15,right: 15),child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          AnimatedButton(
                                            height: 80,
                                            width: 80,
                                            color: Colors.white,
                                            child:   Image.asset('assets/images/rankico.png',width: 40,height: 40,),
                                            onPressed: () {},
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10),child: Text('رنکینگ',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.white),),)
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          AnimatedButton(
                                            height: 80,
                                            width: 80,
                                            color: Colors.white,

                                            child:   Image.asset('assets/images/tournementico.png',width: 40,height: 40,),
                                            onPressed: () {
                                              GetTournaments();
                                            },
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10),child: Text('تورنمنت',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.white),),)
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          AnimatedButton(
                                            height: 80,
                                            width: 80,
                                            color: Colors.white,
                                            child:   Image.asset('assets/images/newsico.png',width: 40,height: 40,),
                                            onPressed: () {},
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10),child: Text('اخبار',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.white),),)
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          AnimatedButton(
                                            height: 80,
                                            width: 80,
                                            color: Colors.white,
                                            child:   Image.asset('assets/images/cupico.png',width: 40,height: 40,),
                                            onPressed: () {},
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10),child: Text('جام',style: TextStyle(fontSize: 20,fontFamily: 'MyFont',color: Colors.white),),)
                                        ],
                                      ),
                                    ],
                                  ),),
                                  Padding(padding:EdgeInsets.only(top: 10,left: 10,right: 10),child: Stack(
                                    children: <Widget>[
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage('assets/images/anuncment.png'),
                                                  fit: BoxFit.fill)
                                          ),
                                          child:Center(
                                            child:Column  (
                                              children: <Widget>[
                                                Padding(padding: EdgeInsets.only(top: 70),child: Text('تا نزدیک ترین  مسابقه جایزه بزرگ',style: TextStyle(fontFamily: 'Lalezar',fontSize: 20,color: Colors.yellow),),),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text('0',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                    Padding(padding: EdgeInsets.only(left:20,right:20),child: Text(':',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                    Text('0',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                    Padding(padding: EdgeInsets.only(left:20,right:20),child: Text(':',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                    Text('0',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                    Padding(padding: EdgeInsets.only(left:20,right:20),child: Text(':',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                    Text('0',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),

                                                  ],
                                                ),
                                                Padding(padding:EdgeInsets.only(left:20),child:  Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Padding(padding:EdgeInsets.only(right:30),child:Image.asset('assets/images/liveico.png',width: 35,height: 35,),),
                                                  ],),),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text('ثانیه',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                    Padding(padding: EdgeInsets.only(left:10,right:10),child: Text('',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                    Text('دقیقه',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                    Padding(padding: EdgeInsets.only(left:10,right:10),child: Text('',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                    Text('ساعت',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                    Padding(padding: EdgeInsets.only(left:10,right:10),child: Text('',style: TextStyle(color:  Colors.white,fontSize: 18,fontFamily: 'MyFont'),),),
                                                    Text('روز',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'MyFont'),),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          width:width,
                                          height: 250,
                                        ),
                                        onTap: (){
                                         // SendLiveRequest(UserInfo.GetPhoneNumber());
                                          Fluttertoast.showToast(
                                              msg: "برای بازی کردن لایو لطفا نسخه اندروید و یا ای او اس را نصب کنید .",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.yellowAccent,
                                              textColor: Colors.black,
                                              fontSize: 16.0
                                          );
                                        },
                                      )
                                    ],
                                  ),),
                                  Padding(padding: EdgeInsets.only(bottom: 80),child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            InkWell(
                                              child: new Card(
                                                semanticContainer: true,
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                ),
                                                margin: EdgeInsets.all(10),
                                                elevation: 5,
                                                child: Container(
                                                  height: 70,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:Color.fromRGBO(1, 38, 106, 1),
                                                      ),
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                        colors: [Color.fromRGBO(4, 185, 204, 1),Color.fromRGBO(1, 38, 106, 1), ],
                                                      )
                                                  ),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      new Text('شروع بازی',style:TextStyle(fontSize: 28,color: Colors.white,fontFamily: 'Lalezar',),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onTap: (){
                                                Fluttertoast.showToast(
                                                    msg: "بزودی!!!!!.",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.yellowAccent,
                                                    textColor: Colors.black,
                                                    fontSize: 16.0
                                                );
                                           //     _openLoadingDialog(context);
                                           //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:SelectOpponent(widget.UIC))),(Route<dynamic> route) => false);
                                              },
                                            )
                                          ],
                                        ),

                                      ]),),

                                ],
                              )
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:Image.asset('assets/images/navmenu.png'),
                          ),//PROFILE BACK
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(bottom: 3,right: 25),child: Image.asset('assets/images/friendico.png',width:30 ,height: 30,),),
                                Padding(padding: EdgeInsets.only(bottom: 10,right: 25),child: Image.asset('assets/images/Surveyico.png',width:30 ,height: 30,),),
                                Padding(padding: EdgeInsets.only(bottom: 10,right: 25),child: Image.asset('assets/images/teachico.png',width:30 ,height: 30,),),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:Padding(padding:EdgeInsets.only(bottom: 10),child: Image.asset('assets/images/homeico.png',width:70 ,height: 70,),),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(bottom: 3,right: 25),child: Image.asset('assets/images/talentico.png',width:30 ,height: 30,),),
                                InkWell(
                                  child: Padding(padding: EdgeInsets.only(bottom:10,right:25),child: Image.asset('assets/images/shopico.png',width:30 ,height: 30,),),
                                  onTap: (){
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:Shop(widget.UIC))),(Route<dynamic> route) => false);
                                  },
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10,right: 25,left:20),child: Image.asset('assets/images/groupgame.png',width:30 ,height: 30,),),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child:Padding(padding:EdgeInsets.only(right: 20,top: 45),child: InkWell(
                              child: Image.asset('assets/images/drawer.png',width:40 ,height: 40,),
                              onTap: (){
                                _scaffoldKey.currentState.openDrawer();
                              },
                            ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
            ),

          ),
        ) : new Center(child: CircularProgressIndicator(),);
      },
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
  GetActiveGames() async {
    //FormData formData = FormData.fromMap({
   //   "PlayerId": UserInfo.GetPhoneNumber(),
   // });
  //  try {
  //    Response response = await Dio().post("http://jamq.ir:3000/onevsonematches/GetOneVOneByState",data:formData);
  //    ActiveGamesList = response.data;
    //  print('--------------------------');
    //  print(ActiveGamesList);
   //   print('--------------------------');
   //   return true;
   // } catch (e) {
  //    print(e);
 //   }
    return true;
 }

  GetTournaments() async {
    print('Clicked!!!!!!!!!!!!!!!!!!!');  
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/GetActiveTournaments");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:TournamentMain(widget.UIC,response.data))),(Route<dynamic> route) => false);

    } catch (e) {
      print(e);
    }
  }

  ConnectSocket() async {
    if(runsocket == 0) {
      socket = io('http://jamq.ir:3000/', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false, // optional
      });
      socket.connect();
      socket.on('connect', (_) {
        print(socket.id);
        Live();
        runsocket = 1;
        print(runsocket.toString());
      });
    }
  }
  SendLiveRequest(PId){

    socket.emit('JoinGame', [PId]);

  }
  Live(){
    socket.on('LiveState', (data) async =>

        LivePage(data)

    );
  }
  LivePage(data) async  {
      if(data =='NoLive'){
      Fluttertoast.showToast(
          msg: "مسابقه هنوز اماده نیست.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.yellowAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }else if(data == 'ReachMaxPlayers'){
      Fluttertoast.showToast(
          msg: "تعداد بازیکنا به حداکثر رسیده تو لایو بعدی میبینمت",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(data == 'Lose'){
      Fluttertoast.showToast(
          msg: "این لایو رو باختی ، تو لایو بعدی میبینمت",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      socket.emit('SubmitId',UserInfo.GetPhoneNumber());
      socket.disconnect();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: LiveMain(data,UserInfo.GetPhoneNumber(),widget.UIC))),(Route<dynamic> route) => false);
    }

  }
  TransferToGame(MatchID){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: OneVsOneMatch(MatchID,widget.UIC))),(Route<dynamic> route) => false);

  }
  setGameResult(YourScore,OpScore){
    var Result = ' امتیاز حریف : '+OpScore.toString()+'  امتیاز شما : '+  YourScore.toString();
    return Result;
  }
  setGameState(State){
    var result;
    switch(State){
      case 0 :
        result  ='حریفی تعیین نشده';
        break;

      case 1 :
        result  = 'در حال بازی!';
        break;

      case 2 :
        result  = 'بازی به اتمام رسیده!';
        break ;
    }
    print('==============');
    print(result);
    return result;
  }

  setion(State){
    var result;
    var ingameicon = 'assets/images/ingameicon.png';
    var endtimeicon = 'assets/images/endtimeicon.png';
    switch(State){

      case 0 :
        result =ingameicon;
        break;
      case 1:

        result =ingameicon;
        break;

      case 2:
        result =endtimeicon;
        break;
    }
    return result;
  }
  Setname(Name){
    var result;
    if(Name == 'NotDefiend'){
      result = 'حریف   شانسی';
    }else{
      result = Name;
    }
    return result;
  }
}

