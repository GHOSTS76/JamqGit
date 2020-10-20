import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie_flutter/lottie_flutter.dart';
import 'package:rive/rive.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'MainPage.dart';
import 'UserInfoClass.dart';

class SelectOpponent extends StatefulWidget{

  var UIC;
  SelectOpponent(this.UIC);
  SelectOpponent.none();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SelectOpponentState();
  }

}
class SelectOpponentState extends State<SelectOpponent> with SingleTickerProviderStateMixin{
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var Profilepicture ='https://assets2.lottiefiles.com/packages/lf20_oaem7pma.json';
  var OppenentPic ;
  var OppenentName ='';
  UserInfoClass UserInfo ;
  @override
  void initState() {
    // TODO: implement initState
    UserInfo = new UserInfoClass(widget.UIC);
    super.initState();
    SelectOpponent();
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body:  LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
              return Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/searchico.png',width: 50,height: 50,),
                        new Text('در حال جستجوی حریف...',style: TextStyle(fontSize: 26 ,color: Colors.white,fontFamily: 'MyFont'),),
                      ],
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
                child:  Stack(
                  children: [
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 200),child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/searchico.png',width: 50,height: 50,),
                            Padding(padding: EdgeInsets.only(right: 10),child: new Text('در حال جستجوی حریف...',style: TextStyle(fontSize: 26 ,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'MyFont'),),)
                          ],
                        ),),
                        Padding(padding: EdgeInsets.only(left: 60,right: 60,top: 50),child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage:OppenentPic,
                            ),
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(UserInfo.GetProiflePic()),
                            ),
                          ],
                        )),
                        Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 50),child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              ),
                              elevation: 10,
                              child:Container(
                                width: 180,
                                height: 60,
                                color:Colors.white,
                                child: Center(
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text(OppenentName,style: TextStyle(color:themeColor,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),)
                                      ],
                                    )
                                ),
                              ),
                            ),
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              ),

                              elevation: 10,
                              child:Container(
                                width: 180,
                                height: 60,
                                color:Colors.white,
                                child: Center(
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text(UserInfo.GetUserName(),style: TextStyle(color:themeColor,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),)
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child:  ShowUpAnimation(
                          curve:Curves.linear,
                          animationDuration: Duration(milliseconds: 1400),
                          offset: -0.9,
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
                                color: Colors.white,
                                child: Center(
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(right: 5),child:  Text('لغو',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 20,fontWeight: FontWeight.bold),),)
                                      ],
                                    )
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  MainPage(widget.UIC))),(Route<dynamic> route) => false);
                            },
                          )
                      ),
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
  SelectOpponent() async {
    FormData formData = FormData.fromMap({
      "PlayerId": UserInfo.GetId(),
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/onevsonematches/SelectOpponent",data:formData);
     var array =[];
    array =  response.data.split('-');
      print(array);
      print(response);
      if(array.length == 2){
        setState(() {
          OppenentName = array[0];
          OppenentPic =  NetworkImage(array[1]);
        });
      }else{
     setState(() {
       OppenentPic = ExactAssetImage('assets/images/question.png');
       OppenentName = 'حریف شانسی';
     });
      }

    } catch (e) {
      print(e);
    }
  }
}