
import 'package:aho_corasick/aho_corasick.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestClass extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestState();
  }

}

class TestState extends State<TestClass>{
  List<String> curses = new List();
  var aho;
  Future loadfuture;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadfuture = GetCurseWords();

  }
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future:loadfuture ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var sna = snapshot.data;
        return snapshot.hasData ?  new Center(
          child: Text(ChatFilter('تو یک ادم کیر مغزی',sna)),
        ) : new Center(child: CircularProgressIndicator(),);
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
    final results = aho.matches('کیر');
    print(results
        .map((match) => 'found ${match.word} at ${match.startIndex}')
        .join('\n'));
    // > found abc at 10
    // > found bcd at 11
    return results
        .map((match) => 'found ${match.word} at ${match.startIndex}')
        .join('\n');
  }

  GetTransactionList() async {
    FormData formData = FormData.fromMap({
      //"usernumber":UserInfo.GetPhoneNumber(),
      "IsBanned":true,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/MainUser/BanUser",data: formData);
      if(response.data == 'UserBanned'){
        SystemNavigator.pop();
      }

      return true;
    } catch (e) {
      print(e);
    }
  }
}