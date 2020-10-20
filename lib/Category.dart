import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamqpwa/Question.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'UserInfoClass.dart';

class Category extends StatefulWidget{
  var MatchId,UIC;
  Category(this.MatchId,this.UIC);
  Category.none();


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryState();
  }

}

class CategoryState extends State<Category>{
  UserInfoClass UserInfo ;
  List Catdata;
  Future loadfuture;
  @override
  void initState() {
    // TODO: implement initState
    loadfuture = Category();
    UserInfo = new UserInfoClass(widget.UIC);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var pink = Color.fromRGBO(249, 211, 248, 1);
    var themeColor = Color.fromRGBO(19, 2, 102, 1);
    var purplecolor = Color.fromRGBO(80, 0, 131,1);
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
          body:  Scaffold(
            body:  LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
                    return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/aboutusland.jpg'),
                                fit: BoxFit.fill)
                        ),
                        child:Stack(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/applogo.png',width: 250,height: 250,),
                                  ],
                                ),
                                Padding(child:Container(
                                    width: c_width,
                                    height: 350,
                                    decoration:
                                    BoxDecoration(
                                        image:
                                        DecorationImage(
                                            image:
                                            AssetImage('assets/images/categoryitemsback.png')
                                            , fit: BoxFit.fill)
                                    ),
                                    child:Center(
                                        child: Padding(child:  Text('دسته مورد نظرت رو انتخاب کن',style: TextStyle(fontFamily: 'MyFont',fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white),),padding: EdgeInsets.only(top: 10),)
                                    )
                                ), padding: EdgeInsets.only(left: 30,right: 30),),
                                Padding(padding: EdgeInsets.only(left: 20,right: 20),child:  Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:  Radius.circular(100),bottomLeft:  Radius.circular(40),topRight:  Radius.circular(40)),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  elevation: 5,
                                  child:Container(
                                      width: width,
                                      height: 280,
                                      color: pink,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 20,bottom: 20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: Catdata.length,
                                                itemBuilder: (BuildContext context,int index){
                                                  return  new Padding(padding: EdgeInsets.all(10),child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[

                                                      ShowUpAnimation(
                                                          curve:Curves.linear,
                                                          animationDuration: Duration(milliseconds: 1000),
                                                          offset: -0.3,
                                                          child:   InkWell(
                                                            child:  Container(
                                                              height: 60,
                                                              width: 170,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  gradient: LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [purplecolor,themeColor ],
                                                                  )
                                                              ),
                                                              child:Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Padding(padding: EdgeInsets.all(5),child:  Image.network(Catdata[index]['CaIcon']),),
                                                                  new Text(Catdata[index]['CaName'],style:TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'MyFont'),),
                                                                ],
                                                              ),
                                                            ),
                                                            onTap: (){
                                                              print('Clicked!!!');
                                                              print('Id ++ ' + Catdata[index]['_id']);
                                                              print('Number' + UserInfo.GetPhoneNumber());
                                                              choiceCat(Catdata[index]['_id'],'M_test',UserInfo.GetPhoneNumber());

                                                            },
                                                          )
                                                      ),

                                                    ],
                                                  ),);
                                                }
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                ),)
                              ],
                            )
                          ],
                        )
                    );
                  } else {
                    return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/questionbkg.jpg'),
                                fit: BoxFit.fill)
                        ),
                        child:Stack(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/applogo.png',width: 250,height: 250,),
                                  ],
                                ),
                                Padding(child:Container(
                                    width: width,
                                    height: 250,
                                    decoration:
                                    BoxDecoration(
                                        image:
                                        DecorationImage(
                                            image:
                                            AssetImage('assets/images/categoryitemsback.png')
                                            , fit: BoxFit.fill)
                                    ),
                                    child:Center(
                                        child: Padding(child:  Text('دسته مورد نظرت رو انتخاب کن',style: TextStyle(fontFamily: 'MyFont',fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white),),padding: EdgeInsets.only(top: 10),)
                                    )
                                ),padding: EdgeInsets.only(left: 30,right: 30),),
                               Padding(padding: EdgeInsets.only(left: 20,right: 20),child:  Card(
                                 semanticContainer: true,
                                 clipBehavior: Clip.antiAliasWithSaveLayer,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:  Radius.circular(100),bottomLeft:  Radius.circular(40),topRight:  Radius.circular(40)),
                                 ),
                                 margin: EdgeInsets.all(10),
                                 elevation: 5,
                                 child:Container(
                                     width: width,
                                     height: 280,
                                     color: pink,
                                     child: Padding(
                                       padding: EdgeInsets.only(top: 20,bottom: 20),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           ListView.builder(
                                               scrollDirection: Axis.vertical,
                                               shrinkWrap: true,
                                               itemCount: Catdata.length,
                                               itemBuilder: (BuildContext context,int index){
                                                 return  new Padding(padding: EdgeInsets.all(10),child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   children: <Widget>[
                                                     Container(
                                                       height: 60,
                                                       width: 170,
                                                       decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(20),
                                                           gradient: LinearGradient(
                                                             begin: Alignment.topCenter,
                                                             end: Alignment.bottomCenter,
                                                             colors: [purplecolor,themeColor],
                                                           )
                                                       ),
                                                       child:Row(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: <Widget>[
                                                           Padding(padding: EdgeInsets.all(5),child:  Image.network(Catdata[index]['CaIcon']),),
                                                           new Text(Catdata[index]['CaName'],style:TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'MyFont'),),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),);
                                               }
                                           ),
                                         ],
                                       ),
                                     )
                                 ),
                               ),)
                              ],
                            )
                          ],
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

  Category() async {
    try {
      Response response = await Dio().post("http://jamq.ir:3000/onevsonematches/SelectCategory");
      print(response);
      Catdata = response.data;
      return true;
    } catch (e) {
      print(e);
    }
  }

  choiceCat(CatId,MatchId,PlayerId) async {
    print(CatId);
    print(MatchId);
    print(PlayerId);
    FormData formData = FormData.fromMap({
      "CatId":CatId,
      "MatchId":MatchId,
      "MatchId":PlayerId,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/onevsonematches/SelectQuestions",data:formData);
      print(response);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:Question.none())),(Route<dynamic> route) => false);
      return true;
    } catch (e) {
      print(e);
    }
  }
}