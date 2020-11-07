import 'dart:convert';

import 'package:aho_corasick/aho_corasick.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jamqpwa/LiveQuestion.dart';
import 'package:jamqpwa/UserInfoClass.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;

import 'package:socket_io_client/socket_io_client.dart';


class LiveMain extends StatefulWidget {
  var MatchID,playerId,UIC;
  LiveMain(this.MatchID,this.playerId,this.UIC);
  LiveMain.none();
  LiveMainState createState() => LiveMainState();
}

class LiveMainState extends State<LiveMain> {
  var selectedChoice = 99;
  var s= 0;
  var   selectedColor = Color.fromRGBO(80, 0, 131, 1);
  var   UnselectedColor = Colors.white;
  CountDownController _controller = CountDownController();
  Socket socket;
  String createdViewId = 'map_element';
  List<String> curses = new List();
  Future loadfuture;
  var aho;
  @override
  void initState() {
    super.initState();
    loadfuture = InitFunction();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var purplecolor = Color.fromRGBO(80, 0, 131,1);
    var lightpurplecolor = Color.fromRGBO(50, 0, 131,30);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final numberController = TextEditingController();
    ui.platformViewRegistry.registerViewFactory(
        createdViewId,
            (int viewId) => html.IFrameElement()
          ..srcdoc = """<!DOCTYPE html><html>
          <head><title>Page Title</title></head><body> <div> 
    <object type="text/html" data="https://player.arvancloud.com/index.html?config=https://jamq.arvanlive.com/3VKWw3WZXd/3ANWJwnlmb/origin_config.json" width="""+width.toString()+"""+px" height="""+height.toString()+"""px" style="overflow:auto;border:0px ridge blue">
    </object>
 </div>
</body></html>"""
          ..style.border = 'none');

    return FutureBuilder(
      future:loadfuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData ?  Scaffold(
          body:   Stack(
            children: [
              Container(
                  child: HtmlElementView(
                    viewType: createdViewId,
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(top: 20,right: 20),child:InkWell(
                      child: Image.asset('assets/images/applogo.png',width: 80,height: 80  ,),
                      onTap: (){
                        print('Clicked');

                      }
                  )),
                  Padding(padding: EdgeInsets.only(top: 20,left: 20),child:Row(
                    children: [
                      //           Image.asset('assets/images/applogo.png'),
                      Text('234',style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'MyFont'),),
                    ],
                  )),

                ],
              ),
              Align (
                child:  Container(
                  height: 90,
                  width: width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [purplecolor,lightpurplecolor ],
                      )
                  ),
                ),
                alignment: Alignment.bottomCenter,
              ),
              Align(
                child: Padding(
                  child:  InkWell(
                    child: Container(
                        height: 50,
                        width: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightpurplecolor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child:  Center(
                          child:  Image.asset('assets/images/chatico.png',height: 30,width: 30,),
                        )
                    ),
                    onTap: (){
                      print('Tapped');
                      Flexible(
                          fit: FlexFit.loose,
                          child: new Padding(padding: EdgeInsets.fromLTRB(0, 5, 40, 5),child: new TextField(
                            controller: numberController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.deepPurple,
                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: '9180000000',
                            ),
                          )));
                    },
                  ),
                  padding:EdgeInsets.only(bottom: 120),
                ),
                alignment: Alignment.bottomRight,
              ),

            ],
          ),
        ): new Center(child: CircularProgressIndicator(),);
      },
    );
  }



  GetCurseWords() async {
    try {
      Response response = await Dio().post("http://jamq.ir:3000/MainUser/GetCursedWordsString");
      print(response);

      List Dattta = response.data ;
      for(var a = 0;a<Dattta.length;){
        var ss  =Dattta[a];
        print(ss);
        curses.add(ss);
        a++;
      }
      print('AAAAAAA'+curses.toString());
      s = 1;
      return curses;
    } catch (e) {
      print(e);
    }
  }

  ChatFilter(ChatText,data){
    final aho = AhoCorasick.fromWordList(data);
    final results = aho.matches(ChatText);
    print(results.map((match) => 'found ${match.word} at ${match.startIndex}').join('\n'));

    return results.map((match) => 'found ${match.word} at ${match.startIndex}').join('\n');
  }

  ConnectSocket() async {
    socket = io('http://jamq.ir:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false, // optional
    });
    socket.connect();
    socket.on('connect', (_) {
      QuesttionReceived();
      EndMatch();
      print('LiveMainSocketOn');

    });
  }

  InitFunction() async{
    if(s == 0){
      ConnectSocket();
      await GetCurseWords();
    }else{

    }

    return true;
  }

  QuesttionReceived(){

    socket.on('QuestionReceived', (data) async =>

    QuestionReceivedFunction(data)

    );
}

  EndMatch(){
    socket.on('MatchEnded', (data) async =>
    EndMatchFunction()
    );
  }


QuestionReceivedFunction(data) async {
    socket.disconnect();

  var _ParsedData = await jsonDecode(data.toString());
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => new Directionality(textDirection: TextDirection.rtl,
        child:
        LiveQuestion(_ParsedData[0][0]['LMQ_Question'],_ParsedData[0][0]['LMQ_Choice1'],_ParsedData[0][0]['LMQ_Choice2'],_ParsedData[0][0]['LMQ_Choice3'],_ParsedData[0][0]['_id'],int.parse(_ParsedData[1].toString()),widget.MatchID,widget.playerId,widget.UIC)),),
  );

}

  EndMatchFunction(){
    print('EndMatchRans');
  }

  QuestionAnalyzer(){

  }

  SendPmToChat(){


  }





}