import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'UserInfoClass.dart';
class Tournament extends StatefulWidget{

  var UIC;


  Tournament(this.UIC);


  Tournament.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TournamentState();
  }

}
class TournamentState extends State<Tournament>{
  UserInfoClass UserInfo ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.4;
    double P_width = MediaQuery.of(context).size.width*0.9;
    double c_height = MediaQuery.of(context).size.height*0.9;
    double height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return new Scaffold(body: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/aboutusland.jpg'), fit: BoxFit.fill)),
              child: Stack(
                children: [

                ],
              ),
            );
          } else {
            return Container(
              width: width,
                height:height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/questionbkg.jpg'),
                        fit: BoxFit.fill)
                ),
                child:     SingleChildScrollView(
                  child:  Column(
                    children: [
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
                          width: P_width,
                          height: c_height,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShowUpAnimation(
                              curve:Curves.linear,
                              animationDuration: Duration(milliseconds: 1300),
                              offset: -0.2,
                              child:  InkWell(
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
                                    height: 70,

                                    child: Center(
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(padding: EdgeInsets.only(right: 5),child:  Text('ادامه',style: TextStyle( fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),)
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                                onTap: (){

                                },
                              )
                          ),
                        ],)
                    ],
                  ),
                )
            );
          }
        }
    ));

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

}

