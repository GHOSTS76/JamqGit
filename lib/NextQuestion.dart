import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';

class NextQuestion extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NextQuestionState();
  }

}

class NextQuestionState extends State<NextQuestion>{
  ConfettiController _controllerCenter;
  Color buttonColor1 = Colors.white;
  Color buttonColor2 = Colors.white;
  Color buttonColor3 = Colors.white;
  Color buttonColor4 = Colors.white;
  Future loadfuture;
  var QStext,QSChoice1,QSChoice2,QSChoice3,QSChoice4,QSTrueAnswer;
  @override
  void initState() {
    // TODO: implement initState
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    loadfuture = QuestionData();
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
    var themeColor = Color.fromRGBO(19, 2, 102, 1);
    // TODO: implement build
    return  new FutureBuilder(
      future:loadfuture ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData ?  new Scaffold(
          body:   Scaffold(
            body:  LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
                    return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/aboutusland.png'),
                                fit: BoxFit.fill)
                        ),
                        child:     SingleChildScrollView(
                          child:  Column(
                            children: [
                              Container(
                                width: 350,
                                height: 350,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/nextqs.png'),)
                                ),),
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/questionsbackport.png'), )
                                ),
                                width: 450,
                                height: 450,
                                child: Center(
                                  child:  Text(QStext,style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20),),
                                ),
                              ),
                             InkWell(
                               child:  Padding(
                                 child: Card(
                                   semanticContainer: true,
                                   clipBehavior: Clip.antiAliasWithSaveLayer,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(45),
                                   ),
                                   margin: EdgeInsets.all(6),
                                   elevation: 10,
                                   child:Container(
                                     width: width,
                                     height: 70,
                                     color: buttonColor3,
                                     child: Center(
                                         child:
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: <Widget>[
                                             Text('سوال بعدی',style: TextStyle(color:themeColor,fontFamily: 'MyFont',fontSize: 20,fontWeight:  FontWeight.bold),),
                                           ],
                                         )
                                     ),
                                   ),
                                 ),
                                 padding: EdgeInsets.only(left: 20,right: 20),
                               ),
                               onTap: (){

                               },
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
                                            color: buttonColor3,
                                            child: Center(
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset('assets/images/nextqsshare.png',height: 40,width: 40),
                                                    Padding(padding: EdgeInsets.only(right: 5),child:  Text('اشتراک سوال',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),)
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        onTap: (){

                                        },
                                      )
                                  ),
                                  ShowUpAnimation(
                                      curve:Curves.linear,
                                      animationDuration: Duration(milliseconds: 1300),
                                      offset: -0.2,
                                      child: InkWell(
                                        child:  Card(
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
                                            color:buttonColor4,
                                            child: Center(
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset('assets/images/nextqsreaport.png',height: 40,width: 40),
                                                    Padding(padding: EdgeInsets.only(right: 5),child:  Text('گزارش سوال',style: TextStyle(color:themeColor,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),)
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

                  } else {

                    return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/questionbkg.jpg'),
                                fit: BoxFit.fill)
                        ),
                        child:     SingleChildScrollView(
                          child:  Column(
                            children: [
                              Container(
                                width: 350,
                                height: 350,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/nextqs.png'),)
                                ),),
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/questionsbackport.png'), )
                                ),
                                width: 450,
                                height: 450,
                                child: Center(
                                  child:  Text(QStext,style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20),),
                                ),
                              ),
                              InkWell(
                                child:  Padding(
                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                    margin: EdgeInsets.all(6),
                                    elevation: 10,
                                    child:Container(
                                      width: width,
                                      height: 70,
                                      color: buttonColor3,
                                      child: Center(
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('سوال بعدی',style: TextStyle(color:themeColor,fontFamily: 'MyFont',fontSize: 20,fontWeight:  FontWeight.bold),),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                ),
                                onTap: (){

                                },
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
                                            color: buttonColor3,
                                            child: Center(
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset('assets/images/nextqsshare.png',height: 40,width: 40),
                                                    Padding(padding: EdgeInsets.only(right: 5),child:  Text('اشتراک سوال',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),)
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        onTap: (){

                                        },
                                      )
                                  ),
                                  ShowUpAnimation(
                                      curve:Curves.linear,
                                      animationDuration: Duration(milliseconds: 1300),
                                      offset: -0.2,
                                      child: InkWell(
                                        child:  Card(
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
                                            color:buttonColor4,
                                            child: Center(
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Image.asset('assets/images/nextqsreaport.png',height: 40,width: 40),
                                                    Padding(padding: EdgeInsets.only(right: 5),child:  Text('گزارش سوال',style: TextStyle(color:themeColor,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),)
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
            ),
          ),
        ) : new Center(child: CircularProgressIndicator(),);
      },
    );
  }

  QuestionData() async {
    FormData formData = FormData.fromMap({
      "Qsid": '5f71c10c8c568e08bcf40d8a',
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Questions/GetQuestionByid",data: formData);
      print(response);
      QStext = response.data['QStext'];
      QSChoice1 = response.data['QSChoice1'];
      QSChoice2 = response.data['QSChoice2'];
      QSChoice3 = response.data['QSChoice3'];
      QSChoice4 = response.data['QSChoice4'];
      QSTrueAnswer = response.data['QSTrueAnswer'];
      return true;
    } catch (e) {
      print(e);
    }
  }

}