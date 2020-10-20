import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';

class TestClass extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestState();
  }

}

class TestState extends State<TestClass>{

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.4;
    double c_height = MediaQuery.of(context).size.height*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double P_height = MediaQuery.of(context).size.height*0.8;
    // TODO: implement build
    return  new   LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/mainbackland.jpg'),
                      fit: BoxFit.fill)
              ),

            );
          } else {
            return Scaffold(
              body: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/mainbackport.jpg'),
                          fit: BoxFit.fill)
                  ),
                  child: Padding(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(child: Row(
                                  children: [
                                    Padding(
                                      child: CircleAvatar(radius: 45, backgroundColor: Colors.blue,),
                                      padding: EdgeInsets.only(right: 8,bottom: 6),

                                    ),
                                    Column(
                                      children: [
                                        new Text('Saeedszz',style: TextStyle(fontSize: 20,color: Colors.purple,fontFamily: 'MyFont'),),
                                        Stack(
                                          children: <Widget>[
                                            Image.asset('assets/images/score.png',width:80,),
                                            Padding(padding: EdgeInsets.only(top: 3,right: 35),child:   Text('10',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),)

                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                  width: 440,
                                  height: 270,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/profile.png'),
                                          fit: BoxFit.fitWidth
                                      )
                                  ),
                                ),
                              ],
                            )

                          ],
                        )
                    ),
                    padding: EdgeInsets.only(left: 20,right: 20),
                  )
              ),
            );
          }
        }
    );
  }

}