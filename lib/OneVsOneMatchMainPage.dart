import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jamqpwa/AboutUs.dart';
import 'package:jamqpwa/MainPage.dart';
import 'package:jamqpwa/SendTicket.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import 'Category.dart';
import 'OneVsOneMatchPage.dart';
import 'UserInfoClass.dart';

class OneVsOneMatch extends StatefulWidget{
  var UIC,MatchId;

  OneVsOneMatch(this.MatchId,this.UIC);

  OneVsOneMatch.none();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OneVsOneMatchState();
  }

}
class OneVsOneMatchState extends State<OneVsOneMatch> with SingleTickerProviderStateMixin{
  UserInfoClass UserInfo ;
  var OpName,OPScore,SelfScore;
  Future loadfuture;
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  static TabController tabController;
  var _currentSelection = 0;
  Map<int, Widget> _children = {
      0:Container(height: 20,width: 130,child: Center(child: Text('مسابقه',style: TextStyle(color: Colors.white),),),),
      1:Container(height: 20,width: 130,child:Center(child:  Text('گفتگو',style: TextStyle(color: Colors.white),),)),
  };
  List data;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.4;
    double c_height = MediaQuery.of(context).size.height*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double P_height = MediaQuery.of(context).size.height*0.8;
    print(widget.MatchId);
     return  new FutureBuilder(
      future:loadfuture ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        return snapshot.hasData ?  new  Scaffold(
          body:  LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
                  return Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/searchico.png',width: 50,height: 50,),
                            new Text('در حال جستجوی حریف...',style: TextStyle(fontSize: 26 ,color: Colors.white,fontFamily: 'MyFont'),),
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/selectopland.jpg'),
                            fit: BoxFit.fill)
                    ),
                  );
                } else {
                  return Container(
                    child:  Stack(
                      children: [
                         Column(
                          children: <Widget>[
                            Align(
                              child:Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight:  Radius.circular(15),bottomLeft:  Radius.circular(60),topRight:  Radius.circular(60)),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  elevation: 5,
                                  child:  Container(
                                    height: 220,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: themeColor,
                                                    fontFamily: 'MyFont'
                                                ),
                                              ),
                                              Text(
                                                'مسابقه تک به تک',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: themeColor,
                                                    fontFamily: 'MyFont'
                                                ),
                                              ),
                                              Padding(
                                                child:  InkWell(
                                                  child:Image.asset('assets/images/backico.png',height: 25,width: 25,color: themeColor,),
                                                  onTap: (){
                                                    RefreshData(UserInfo.GetPhoneNumber());                                                  },
                                                ),
                                                padding: EdgeInsets.only(left: 10),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(padding: EdgeInsets.only(top: 10),child:
                                                  Card(
                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 5,
                                                    child:Container(

                                                      child: Center(
                                                        child:
                                                        Text(OpName,style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16),),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            colors: [purplecolor,themeColor],
                                                          )
                                                      ),
                                                      width: 120,
                                                      height: 50,
                                                    ),
                                                  ),),
                                                  Container(
                                                    child: Center(
                                                      child: Text(OPScore.toString(),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red,
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: [Color.fromRGBO(255, 214, 15, 1),Color.fromRGBO(255, 155, 0, 1), ],
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Align(
                                                child:Image.asset('assets/images/onevone.png',height:150,width: 150 ),
                                                alignment: Alignment.center,
                                              ),

                                              Column(
                                                children: [
                                                  Padding(padding: EdgeInsets.only(top: 10),child: Card(
                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 5,
                                                    child:Container(

                                                      child: Center(
                                                        child:
                                                        Text(UserInfo.GetName()+ ' '+ UserInfo.GetFamily(),style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16),),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            colors: [purplecolor,themeColor],
                                                          )
                                                      ),
                                                      width: 120,
                                                      height: 50,
                                                    ),
                                                  ),),
                                                  Container(
                                                    child: Center(
                                                      child: Text(SelfScore.toString(),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red,
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: [Color.fromRGBO(255, 214, 15, 1),Color.fromRGBO(255, 155, 0, 1), ],
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              alignment: Alignment.topCenter,
                            ),
                           Padding(
                             padding: EdgeInsets.only(bottom: 10),
                             child:  Container(
                             child: MaterialSegmentedControl(
                               horizontalPadding: EdgeInsets.all(1),
                               verticalOffset: 15,
                               selectionIndex: _currentSelection,
                               borderColor: Colors.transparent,
                               selectedColor:Colors.cyan ,
                               unselectedColor:  purplecolor,
                               borderRadius: 30.0,
                               children: _children,
                               onSegmentChosen: (index) {
                                 setState(() {
                                   _currentSelection = index;
                                   tabController.index = index;
                                 });
                               },),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(30)),
                                 border: Border.all(color: Colors.white,width: 3)
                             ),
                           ),
                           ),
                            Expanded(
                              child: new TabBarView(
                                  controller: tabController,
                                  children: <Widget>[
                                    new  OneVOneMatchPage(widget.MatchId,widget.UIC),
                                    new SendTicket.none()
                                  ]),),
                            Align(
                              child:InkWell(
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight:  Radius.circular(50),bottomLeft:  Radius.circular(50),topRight:  Radius.circular(50)),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  elevation: 5,
                                  child: InkWell(
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
                                           colors: [Color.fromRGBO(4, 185, 204, 1),Color.fromRGBO(1, 38, 106, 1),],
                                         )
                                     ),
                                     child:Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: <Widget>[
                                         new Text('شروع بازی',style:TextStyle(fontSize: 28,color: Colors.white,fontFamily: 'Lalezar',),),
                                       ],
                                     ),
                                   ),
                                  )
                                ),
                                onTap: (){
                                  StartRound(widget.MatchId,UserInfo.GetPhoneNumber());
                                },
                              ),
                              alignment: Alignment.bottomCenter,
                            )
                          ],
                        ),

                      ],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/selectopport.jpg'),
                            fit: BoxFit.fill)
                    ),
                  );
                }
              }
          ),
        ) : new Center(child: CircularProgressIndicator(),);
      },
    );
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    UserInfo = new UserInfoClass(widget.UIC);
    loadfuture = GetMatchData(widget.MatchId,UserInfo.GetPhoneNumber());
  }

  MatchSetter(){

  }

  StartRound(MatchId,UserId) async {
    FormData formData = FormData.fromMap({
      "MatchId":MatchId,
      "UserId":UserId,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/onevsonematches/StartRound", data: formData);
      if(response.data == 'YourTurn'){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: Category(widget.MatchId,widget.UIC))),(Route<dynamic> route) => false);
      }else if(response.data == 'NotYourTurn'){
        Fluttertoast.showToast(
            msg: "نوبت شما نیست",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }catch(e){
      print(e);
    }
  }
  GetMatchData(MatchId,UserId) async {
    FormData formData = FormData.fromMap({
      "MatchId":MatchId,
      "UserId":UserId,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/onevsonematches/GetMatchData",data:formData);

      if(response.data['M_OP_Name']=='NoOp'){
        OpName = 'حریف شانسی';
      }else{
        OpName  =response.data['M_OP_Name'];
      }
      OPScore = response.data['M_OPScore'];

      SelfScore = response.data['M_SelfScore'];

    } catch (e) {
      print(e);
    }
    return true;
  }

  GetMatchRound(matchid,PlayerId) async {

    FormData formData = FormData.fromMap({
      "MatchId":matchid,
      "PlayerID":PlayerId,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/onevsonematches/GetRounds",data:formData);

    } catch (e) {
      print(e);
    }
  }
  RefreshData(Number) async {
    FormData formData = FormData.fromMap({
      "usernumber":Number,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetUserInfoByPhone",data:formData);
      print(response.data);
      print('ASASa');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(response.data))),(Route<dynamic> route) => false);

    } catch (e) {
      print(e);
    }
  }
}