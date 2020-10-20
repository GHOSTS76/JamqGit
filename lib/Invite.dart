import 'package:clipboard/clipboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
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
    double c_width = MediaQuery.of(context).size.width*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double c_height = MediaQuery.of(context).size.height*0.8;
    // TODO: implement build
    return new FutureBuilder(
      future:loadfuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData ?
        new Scaffold(body: new LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
                return Container(
                    decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/aboutusland.jpg'), fit: BoxFit.fill)),
                  child: Stack(
                    children: [
                      Align(
                        child: Padding(padding: EdgeInsets.only(top:20,right: 20),child:
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(),child:Text(
                                  'کد دعوت و اشتراک گذاری',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'MyFont'
                                  ),
                                ),),
                                Padding(padding: EdgeInsets.only(left: 0),child:InkWell (
                                  child:Image.asset('assets/images/backico.png',height: 40,width: 40,),
                                  onTap: (){
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(widget.UIC))),(Route<dynamic> route) => false);
                                  },
                                ) )
                              ],
                            ),
                          ],
                        ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      Align(
                          child: Padding(padding: EdgeInsets.only(top: 20),child: Stack(
                            children: <Widget>[
                              Card(
                                color: Colors.transparent,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                margin: EdgeInsets.all(10),
                                child:Container(
                                    child:   Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/sendticketbackland.png'), fit: BoxFit.fill)))
                                ),
                              ),
                              Padding(padding:EdgeInsets.only(top: 80), child:Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        UserInfo.GetName()+ ' عزیز کد معرفی خود را برای دوستانتان ارسال کرده و جایزه بگیرید ',
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                            color: themeColor,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Padding(padding:EdgeInsets.only(top:100),child: Row(children: <Widget>[
                                            Padding(padding: EdgeInsets.only(top: 15,right: 20),child: Text('کد دعوت',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),),)
                                          ],
                                          ),),
                                          Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),child:Container(
                                            height: 55,
                                            width: 400,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                                border: Border.all(color: Color.fromRGBO(19, 2, 102, 1),width: 2)
                                            ),
                                            child:Stack(
                                              children: <Widget>[
                                                Padding(padding: EdgeInsets.only(top: 10),child:  Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    new Text(inviteCode,style:TextStyle(fontSize: 26,color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                                  ],
                                                ),)],),
                                          ),),
                                          Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 50),child: InkWell(
                                              child: Container(
                                                height: 60,
                                                width: 220,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: purplecolor,
                                                ),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    new Text('اشتراک گذاری',style:TextStyle(fontSize: 26,color: Colors.white,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              ),
                                              onTap: (){

                                              }
                                          ),),
                                          Container(
                                            child: Image.asset('assets/images/pepole.png',width: c_width,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              )
                            ],
                          ),)
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/aboutusport.jpg'),
                          fit: BoxFit.fill)
                  ),
                  child:Stack(
                    children: [
                      Align(
                        child: Padding(padding: EdgeInsets.only(top:20,right: 20),child:
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(),child:Text(
                                  'کد دعوت و اشتراک گذاری',
                                  style: TextStyle(
                                      fontSize: 18.0,
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
                          ],
                        ),//کد دعوت و اشتراک گذاری
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      Align(
                        child:Padding(padding: EdgeInsets.only(top: 60),child:  Stack(
                          children: <Widget>[
                            Card(
                              color: Colors.transparent,
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              margin: EdgeInsets.all(10),
                              child:Container(child:   Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/sendticketback.png'), fit: BoxFit.fill)),)),
                            ),
                            Padding(padding:EdgeInsets.only(top: 80), child:SingleChildScrollView(
                              child:Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          UserInfo.GetName()+ ' عزیز کد معرفی خود را برای دوستانتان ارسال کرده و جایزه بگیرید ',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: themeColor,
                                              fontFamily: 'MyFont'
                                          ),
                                        ),
                                        width: c_width,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Padding(padding:EdgeInsets.only(top:100),child: Row(children: <Widget>[
                                            Padding(padding: EdgeInsets.only(top: 15,right: 20),child: Text('کد دعوت',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),),)
                                          ],
                                          ),),
                                          Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),child:Container(
                                            height: 55,
                                            width: 400,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                                border: Border.all(color: Color.fromRGBO(19, 2, 102, 1),width: 2)
                                            ),
                                            child:Stack(
                                              children: <Widget>[
                                                Padding(padding: EdgeInsets.only(top: 10),child:  Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    new Text(inviteCode,style:TextStyle(fontSize: 26,color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                                  ],
                                                ),)
                                              ],
                                            ),
                                          ),
                                          ),
                                          Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 50),child:
                                          InkWell(
                                              child: Container(
                                                height: 60,
                                                width: 220,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: purplecolor,
                                                ),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    new Text('اشتراک گذاری',style:TextStyle(fontSize: 26,color: Colors.white,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              ),
                                              onTap: (){
                                                FlutterClipboard.copy(UserInfo.GetName()+ ' عزیز کد معرفی خود را برای دوستانتان ارسال کرده و جایزه بگیرید '+'\n' + inviteCode + 'کد دعوت شما').then(( value ) => Fluttertoast.showToast(
                                                    msg: "کد دعوت شما کپی شد.",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                ));
                                              }
                                          ),),

                                        ],
                                      ),

                                    ],
                                  ),
                                  Image.asset('assets/images/pepole.png',width: P_width,)
                                ],
                              ),

                            )
                            ),
                          ],
                        ),)
                      ),
                    ],
                  )
                );
              }
            }
        ),	) : new Center(child: CircularProgressIndicator(),);

      });

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
        print(inviteCode);
      });
      return 'true';
    } catch (e) {
      print(e);
    }
  }
}

