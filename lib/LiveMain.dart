import 'dart:convert';

import 'package:aho_corasick/aho_corasick.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jamqpwa/LiveQuestion.dart';
import 'package:jamqpwa/MainPage.dart';
import 'package:jamqpwa/UserInfoClass.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:video_player/video_player.dart';




class LiveMain extends StatefulWidget {
  var MatchID,playerId,UIC;
  LiveMain(this.MatchID,this.playerId,this.UIC);
  LiveMain.none();
  LiveMainState createState() => LiveMainState();
}

class LiveMainState extends State<LiveMain> {
  var selectedChoice = 99;
  var s= 0;
  var Players = 0;
  var   selectedColor = Color.fromRGBO(80, 0, 131, 1);
  var   UnselectedColor = Colors.white;
  CountDownController _controller = CountDownController();
  Socket socket;
  String createdViewId = 'map_element';
  List<String> curses = new List();
  Future loadfuture;
  var aho;
  VideoPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    loadfuture = InitFunction();
    _playerController = VideoPlayerController.network(
        'https://jamq.arvanlive.com/hls/mainlive/mainlive.m3u8')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
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
//    ui.platformViewRegistry.registerViewFactory(
//        createdViewId,
//            (int viewId) => html.IFrameElement()
//          ..srcdoc = """<!DOCTYPE html><html>
//          <head><title>Page Title</title></head><body> <div>
//    <object type="text/html" data="https://player.arvancloud.com/index.html?config=https://jamq.arvanlive.com/3VKWw3WZXd/3ANWJwnlmb/origin_config.json" width="""+width.toString()+"""+px" height="""+height.toString()+"""px" style="overflow:auto;border:0px ridge blue">
//    </object>
// </div>
//</body></html>"""
//          ..style.border = 'none');

    return FutureBuilder(
      future:loadfuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData ?  Scaffold(
          body:   Stack(
            children: [
              Container(
                  child: _playerController.value.initialized
                      ? AspectRatio(
                    aspectRatio: _playerController.value.aspectRatio,
                    child: VideoPlayer(_playerController),
                  )
                      : Container(),
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
                      Text(Players.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'MyFont'),),
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
    return results.map((match) => 'found');
  }

  ConnectSocket() async {
    socket = io('http://jamq.ir:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false, // optional
    });
    socket.connect();
    socket.on('connect', (_) {
      socket.emit('SubmitId',widget.playerId);
      QuesttionReceived();
      EndMatch();
      print('LiveMainSocketOn');

    });
  }


  InitFunction() async{
    if(s == 0){
      ConnectSocket();
     // getPlayers(widget.MatchID);
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
        EndMatchFunction(data)
    );
  }
  UpdatePLayers(){
      socket.on('UpdatePlayer', (data) async =>
          upadatePlayers(data)
    );
  }


  QuestionReceivedFunction(data) async {
    socket.disconnect();
    var _ParsedData = await jsonDecode(data.toString());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new Directionality(textDirection: TextDirection.rtl,
          child: LiveQuestion(_ParsedData[0][0]['LMQ_Question'],_ParsedData[0][0]['LMQ_Choice1'],_ParsedData[0][0]['LMQ_Choice2'],_ParsedData[0][0]['LMQ_Choice3'],_ParsedData[0][0]['_id'],int.parse(_ParsedData[1].toString()),widget.MatchID,widget.playerId,widget.UIC)),),
    );

  }

  upadatePlayers(PlayerCount){
    setState(() {
      Players = PlayerCount;
    });
  }

  EndMatchFunction(data){

    if(data == widget.MatchID){
      checkForWin(data);
    }

  }

  checkForWin(mid) async {

    var Place ;
    FormData formData = FormData.fromMap({
      "LM_PlayerId":widget.playerId,
      "LM_MatchID": mid,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/LiveMatch/DetermineResult",data:formData);
      if(response.data == 'Lost'){
        Alert(
          context: context,
          type: AlertType.info,
          title: "برنده نشدی",
          desc: "جزو سه نفر اول نبودی ولی اشکالی نداره تو لایو بعدی بیشتر تلاش کن.",
          buttons: [
            DialogButton(
              child: Text(
                "باشه",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  MainPage(widget.UIC))),(Route<dynamic> route) => false),
              width: 120,
              color:Colors.red,
            ),
          ],
        ).show();
      }else{

        if(response.data =='1'){
          Place = 'اول';
        }else if(response.data == '2'){
          Place = 'دوم';
        }else if(response.data == '3'){
          Place = 'سوم';
        }
        Alert(
          context: context,
          type: AlertType.info,
          title: "افرین ",
          desc: ' شدی ، همکارامون بزودی جایزت رو برات واریز میکنن، تو لایو بعدی میبینمت.'+Place,
          buttons: [
            DialogButton(
              child: Text(
                "باشه",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  MainPage(widget.UIC))),(Route<dynamic> route) => false),
              width: 120,
              color:Colors.red,
            ),
          ],
        ).show();
      }

    } catch (e) {
      print(e);
    }
  }

  QuestionAnalyzer(){

  }

  SendPmToChat(){


  }
//  getPlayers(mid) async {
//    FormData formData = FormData.fromMap({
//      "Id": mid,
//    });
//    try {
//    Response response = await Dio().post("http://jamq.ir:3000/LiveMatch/GetLiveMatchByMId",data:formData);
//    Players = response.data[0]['LmPlayersInGame'];
//    setState(() {
//
//    });
//    } catch (e) {
//      print(e);
//    }
//}
}