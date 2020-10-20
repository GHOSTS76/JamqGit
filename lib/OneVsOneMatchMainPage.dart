import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamqpwa/AboutUs.dart';
import 'package:jamqpwa/MainPage.dart';
import 'package:jamqpwa/SendTicket.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import 'OneVsOneMatchPage.dart';

class OneVsOneMatch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OneVsOneMatchState();
  }

}
class OneVsOneMatchState extends State<OneVsOneMatch> with SingleTickerProviderStateMixin{
  Future loadfuture;
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  static TabController tabController;
  var _currentSelection;
  Map<int, Widget> _children = {
      0:Container(height: 20,width: 130,child: Center(child: Text('مسابقه',style: TextStyle(color: Colors.white),),),),
      1:Container(height: 20,width: 130,child:Center(child:  Text('گفتگو',style: TextStyle(color: Colors.white),),)),
  };
  List data;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.4;
    double c_height = MediaQuery.of(context).size.height*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double P_height = MediaQuery.of(context).size.height*0.8;
     return  new FutureBuilder(
      future:loadfuture ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        return snapshot.hasData ?  new  Scaffold(
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
                          children: <Widget>[
                            Align(
                              child:Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight:  Radius.circular(15),bottomLeft:  Radius.circular(60),topRight:  Radius.circular(60)),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  elevation: 5,
                                  child:  Container(
                                    height: 220,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: themeColor,
                                                    fontFamily: 'MyFont'
                                                ),
                                              ),
                                              Text(
                                                'مسابقه تک به تک',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: themeColor,
                                                    fontFamily: 'MyFont'
                                                ),
                                              ),
                                              Padding(
                                                child:  InkWell(
                                                  child:Image.asset('assets/images/backico.png',height: 25,width: 25,color: themeColor,),
                                                  onTap: (){
                                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(data))),(Route<dynamic> route) => false);
                                                  },
                                                ),
                                                padding: EdgeInsets.only(left: 10),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(padding: EdgeInsets.only(top: 10),child:
                                                  Card(
                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 5,
                                                    child:Container(

                                                      child: Center(
                                                        child:
                                                        Text("ورژن",style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16),),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            colors: [purplecolor,themeColor],
                                                          )
                                                      ),
                                                      width: 120,
                                                      height: 50,
                                                    ),
                                                  ),),
                                                  Container(
                                                    child: Center(
                                                      child: Text('21',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red,
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: [Color.fromRGBO(255, 214, 15, 1),Color.fromRGBO(255, 155, 0, 1), ],
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Align(
                                                child:Image.asset('assets/images/onevone.png',height:150,width: 150 ),
                                                alignment: Alignment.center,
                                              ),

                                              Column(
                                                children: [
                                                  Padding(padding: EdgeInsets.only(top: 10),child: Card(
                                                    semanticContainer: true,
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    margin: EdgeInsets.all(10),
                                                    elevation: 5,
                                                    child:Container(

                                                      child: Center(
                                                        child:
                                                        Text("ورژن",style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16),),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            colors: [purplecolor,themeColor],
                                                          )
                                                      ),
                                                      width: 120,
                                                      height: 50,
                                                    ),
                                                  ),),
                                                  Container(
                                                    child: Center(
                                                      child: Text('21',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red,
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: [Color.fromRGBO(255, 214, 15, 1),Color.fromRGBO(255, 155, 0, 1), ],
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              alignment: Alignment.topCenter,
                            ),
                           Padding(
                             padding: EdgeInsets.only(bottom: 10),
                             child:  Container(
                             child: MaterialSegmentedControl(
                               horizontalPadding: EdgeInsets.all(1),
                               verticalOffset: 15,
                               selectionIndex: _currentSelection,
                               borderColor: Colors.transparent,
                               selectedColor:Colors.cyan ,
                               unselectedColor:  purplecolor,
                               borderRadius: 30.0,
                               children: _children,
                               onSegmentChosen: (index) {
                                 setState(() {
                                   _currentSelection = index;
                                   tabController.index = index;
                                 });
                               },),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(30)),
                                 border: Border.all(color: Colors.white,width: 3)
                             ),
                           ),
                           ),
                            Expanded(
                              child: new TabBarView(
                                  controller: tabController,
                                  children: <Widget>[
                                    new  OneVOneMatchPage.none(),
                                    new SendTicket.none()
                                  ]),),
                          ],
                        ),

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
        ) : new Center(child: CircularProgressIndicator(),);
      },
    );
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    loadfuture = Category();
  }
  Category() async {
    try {
      Response response = await Dio().post("http://jamq.ir:3000/onevsonematches/SelectCategory");
      print(response);
      return true;
    } catch (e) {
      print(e);
    }
  }
}