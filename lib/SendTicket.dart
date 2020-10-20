import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jamqpwa/MainPage.dart';

import 'Ticket.dart';
import 'UserInfoClass.dart';
class SendTicket extends StatefulWidget{

  var UIC;


  SendTicket(this.UIC);


  SendTicket.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SendTicketState();
  }

}
class SendTicketState extends State<SendTicket>{
  UserInfoClass UserInfo ;
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  final TitleController = TextEditingController();
  final Textcontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double c_height = MediaQuery.of(context).size.height*0.8;

    // TODO: implement build
    return new Scaffold(body: new LayoutBuilder(
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
                              'ارسال تیکت',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'MyFont'
                              ),
                            ),),
                            Padding(padding: EdgeInsets.only(left: 15),child:InkWell(
                              child:Image.asset('assets/images/backico.png',height: 40,width: 40,),
                              onTap: (){
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: Tickets(widget.UIC))),(Route<dynamic> route) => false);
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
                            child:Container(child:   Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/sendticketbackland.png'), fit: BoxFit.fill)),)),
                          ),
                          Padding(padding:EdgeInsets.only(top: 80), child:SingleChildScrollView(

                            child:Column(
                              children: [
                                Image.asset('assets/images/sendico.png',height: 300,width: 300,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('عنوان',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),)
                                      ],),
                                    Padding(padding: EdgeInsets.only(left: 70,right: 70,top: 20),child:Container(
                                      height: 55,
                                      width: 700,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          border: Border.all(color: Color.fromRGBO(19, 2, 102, 1),width: 3)
                                      ),
                                      child: Stack(
                                        children: <Widget>[

                                          Padding(padding: EdgeInsets.only(top: 5),child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              new Flexible(
                                                  fit: FlexFit.loose,
                                                  child: new Padding(padding: EdgeInsets.fromLTRB(40, 5, 40, 5),child: new TextField(
                                                    controller: TitleController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.text,
                                                    cursorColor: Colors.deepPurple,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(30),
                                                    ],
                                                    style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                                    decoration: new InputDecoration(
                                                      fillColor: Colors.black,
                                                      border: InputBorder.none,
                                                      hintText: 'عنوان درخواست شما',
                                                    ),
                                                  ))),
                                            ],
                                          ),)
                                        ],
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 20),child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                      Text('متن',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),)
                                    ],),),
                                    Padding(padding: EdgeInsets.only(left: 70,right: 70,top: 20),child:Container(
                                      height: 130,
                                      width: 700,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          border: Border.all(color: Color.fromRGBO(19, 2, 102, 1),width: 3)
                                      ),
                                      child: Stack(
                                        children: <Widget>[

                                          Padding(padding: EdgeInsets.only(top: 5),child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              new Flexible(
                                                  fit: FlexFit.loose,
                                                  child: new Padding(padding: EdgeInsets.fromLTRB(40, 5, 40, 5),child: new TextField(
                                                    controller: Textcontroller,
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.text,
                                                    cursorColor: Colors.deepPurple,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(10),
                                                    ],
                                                    style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                                    decoration: new InputDecoration(
                                                      fillColor: Colors.black,
                                                      border: InputBorder.none,
                                                      hintText: 'متن  درخواست شما',
                                                    ),
                                                  ))),
                                            ],
                                          ),)
                                        ],
                                      ),
                                    ),),
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
                                              new Text('ارسال',style:TextStyle(fontSize: 26,color: Colors.white,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          _openLoadingDialog(context);
                                          SendTicket();
                                        }
                                    ),),

                                  ],
                                ),
                              ],
                            ),

                          )
                          ),
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
                                'ارسال تیکت',
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
                                  Image.asset('assets/images/sendico.png',width: c_width,),
                                  Column(
                                    children: <Widget>[

                                      Padding(padding: EdgeInsets.only(right: 70),child:Row(children: [
                                        Text('عنوان',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),)
                                      ],),),
                                      Padding(padding: EdgeInsets.only(left: 70,right: 70,top: 20),child:Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            border: Border.all(color: Color.fromRGBO(19, 2, 102, 1),width: 3)
                                        ),
                                        child: Stack(
                                          children: <Widget>[

                                            Padding(padding: EdgeInsets.only(top: 5),child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                new Flexible(
                                                    fit: FlexFit.loose,
                                                    child: new Padding(padding: EdgeInsets.fromLTRB(40, 5, 40, 5),child: new TextField(
                                                      controller: TitleController,
                                                      textAlign: TextAlign.center,
                                                      keyboardType: TextInputType.text,
                                                      cursorColor: Colors.deepPurple,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(30),
                                                      ],
                                                      style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                                      decoration: new InputDecoration(
                                                        fillColor: Colors.black,
                                                        border: InputBorder.none,
                                                        hintText: 'عنوان درخواست شما',
                                                      ),
                                                    ))),
                                              ],
                                            ),)
                                          ],
                                        ),
                                      ),),
                                      Padding(padding: EdgeInsets.only(right: 70,top: 20),child:Row(children: [
                                        Text('متن',style: TextStyle(fontFamily: 'MyFont',fontSize: 20,color: Colors.black),)
                                      ],),),
                                      Padding(padding: EdgeInsets.only(left: 70,right: 70,top: 20),child:Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            border: Border.all(color: Color.fromRGBO(19, 2, 102, 1),width: 3)
                                        ),
                                        child: Stack(
                                          children: <Widget>[

                                            Padding(padding: EdgeInsets.only(top: 5),child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                new Flexible(
                                                    fit: FlexFit.loose,
                                                    child: new Padding(padding: EdgeInsets.fromLTRB(40, 5, 40, 5),child: new TextField(
                                                      controller: Textcontroller,
                                                      textAlign: TextAlign.center,
                                                      keyboardType: TextInputType.text,
                                                      cursorColor: Colors.deepPurple,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(10),
                                                      ],
                                                      style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'MyFont'),
                                                      decoration: new InputDecoration(
                                                        fillColor: Colors.black,
                                                        border: InputBorder.none,
                                                        hintText: 'متن  درخواست شما',
                                                      ),
                                                    ))),
                                              ],
                                            ),)
                                          ],
                                        ),
                                      ),),
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
                                                new Text('ارسال',style:TextStyle(fontSize: 26,color: Colors.white,fontFamily: 'MyFont',fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                          ),
                                          onTap: (){
                                            _openLoadingDialog(context);
                                            SendTicket();
                                          }
                                      ),),

                                    ],
                                  ),
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
    ));

  }
  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.only(top: 20,left: 10),child:  Text('...لطفا صبر کنید',style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: 'IRANSans'),),)
                ],
              )
          ),
        );
      },
    );
  }
  SendTicket() async {
    if(TitleController.text == '' || TitleController.text == null || Textcontroller.text == '' || Textcontroller.text == null){
      Fluttertoast.showToast(
          msg: "لطفا ورودی های خود را بررسی کنید.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{

      print(Textcontroller.text);
      print(Textcontroller.text);

      FormData formData = FormData.fromMap({
        "TkUserId": UserInfo.GetPhoneNumber(),
        "TkTitle": TitleController.text,
        "TkText" :Textcontroller.text
      });
      try {
        Response response = await Dio().post("http://jamq.ir:3000/Ticket/SendTicket",data: formData);

        if(response.data == 'TicketSend'){
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "تیکت شما با موفقیت ارسال شد.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else{
          Fluttertoast.showToast(
              msg: "تیکت شما با ارسال نشد لطفا دوباره امتحان فرمایید.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

        return true;
      } catch (e) {
        print(e);
      }
    }


  }
}

