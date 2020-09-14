import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/services.dart';
import 'DrawerLayout.dart';
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
  @override
  void initState() {
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child:   Scaffold(
        key: _scaffoldKey,
        drawer: BuildDrawerLayout(context,widget.UIC),
        body: Container(
          child: new Stack(
            children: <Widget>[
              new Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/back.png'),
                        fit: BoxFit.fill)
                ),
              ),//BAC
              Align(
                child:    Column(
                  children: [
                    SingleChildScrollView(
                      child:Align(
                          alignment: Alignment.topCenter,
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 100,left: 20,right: 20),child: Container(
                                child: Stack(
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(left: 10),child:    Column(
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            Image.asset('assets/images/profile.png',),
                                            Stack(
                                              alignment: Alignment.topLeft,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(padding: EdgeInsets.only(top: 13,right: 10),child:new CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor: Colors.blue,
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(padding:EdgeInsets.only(right:100,top: 5),child: Column(
                                                  children: <Widget>[
                                                    Row(children: <Widget>[
                                                      new Text(UserInfo.GetUserName().toString(),style: TextStyle(fontSize: 20,color: Colors.purple,fontFamily: 'MyFont'),),
                                                    ],),
                                                    Padding(padding: EdgeInsets.only(top: 10),
                                                      child:Row(children: <Widget>[
                                                        Stack(
                                                          children: <Widget>[
                                                            Container(
                                                                child: Stack(
                                                                  children: <Widget>[
                                                                    Image.asset('assets/images/score.png',width:80,),
                                                                    Padding(padding: EdgeInsets.only(top: 6,right: 35),child:   Text(UserInfo.GetScoreAmount(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),)
                                                                  ],
                                                                )
                                                            ),
                                                          ],
                                                        )
                                                      ],),)
                                                  ],
                                                ),),
                                                Padding(padding: EdgeInsets.only(left: 50,top: 15),child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Image.asset('assets/images/life.png',width:80,),
                                                            Padding(padding: EdgeInsets.only(top: 6,right: 35),child:   Text(UserInfo.GetExtraLifeAmount(),style: TextStyle(color: Colors.white),),)
                                                          ],
                                                        )
                                                    ),
                                                    Container(
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Image.asset('assets/images/coin.png',width:80,),
                                                            Padding(padding: EdgeInsets.only(top: 6,right: 35),child:   Text(UserInfo.GetCoinAmount(),style: TextStyle(color: Colors.white),),)
                                                          ],
                                                        )
                                                    ),
                                                  ],
                                                ),),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),),
                                    new Align(
                                        alignment: Alignment.centerLeft,
                                        child:  Padding(padding: EdgeInsets.only(top: 20),child: Image.asset('assets/images/setting.png',width:40,),)
                                    ),

                                  ],
                                ),
                              ),),
                              Image.asset('assets/images/cup.png',height: 200,width:300,),
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
                                        onPressed: () {},
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
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(100))
                                    ),
                                    child: Image.asset('assets/images/anuncment.png'),
                                  ),

                                  Center(
                                    child:Column(
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(top: 5),child: Text('تا نزدیک ترین  مسابقه جایزه بزرگ',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold,color: Colors.yellow),),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('14',style: TextStyle(color:  Colors.white,fontSize: 25,fontFamily: 'MyFont'),),
                                            Text(':',style: TextStyle(color:  Colors.white,fontSize: 25,fontFamily: 'MyFont'),),
                                            Text('2',style: TextStyle(color:  Colors.white,fontSize: 25,fontFamily: 'MyFont'),),
                                            Text(':',style: TextStyle(color:  Colors.white,fontSize: 25,fontFamily: 'MyFont'),),
                                            Text('17',style: TextStyle(color:  Colors.white,fontSize: 25,fontFamily: 'MyFont'),),
                                            Text(':',style: TextStyle(color:  Colors.white,fontSize: 25,fontFamily: 'MyFont'),),
                                            Text('0',style: TextStyle(color:  Colors.white,fontSize: 25,fontFamily: 'MyFont'),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('ثانیه',style: TextStyle(color:  Colors.white,fontSize: 22,fontFamily: 'MyFont'),),
                                            Text('',style: TextStyle(color:  Colors.white,fontSize: 22,fontFamily: 'MyFont'),),
                                            Text('دقیقه',style: TextStyle(color:  Colors.white,fontSize: 22,fontFamily: 'MyFont'),),
                                            Text('',style: TextStyle(color:  Colors.white,fontSize: 22,fontFamily: 'MyFont'),),
                                            Text('ساعت',style: TextStyle(color:  Colors.white,fontSize: 22,fontFamily: 'MyFont'),),
                                            Text('',style: TextStyle(color:  Colors.white,fontSize: 22,fontFamily: 'MyFont'),),
                                            Text('روز',style: TextStyle(color:  Colors.white,fontSize: 22,fontFamily: 'MyFont'),),
                                          ],
                                        )
                                      ],
                                    ),

                                  )
                                ],
                              ),),
                              Padding(padding: EdgeInsets.only(top: 10),child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                ],
                              ),),
                              Padding(padding: EdgeInsets.only(top: 10),child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        new Card(
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
                                                new Text('شروع بازی',style:TextStyle(fontSize: 28,color: Colors.white,fontFamily: 'MyFont'),),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),)
                            ],
                          )
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.topCenter,

              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:Image.asset('assets/images/navmenu.png'),
              ),//PROFILE BACK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 3,right: 25),child: Image.asset('assets/images/friendico.png',width:40 ,height: 40,),),
                      Padding(padding: EdgeInsets.only(bottom: 5,right: 25),child: Image.asset('assets/images/Surveyico.png',width:40 ,height: 40,),),
                      Padding(padding: EdgeInsets.only(bottom: 5,right: 25),child: Image.asset('assets/images/teachico.png',width:40 ,height: 40,),),
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
                      Padding(padding: EdgeInsets.only(bottom: 3,left: 25),child: Image.asset('assets/images/talentico.png',width:40 ,height: 40,),),
                      Padding(padding: EdgeInsets.only(bottom: 5,left: 25),child: Image.asset('assets/images/shopico.png',width:40 ,height: 40,),),
                      Padding(padding: EdgeInsets.only(bottom: 5,left: 25),child: Image.asset('assets/images/groupgame.png',width:40 ,height: 40,),),
                    ],
                  ),
                ),
              ],),
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
          ),
        )

    ),
        onWillPop: () => Future(() => false));
  }
}

