import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamqpwa/MainPage.dart';
import 'UserInfoClass.dart';
class Invite extends StatefulWidget{

  var UIC;


  Invite(this.UIC);


  Invite.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InviteState();

  }

}
class InviteState extends State<Invite>{
  var inviteCode='.';
  UserInfoClass UserInfo ;
  Future loadfuture;
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
    loadfuture = GetInviteCode();

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body:  new FutureBuilder(
        future:loadfuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ?  new Scaffold(body: Stack(
            children: <Widget>[
              new Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/inviteback.png'),
                        fit: BoxFit.fill)
                ),
              ),
              Align(
                child: Padding(padding: EdgeInsets.only(top:40),child:
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 15),child:Text(
                          'کد دعوت و اشتراک گذاری',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'MyFont'
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(left: 15),child:InkWell(
                          child:Image.asset('assets/images/backico.png',height: 40,width: 40,),
                          onTap: (){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(widget.UIC))),(Route<dynamic> route) => false);
                          },
                        ) )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 60,left: 25,right: 25),child:   Column(
                      children: <Widget>[
                        Text(
                          UserInfo.GetName()+' عزیز کد معرفی خود را برای دوستان خود ارسال کنید و جایزه بگیرید',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                              fontFamily: 'MyFont'
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),),
                    Padding(padding: EdgeInsets.only(top: 40,right: 60),child: Row(children: <Widget>[Text('کد معرف',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),)],),),
                    Padding(padding: EdgeInsets.only(),
                      child:
                      Stack(children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 60,right: 60,),child:Container(
                          height: 55,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            border: Border.all(color: themeColor,width: 2)
                          ),
                          child:Stack(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 20),child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                               Text(inviteCode)
                              ],),)
                          ],
                        ),

                      ),
                        ),
                      ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top:60),child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(right: 0),child: InkWell(
                              child:  Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                margin: EdgeInsets.all(10),
                                elevation: 5,
                                child:Container(
                                  width: 200,
                                  height: 70,
                                  color: Colors.deepPurple,
                                  child: Center(
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("اشتراک گذاری",style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontWeight:FontWeight.bold ,fontSize: 24),),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              onTap: (){

                              },
                            )),
                          ],
                        ),)
                      ],
                    )
                  ],
                ),
                ),
                alignment: Alignment.topCenter,
              ),

              Align(
                child: Padding(padding: EdgeInsets.only(bottom:35),child:Image.asset('assets/images/pepole.png',),
                ),
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),) : new Center(child: CircularProgressIndicator(),);

        },),
    );

  }


  GetInviteCode() async {
    try {
      FormData formData = FormData.fromMap({
        "usernumber": UserInfo.GetPhoneNumber(),
      });
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetInvitionCode",data: formData);
      print(response);
      setState(() {
        inviteCode = response.data[0]['ICInvitionCode'];
      });
      return true;
    } catch (e) {
      print(e);
    }
  }
}

