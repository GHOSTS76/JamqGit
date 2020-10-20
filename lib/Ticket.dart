import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jalali_date/jalali_date.dart';
import 'package:jamqpwa/MainPage.dart';
import 'package:jamqpwa/SendTicket.dart';
import 'package:jamqpwa/TicketDetails.dart';
import 'UserInfoClass.dart';

class Tickets extends StatefulWidget{
  var UIC;


  Tickets(this.UIC);

  Tickets.none();


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TicketState();
  }

}
class TicketState extends State<Tickets>{
  UserInfoClass UserInfo ;
  List data;
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  Future loadfuture;
  var appscaffold;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
    loadfuture = GetAboutUsData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return new FutureBuilder(
     future:loadfuture,
     builder: (BuildContext context, AsyncSnapshot snapshot) {
       return snapshot.hasData ?  new Scaffold(
         body: appscaffold,
       ) : new Center(child: CircularProgressIndicator(),);
     },
   );
  }


  GetAboutUsData() async {
    try {
      FormData formData = FormData.fromMap({
        "TkUserId":UserInfo.GetPhoneNumber(),
      });
      Response response = await Dio().post("http://jamq.ir:3000/Ticket/GetTicketById",data: formData);

      if(response.data == 'Ticket Does Not Exist!!!'){
        appscaffold = Scaffold(body: Stack (
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/aboutusport.jpg'),
                      fit: BoxFit.fill)
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50),child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              margin: EdgeInsets.all(10),
              elevation: 5,
              child:Container(
                color: Colors.white,
                child: Center(
                  child:
                  Text("ورژن",style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20),),
                ),
              ),
            ),),

            Padding(padding: EdgeInsets.only(top: 10,left: 5,right: 5),child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 15),child:Text(
                  'پیغام های پشتیبانی',
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
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(widget.UIC))),(Route<dynamic> route) => false);
                  },
                ) )
              ],
            ),),
            Align(
              child: Padding(padding: EdgeInsets.only(bottom: 20,right: 20),child:  Row(
                children: [
                  FloatingActionButton(onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: SendTicket(widget.UIC))),(Route<dynamic> route) => false);
                  },
                      backgroundColor: themeColor,child: Center(
                        child:Padding(
                          child:  Image.asset('assets/images/plussign.png'),
                          padding: EdgeInsets.all(10),
                        ),
                      )),
                ],
              )),
              alignment: Alignment.bottomRight,),
            Center(child: Text('تیکتی وجود ندارد',style:TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),)
          ],
        ));
        return 'NotExist';
      }else
        {
          data = response.data;
        appscaffold = Scaffold(body: Stack(
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/aboutusport.jpg'),
                      fit: BoxFit.fill)
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50),child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                margin: EdgeInsets.all(10),
                elevation: 5,
                child:Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Center(
                        child:
                        Text("ورژن",style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20),),
                      ),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context,int index){
                          return  new Padding(padding: EdgeInsets.all(20),child: Card(
                            child: InkWell(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Row(children: [
                                          Padding(padding: EdgeInsets.only(right: 10),
                                            child:
                                            Text(
                                              'عنوان',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'MyFont'
                                              ),
                                            ),

                                          ),
                                          Text(
                                            ":",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: 'MyFont'
                                            ),
                                          ),
                                          Text(
                                            data[index]['TkTitle'],
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: 'MyFont'
                                            ),
                                          ),
                                        ],
                                        ),
                                        height: 50,
                                        color: themeColor,
                                      ),
                                      Column(
                                        children: [
                                          Padding(padding: EdgeInsets.only(top: 10),child:  Row(children: [
                                            Padding(padding: EdgeInsets.only(right: 10),
                                              child:
                                              Text(
                                                'تاریخ',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'MyFont'
                                                ),
                                              ),

                                            ),
                                            Text(
                                              ":",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'MyFont'
                                              ),
                                            ),
                                            Text(
                                              PersianDate.fromGregorianString(Convertdate(data[index]['TkCreationDate'])).toString(),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'MyFont'
                                              ),
                                            ),
                                          ],
                                          ),),
                                          Padding(padding: EdgeInsets.only(top: 10),child:  Row(children: [
                                            Padding(padding: EdgeInsets.only(right: 10),
                                              child:
                                              Text(
                                                'متن',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'MyFont'
                                                ),
                                              ),

                                            ),
                                            Text(
                                              ":",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'MyFont'
                                              ),
                                            ),
                                            Text(
                                              data[index]['TkText'],
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'MyFont'
                                              ),
                                            ),
                                          ],
                                          ),),
                                          Padding(padding: EdgeInsets.only(top: 10),child:  Row(children: [
                                            Padding(padding: EdgeInsets.only(right: 10),
                                              child:
                                              Text(
                                                'وضعیت',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'MyFont'
                                                ),
                                              ),

                                            ),
                                            Text(
                                              ":",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'MyFont'
                                              ),
                                            ),
                                            Text(
                                              Isopened(data[index]['TkIsOpened']),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'MyFont'
                                              ),
                                            ),
                                          ],
                                          ),),
                                          Padding(padding: EdgeInsets.only(top: 10),child:  Row(children: [
                                            Padding(padding: EdgeInsets.only(right: 10),
                                              child:
                                              Text(
                                                'پاسخ داده شده',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'MyFont'
                                                ),
                                              ),

                                            ),
                                            Text(
                                              ":",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'MyFont'
                                              ),
                                            ),
                                            Text(
                                              Responsed(data[index]['TkResponse']),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'MyFont'
                                              ),
                                            ),
                                          ],
                                          ),),
                                        ],
                                      )
                                    ],
                                  ),
                                  height: 200,
                                  color:purplecolor,
                                ),
                                onTap: () {
                                  GotoDetails(data[index]["_id"]);
                                }
                            ),
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            margin: EdgeInsets.all(10),
                            elevation: 5,
                            color: Colors.white,

                          ),);
                        }
                    ),
                  ],
                )
            ),),
            Align(
              child: Padding(padding: EdgeInsets.only(bottom: 20,right: 20),child:  Row(
                children: [
                  FloatingActionButton(onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: SendTicket(widget.UIC))),(Route<dynamic> route) => false);
                  },
                      backgroundColor: themeColor,child: Center(
                        child:Padding(
                          child:  Image.asset('assets/images/plussign.png'),
                          padding: EdgeInsets.all(10),
                        ),
                      )),
                ],
              )),
              alignment: Alignment.bottomRight,),
            Padding(padding: EdgeInsets.only(top: 10,left: 5,right: 5),child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 15),child:Text(
                  'پیغام های پشتیبانی',
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
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(widget.UIC))),(Route<dynamic> route) => false);
                  },
                ) )
              ],
            ),),
          ],
        ));
        return data;
      }

    } catch (e) {
      print(e);
    }
  }

  GotoDetails(TicketId){

   Navigator.push(context, MaterialPageRoute(builder: (context) => new Directionality(textDirection: TextDirection.rtl, child:TicketDetails(widget.UIC,TicketId))));
  }
  Isopened(var state){
    if(state){
      return "باز";
    }else{
      return "بسته";
    }

  }
  Responsed(var state){

    if(state=="" || state == null || state == 'Def'){
      return "خیر";
    }else{
      return "بلی";
    }

  }
  Convertdate(String Date){
    var DateArray =  Date.split('/');
    var DateForConvert = DateArray[0]+''+DateArray[1]+''+DateArray[2];
    print('DADD');print(DateForConvert);
    return DateForConvert;
  }
}

