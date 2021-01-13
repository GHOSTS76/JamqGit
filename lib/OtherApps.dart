
import 'dart:convert';

import 'package:aho_corasick/aho_corasick.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:socket_io_client/socket_io_client.dart';
class TestClass extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestState();
  }

}

class TestState extends State<TestClass>{
  var   selectedColor = Color.fromRGBO(80, 0, 131, 1);
  var   UnselectedColor = Colors.white;
  static Socket socket;
  var pink = Color.fromRGBO(249, 211, 248, 1);
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    ConnectSocket();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.4;
    double c_height = MediaQuery.of(context).size.height*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double P_height = MediaQuery.of(context).size.height*0.6;
    CountDownController _controller = CountDownController();
    bool _isPause = false;
    var profback = AssetImage('assets/images/profback.png');
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/aboutusport.jpg'),
                fit: BoxFit.fill)
        ),
      child: Column(

        children: [
          Padding(
            child:   Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
              margin: EdgeInsets.all(10),
              elevation: 10,
              child:Container(
                width: P_width,
                height: P_height,
                color:Colors.white,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          child: CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            radius: 60,
                            backgroundImage:  profback,
                          ),
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child:   CircularCountDownTimer(
                            duration: 10,
                            controller: _controller,
                            width: 150,
                            height: 150,
                            color: Colors.white,
                            fillColor: purplecolor,
                            backgroundColor: null,
                            strokeWidth: 5.0,
                            textStyle: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
                            isReverse: false,
                            isReverseAnimation: false,
                            isTimerTextShown: false,
                            onComplete: () {
                              print('Countdown Ended');
                              setState(() {
                                _controller.pause();
                                selectedColor = Colors.green;
                                UnselectedColor = Colors.red;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    CustomRadioButton(
                     customShape: OutlineInputBorder(
                       borderSide: BorderSide(
                           color: themeColor, width: 2),
                       borderRadius: BorderRadius.all(Radius.circular(40)),
                     ),
                  elevation: 5  ,
                  height: 50,
                  selectedBorderColor:selectedColor,
                  unSelectedColor: UnselectedColor,
                  unSelectedBorderColor: UnselectedColor,
                  enableShape: true,
                  enableButtonWrap: true,

                  buttonLables: [
                    "یک",
                    "دو",
                    "سه",
                  ],
                  buttonValues: [
                    "یک",
                    "دو",
                    "سه",
                  ],
                  radioButtonValue: (values) {
                    print(values);
                    sendQS();
                  },
                  horizontal: true,
                  width: 100,
                  selectedColor: selectedColor,
                  padding: 10,
                  spacing: 0.0,
                  // enableShape: true,
                ),
                  ],
                ),
              ),
            ),
            padding: EdgeInsets.only(top:50),
          )
        ],
      ),
    );
  }
  ConnectSocket() async {
    socket = io('http://jamq.ir:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false, // optional
    });
    socket.connect();
    socket.on('connect', (_) {

      print('On Babe');

    });
  }

  sendQS(){
    print('Clicked');

    socket.emit('AAA', ['','']);
    socket.emit('SendQuestiontoUser', ['aaa','dvdcv']);
  }
}