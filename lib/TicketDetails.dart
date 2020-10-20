import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jalali_date/jalali_date.dart';
import 'package:jamqpwa/Ticket.dart';
import 'MainPage.dart';
import 'UserInfoClass.dart';

class TicketDetails extends StatefulWidget{
  var UIC,ticketid;


  TicketDetails(this.UIC,this.ticketid);

  TicketDetails.none();


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TicketDetailsState();
  }

}
class TicketDetailsState extends State<TicketDetails>{
  UserInfoClass UserInfo ;
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  var ISOpendColor ;
  Future loadfuture;
  var appScaff;
  var Title,TicketText,OpratorResponse,ResponseDate,CreationDate,IsOpened;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
    loadfuture = GetTicketDetails();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.3;
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
                                    'جزییات تیکت',
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
                        Card(
                          color: Colors.transparent,
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          margin: EdgeInsets.all(10),
                          child:Container(
                              child:   Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/ticketdetailsland.png'), fit: BoxFit.fill)))
                          ),
                        ),
                        Padding(padding:EdgeInsets.only(top: 120), child:SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/ticketdetail.png',width: c_width,)
                                ],
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top:20),child: Row(children: [
                                      Text(
                                        'عنوان',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                      Text(
                                        ':',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                      Text(
                                        Title,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 20),child: Container(
                                      height: 1,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top:20),child: Row(children: [
                                      Text(
                                        'تاریخ',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                      Text(
                                        ':',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                      Text(
                                        PersianDate.fromGregorianString(CreationDate).toString(),
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 20),child: Container(
                                      height: 1,
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top:20),child: Row(children: [
                                      Text(
                                        'پاسخ',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                    ],
                                    ),),
                                    Padding(padding: EdgeInsets.only(top: 20),child:Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          border: Border.all(color: purplecolor,width: 5)
                                      ),
                                      child:Column(

                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.only(top: 10),child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(padding: EdgeInsets.only(right: 10),child: new Text(OpratorResponse,style:TextStyle(fontSize: 18,color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold,),),),

                                            ],
                                          ),),
                                          Row(
                                            children: [
                                              Padding(padding: EdgeInsets.only(right: 10),child: new Text(PersianDate.fromGregorianString(ResponseDate).toString(),style:TextStyle(fontSize: 18,color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold,),),)
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.end,
                                          ),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                    ),),
                                    Padding(padding: EdgeInsets.only(top:20),child: Row(children: [
                                      Text(
                                        'پاسخ',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                      Text(
                                        ':',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                      Text(
                                        IsOpened,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: ISOpendColor,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                    ],
                                    ),),
                                  ],
                                ),
                                width: P_width,
                              )
                            ],
                          ),
                        ),),
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
                                      'جزییات تیکت',
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
                              child: Padding(padding: EdgeInsets.only(top: 20),child: Stack(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(top: 40),child: Card(
                                    color: Colors.transparent,
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    child:Container(
                                        child:   Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/ticketdetails.png'), fit: BoxFit.fill)))
                                    ),
                                  ),),
                                  Padding(padding:EdgeInsets.only(top: 80), child:SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/images/ticketdetail.png',width: P_width,)
                                          ],
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Padding(padding: EdgeInsets.only(top:20),child: Row(children: [
                                                Text(
                                                  'عنوان',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                                Text(
                                                  ':',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                                Text(
                                                  Title,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                              ],
                                              ),),
                                              Padding(padding: EdgeInsets.only(top: 20),child: Container(
                                                height: 1,
                                                child: Divider(
                                                  thickness: 2,
                                                  color: Colors.black45,
                                                ),
                                              ),),
                                              Padding(padding: EdgeInsets.only(top:20),child: Row(children: [
                                                Text(
                                                  'تاریخ',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                                Text(
                                                  ':',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                                Text(
                                                  PersianDate.fromGregorianString(CreationDate).toString(),
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                              ],
                                              ),),
                                              Padding(padding: EdgeInsets.only(top: 20),child: Container(
                                                height: 1,
                                                child: Divider(
                                                  thickness: 2,
                                                  color: Colors.black45,
                                                ),
                                              ),),
                                              Padding(padding: EdgeInsets.only(top:20),child: Row(children: [
                                                Text(
                                                  'پاسخ',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                              ],
                                              ),),
                                              Padding(padding: EdgeInsets.only(top: 20),child:Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    border: Border.all(color: purplecolor,width: 5)
                                                ),
                                                child:Column(

                                                  children: <Widget>[
                                                    Padding(padding: EdgeInsets.only(top: 10),child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Padding(padding: EdgeInsets.only(right: 10),child: new Text(OpratorResponse,style:TextStyle(fontSize: 18,color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold,),),),

                                                      ],
                                                    ),),
                                                     Row(
                                                      children: [
                                                        Padding(padding: EdgeInsets.only(right: 10),child: new Text(PersianDate.fromGregorianString(ResponseDate).toString(),style:TextStyle(fontSize: 18,color: themeColor,fontFamily: 'MyFont',fontWeight: FontWeight.bold,),),)
                                                      ],
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                    ),
                                                  ],
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                ),
                                              ),),
                                              Padding(padding: EdgeInsets.only(top:20),child: Row(children: [
                                                Text(
                                                  'پاسخ',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                                Text(
                                                  ':',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                                Text(
                                                  IsOpened,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: ISOpendColor,
                                                      fontFamily: 'MyFont'
                                                  ),
                                                ),
                                              ],
                                              ),),
                                            ],
                                          ),
                                          width: P_width,
                                        )
                                      ],
                                    ),
                                  ),
                                  )
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
  Isopened(var state){
    if(state){
      ISOpendColor = Colors.green;
      return "باز";
    }else{
      ISOpendColor = Colors.red;
      return "بسته";
    }

  }
  Responsed(var state){

    if(state=="" || state == null || state == 'Def'){
      return "پاسخی داده نشده است";
    }else{
      return state;
    }

  }
  Convertdate(String Date){
    var DateArray =  Date.split('/');
    var DateForConvert = DateArray[0]+''+DateArray[1]+''+DateArray[2];
    print('DADD');print(DateForConvert);
    return DateForConvert;
  }

  GetTicketDetails() async {
    var TicketID = widget.ticketid;
    print('ALOHA ' + widget.ticketid);
    try {
      FormData formData = FormData.fromMap({
        "TicketId": TicketID,
      });
      Response response = await Dio().post("http://jamq.ir:3000/Ticket/GetTicketByTicketId",data: formData);
      print('TicketRes---->> '+response.data.toString());
     IsOpened = Isopened(response.data[0]['TkIsOpened']);
     OpratorResponse = Responsed(response.data[0]['TkResponse'].toString());
     CreationDate= Convertdate(response.data[0]['TkCreationDate']).toString();
     ResponseDate= Convertdate(response.data[0]['TkResponseDate']).toString();
     Title =  response.data[0]['TkTitle'].toString();
     TicketText = response.data[0]['TkText'].toString();

      setState(() {

      });
      return 'true';
    } catch (e) {
      print(e);
    }
  }

}
