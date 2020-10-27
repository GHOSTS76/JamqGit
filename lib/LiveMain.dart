import 'package:aho_corasick/aho_corasick.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;

import 'package:socket_io_client/socket_io_client.dart';


class LiveMain extends StatefulWidget {
  var MatchID;
  LiveMain(this.MatchID);
  LiveMain.none();
  LiveMainState createState() => LiveMainState();
}

class LiveMainState extends State<LiveMain> {
  Socket socket;
  String createdViewId = 'map_element';
  List<String> curses = new List();
  var aho;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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

    return Scaffold(
      body:   Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300], width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: HtmlElementView(
                    viewType: createdViewId,
                  )
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
          InkWell(
            child: Align(
              child:  Container(
                height: 60,
                width: width,
                color: Colors.deepPurple,
              ),
              alignment: Alignment.bottomCenter,
            ),
            onTap: (){
            },
          ),
          InkWell(
            child: Align(
              child:  Container(
                height: 60,
                width: width,
                color: Colors.deepPurple,
              ),
              alignment: Alignment.bottomCenter,
            ),
          )
        ],
      ),
    );
  }
  void question(BuildContext context,question,choice1,choice2,choice3,QuestionId){
    print('QS IS HERE = '+question);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
            body: Container(
              child: Center(
                  child:Stack(
                    children: <Widget>[
                      new Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/aboutusport.jpg'),
                                fit: BoxFit.fill)
                        ),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              ),
                              margin: EdgeInsets.all(10),
                              elevation: 10,
                              child:Container(
                                width: 250,
                                height: 150,
                                color:Colors.white,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            )
        );
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
      return curses;
    } catch (e) {
      print(e);
    }
  }

  ChatFilter(ChatText,data){
    final aho = AhoCorasick.fromWordList(data);
    final results = aho.matches(ChatText);
    print(results
        .map((match) => 'found ${match.word} at ${match.startIndex}')
        .join('\n'));
    // > found abc at 10
    // > found bcd at 11
    return results
        .map((match) => 'found ${match.word} at ${match.startIndex}')
        .join('\n');
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
      print('SocketOn');

    });
  }


  QuesttionReceived(){

    socket.on('QuestionReceived', (data) async =>

        question(context,data[0]['LMQ_Question'],data[0]['LMQ_Choice1'],data[0]['LMQ_Choice2'],data[0]['LMQ_Choice3'],data[0]['_id'])

    );
}

  EndMatch(){
    socket.on('MatchEnded', (data) async =>
        print('End')
    );
  }




  EndMatchFunction(){

  }
}