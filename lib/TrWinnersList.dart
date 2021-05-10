import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:jamqpwa/TournamentMain.dart';
import 'package:jamqpwa/TournamentQuestion.dart';
import 'package:jamqpwa/TournamentSetterClass.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'MainPage.dart';
import 'Shop.dart';
import 'UserInfoClass.dart';

class TrWinnerlist extends StatefulWidget{
  var winnerlist,Uic;
  TrWinnerlist(this.winnerlist,this.Uic);
  TrWinnerlist.none();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TrWinnerlistState();
  }
}
class TrWinnerlistState extends State<TrWinnerlist>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.winnerlist);
  }
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.8;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:  LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
              return Container(
                width: width,
                height: height,
                child: Column(
                  children: [
                    Padding(
                      child:   Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 15),child:InkWell(
                            child:Image.asset('assets/images/backico.png',height: 40,width: 40,),
                            onTap: (){
                              GetTournaments();
                              },
                          ) )
                        ],
                      ),
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Padding(
                      child:      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.winnerlist.length,
                          itemBuilder: (BuildContext context,int index){
                            return Padding(
                              child:  Card(
                                color: Colors.white,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(65),
                                ),
                                child: Container(
                                    width: c_width,
                                    height: 100,
                                    child:Padding(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                        ],
                                      ),
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                    )
                                ),
                              ),
                              padding: EdgeInsets.only(left: 20,right: 20),
                            );
                          }
                      ),
                      padding: EdgeInsets.only(top: 20),
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
              width: width,
              height: height,
                child: Column(
                  children: [
                  Padding(
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 15),child:InkWell(
                          child:Image.asset('assets/images/backico.png',height: 40,width: 40,),
                          onTap: (){
                            GetTournaments();
                            },
                        ) )
                      ],
                    ),
                    padding: EdgeInsets.only(top: 20),
                  ),
                    Padding(
                      child:      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.winnerlist.length,
                          itemBuilder: (BuildContext context,int index){
                            return Padding(
                              child:  Card(
                                color: Colors.white,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(65),
                                ),
                                child: Container(
                                    width: c_width,
                                    height: 100,
                                    child:Padding(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(radius: 35, backgroundImage: NetworkImage(widget.winnerlist[index]['Picture']),),
                                          new Text(widget.winnerlist[index]['UserName']  ,style: TextStyle(fontSize: 20,color: Colors.purple,fontFamily: 'MyFont'),),
                                          new Text('امتیاز' ,style: TextStyle(fontSize: 20,color: Colors.purple,fontFamily: 'MyFont'),),
                                          new Text(widget.winnerlist[index]['Score'].toString()  ,style: TextStyle(fontSize: 20,color: Colors.purple,fontFamily: 'MyFont'),),

                                        ],
                                      ),
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                    )
                                ),
                              ),
                              padding: EdgeInsets.only(left: 20,right: 20),
                            );
                          }
                      ),
                      padding: EdgeInsets.only(top: 20),
                    )
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
    );
  }
  GetTournaments() async {
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Tournament/GetActiveTournaments");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:TournamentMain(widget.Uic,response.data))),(Route<dynamic> route) => false);

    } catch (e) {
      print(e);
    }
  }

}