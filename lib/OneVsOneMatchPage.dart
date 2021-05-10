import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'MainPage.dart';

class OneVOneMatchPage extends StatefulWidget{
  var matchId,Uic;
  OneVOneMatchPage(this.matchId,this.Uic);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OneVOneMatchPageState();
  }

}

class OneVOneMatchPageState extends State<OneVOneMatchPage>{

  @override
  Widget build(BuildContext context) {
    List Catdata;
    var themeColor = Color.fromRGBO(19, 2, 102, 1);
    var purplecolor = Color.fromRGBO(80, 0, 131,1);
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.4;
    double c_height = MediaQuery.of(context).size.height*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double P_height = MediaQuery.of(context).size.height*0.8;
    print(widget.matchId);
    print('__________');
    // TODO: implement build
    return Scaffold(
      body:Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/selectopport.jpg'),
                  fit: BoxFit.fill)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context,int index){
                    return  new Padding(padding: EdgeInsets.all(10),child: Container(
                        width: width,
                        height: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/rowbkg.png'),
                                fit: BoxFit.fill)
                        ),
                      child: Stack(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 45,left: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(padding: EdgeInsets.only(right: 10),child:  Text('نام بازیکن',style: TextStyle(color:themeColor,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'MyFont'),),),
                                  Image.asset('assets/images/rowtitle.png',height: 120,width: 120,),
                                  Padding(padding: EdgeInsets.only(left: 10),child:  Text('نام بازیکن',style: TextStyle(color:themeColor,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'MyFont'),),),

                                ],)
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 50,left: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(padding: EdgeInsets.only(right: 10),child:  Text('نام بازیکن',style: TextStyle(color:themeColor,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'MyFont'),),),
                                  Image.asset('assets/images/rowtitle.png',height: 120,width: 120,),
                                  Padding(padding: EdgeInsets.only(left: 10),child:  Text('نام بازیکن',style: TextStyle(color:themeColor,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'MyFont'),),),

                                ],)
                          ),

                        ],
                      ),
                    ));
                  }
              ),
            ],
          ),
      ),
    );
  }

  GetMatch(){

  }

  SetQuestiosStates(){

  }
  RefreshData(Number) async {
    FormData formData = FormData.fromMap({
      "usernumber":Number,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetUserInfoByPhone",data:formData);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(response.data))),(Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }
}