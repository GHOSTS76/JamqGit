import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'UserInfoClass.dart';

class Question extends StatefulWidget{
  var data,Uic;
  Question(this.data,this.Uic);
  Question.none();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionState();
  }

}

class QuestionState extends State<Question>{
  UserInfoClass UserInfo ;
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
    UserInfo = new UserInfoClass(widget.Uic);
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/questiontopprot.png'),)
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
                              Container(
                                height: 50,
                                width: 170,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ShowUpAnimation(
                                      curve:Curves.linear,
                                      animationDuration: Duration(milliseconds: 1300),
                                      offset: -0.2,
                                      child: InkWell(
                                        child:  ConfettiWidget(
                                          confettiController: _controllerCenter,
                                          blastDirectionality: BlastDirectionality.explosive, // d
                                          maxBlastForce: 20,// on't specify a direction, blast randomly
                                          numberOfParticles: 20,
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
                                              color: buttonColor1,
                                              child: Center(
                                                  child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(QSChoice1,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ) ,// ly specify the colors to be used
                                        ),
                                        onTap: (){
                                          QuestionDetector(QSChoice1,1);
                                        },
                                      )
                                  ),
                                  ShowUpAnimation(
                                      curve:Curves.linear,
                                      animationDuration: Duration(milliseconds: 1300),
                                      offset: -0.2,
                                      child:  InkWell(
                                        child: ConfettiWidget(
                                          confettiController: _controllerCenter,
                                          blastDirectionality: BlastDirectionality.explosive, // d
                                          maxBlastForce: 20,// on't specify a direction, blast randomly
                                          numberOfParticles: 20,
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
                                              color: buttonColor2,
                                              child: Center(
                                                  child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(QSChoice2,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ),// ly specify the colors to be used
                                        ),
                                        onTap: (){
                                          QuestionDetector(QSChoice2,2);
                                        },
                                      )
                                  ),
                                ],),
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
                                                    Text(QSChoice3,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        onTap: (){
                                          QuestionDetector(QSChoice3,3);
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
                                                    Text(QSChoice4,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        onTap: (){
                                          QuestionDetector(QSChoice4,4);
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/questiontopprot.png'),)
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
                              Container(
                                height: 50,
                                width: 170,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ShowUpAnimation(
                                      curve:Curves.linear,
                                      animationDuration: Duration(milliseconds: 1300),
                                      offset: -0.2,
                                      child: InkWell(
                                        child:  ConfettiWidget(
                                          confettiController: _controllerCenter,
                                          blastDirectionality: BlastDirectionality.explosive, // d
                                          maxBlastForce: 20,// on't specify a direction, blast randomly
                                          numberOfParticles: 20,
                                          shouldLoop:
                                          false, // start again as soon as the animation is finished
                                          colors: const [
                                            Colors.green,
                                            Colors.blue,
                                            Colors.pink,
                                            Colors.orange,
                                            Colors.purple,
                                            Colors.deepPurple,
                                            Colors.yellowAccent
                                          ], // manual
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
                                              color: buttonColor1,
                                              child: Center(
                                                  child:
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(QSChoice1,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ) ,// ly specify the colors to be used
                                        ),
                                        onTap: (){
                                          QuestionDetector(QSChoice1,1);
                                        },
                                      )
                                  ),
                                  ShowUpAnimation(
                                    curve:Curves.linear,
                                    animationDuration: Duration(milliseconds: 1300),
                                    offset: -0.2,
                                    child:  InkWell(
                                      child: ConfettiWidget(
                                        confettiController: _controllerCenter,
                                        blastDirectionality: BlastDirectionality.explosive, // d
                                        maxBlastForce: 20,// on't specify a direction, blast randomly
                                        numberOfParticles: 20,
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
                                            color: buttonColor2,
                                            child: Center(
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(QSChoice2,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),// ly specify the colors to be used
                                      ),
                                      onTap: (){
                                        QuestionDetector(QSChoice2,2);
                                      },
                                    )
                                  ),
                                ],),
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
                                                  Text(QSChoice3,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        QuestionDetector(QSChoice3,3);
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
                                                  Text(QSChoice4,style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        QuestionDetector(QSChoice4,4);
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
        "PlayerId":UserInfo.GetPhoneNumber(),
        "MatchId":UserInfo.GetPhoneNumber(),
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/onevsonematches/SelectQuestions",data: formData);
      print(response);
      QStext = response.data['QStext'];
      QSChoice1 = response.data['QSChoice1'];
      QSChoice2 = response.data['QSChoice2'];
      QSChoice3 = response.data['QSChoice3'];
      QSChoice4 = response.data['QSChoice4'];
      return true;
    } catch (e) {
      print(e);
    }
  }

  QuestionDetector(PlayerAnswer,choice){
    //سمت سرور شود
    print('PlayerAnswer : '+PlayerAnswer);
    print('choice : '+choice.toString());
    print('choice : '+QSTrueAnswer);
    if(PlayerAnswer == QSTrueAnswer)
    {
      _controllerCenter.play();
      if(choice == 1){
        buttonColor1 = Colors.green;
        buttonColor2 = Colors.red;
        buttonColor3 = Colors.red;
        buttonColor4 = Colors.red;
      }
      else if(choice == 2){
        buttonColor1 = Colors.red;
        buttonColor2 = Colors.green;
        buttonColor3 = Colors.red;
        buttonColor4 = Colors.red;
      }
      else if(choice == 3){
        buttonColor1 = Colors.red;
        buttonColor2 =  Colors.red;
        buttonColor3 = Colors.green;
        buttonColor4 = Colors.red;
      }
      else if(choice == 4){
        buttonColor1 = Colors.red;
        buttonColor2 =  Colors.red;
        buttonColor3 = Colors.red;
        buttonColor4 = Colors.green;
      }
    }else{
      print('Else Rans');
      if(QSTrueAnswer == QSChoice1){
        buttonColor1 = Colors.green;
        buttonColor2 =  Colors.red;
        buttonColor3 = Colors.red;
        buttonColor4 = Colors.red;
      }else if(QSTrueAnswer == QSChoice2){
        buttonColor1 = Colors.red;
        buttonColor2 =  Colors.green;
        buttonColor3 = Colors.red;
        buttonColor4 = Colors.red;
      }else if(QSTrueAnswer == QSChoice3){
        buttonColor1 = Colors.red;
        buttonColor2 =  Colors.red;
        buttonColor3 = Colors.green;
        buttonColor4 = Colors.red;
      }else if(QSTrueAnswer == QSChoice4){
        buttonColor1 = Colors.red;
        buttonColor2 =  Colors.red;
        buttonColor3 = Colors.red;
        buttonColor4 = Colors.green;
      }

    }
    setState(() {

    });
  }
}