import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jalali_date/jalali_date.dart';
import 'package:jamqpwa/TransactionList.dart';
import 'MainPage.dart';
import 'UserInfoClass.dart';

class TransactionDetails extends StatefulWidget{
  var UIC;
  var TrId;

  TransactionDetails(this.UIC,this.TrId);

  TransactionDetails.none();


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TransactionDetailsState();
  }

}
class TransactionDetailsState extends State<TransactionDetails>{
  UserInfoClass UserInfo ;
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  var StateColor = Color.fromRGBO(1, 1, 1,1);
  List Data;
  Future loadfuture;
  var appScaff;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadfuture = GetTicketDetails();
    UserInfo = new UserInfoClass(widget.UIC);
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.2;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double c_height = MediaQuery.of(context).size.height*0.3;
    // TODO: implement build
    return new FutureBuilder(
        future:loadfuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ?
          new Scaffold(body: new  LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
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
                                      'جزییات خرید',
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
                                        child:   Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/transactiondetailsland.png'), fit: BoxFit.fill)))
                                    ),
                                  ),),
                                  Center(
                                    child: Padding(padding:EdgeInsets.only(top: 60,left: 50,right: 70), child:SingleChildScrollView(
                                      child:  Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(padding: EdgeInsets.only(top:60),child: Row(  children: [
                                            Text(
                                              'تاریخ تراکنش',
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
                                              PersianDate.fromGregorianString(Convertdate(Data[0]['TCCreationDate'])).toString(),
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
                                              'قیمت',
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
                                              Data[0]['TCPrice'].toString()+' هزار تومان',
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
                                              'کد تخفیف',
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
                                              CheckVoucher(Data[0]['TCVoucher'].toString()),
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
                                              'نوع پکیج',
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
                                              Data[0]['TCPackageName'],
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
                                              'وضعیت',
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
                                              TransactionState(Data[0]['TCState']),
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: StateColor,
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
                                          Padding(padding: EdgeInsets.only(top: 20),child:Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/images/Transactiondetailpic.png',width: c_width,)

                                            ],
                                          ),),

                                        ],
                                      ),
                                    ),),
                                  )
                                ],
                              ),)
                          ),
                        ],
                      )
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
                                      'جزییات خرید',
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
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: TransactionList(widget.UIC))),(Route<dynamic> route) => false);
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
                                        child:   Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/transactiondetailsport.png'), fit: BoxFit.fill)))
                                    ),
                                  ),),
                                  Padding(padding:EdgeInsets.only(top: 80), child:SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                          ],
                                        ),
                                        Center(
                                          child: Padding(padding:EdgeInsets.only(top: 60,left: 50,right: 70), child:
                                          SingleChildScrollView(
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(padding: EdgeInsets.only(top:60),child: Row(  children: [
                                                  Text(
                                                    'تاریخ تراکنش',
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
                                                    PersianDate.fromGregorianString(Convertdate(Data[0]['TCCreationDate'])).toString(),
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
                                                    'قیمت',
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
                                                   Data[0]['TCPrice']+  ' هزار تومان',
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
                                                    'کد تخفیف',
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
                                                    CheckVoucher(Data[0]['TCVoucher']),
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
                                                    'نوع پکیج',
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
                                                    Data[0]['TCPackageName'],
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
                                                    'وضعیت',
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
                                                    TransactionState(Data[0]['TCState']),
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: StateColor,
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
                                                Padding(padding: EdgeInsets.only(top: 20),child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset('assets/images/Transactiondetailpic.png',width: c_height,)

                                                  ],
                                                ),),
                                              ],
                                            ),
                                          ),),
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
  Convertdate(String Date){
    var DateArray =  Date.split('/');
    var DateForConvert = DateArray[0]+''+DateArray[1]+''+DateArray[2];

    print(DateForConvert);
    return DateForConvert;
  }

  CheckVoucher(String voucher){
    if(voucher == 'NoVoucher'){
      return 'ندارد';
    }else{
      return 'دارد';
    }

  }

  TransactionState(var state){
    if(state){
      StateColor = Color.fromRGBO(0, 100, 0, 1);
      return "موفق";

    }else{
      StateColor = Color.fromRGBO(100, 0, 0, 1);
      return "ناموفق";
    }



  }


  GetTicketDetails() async {
    try {
      FormData formData = FormData.fromMap({
        "reqid":widget.TrId,
      });
      Response response = await Dio().post("http://jamq.ir:3000/Transaction/GetTransactionsByTransactionId",data: formData);
      print(response);
      Data = response.data;
      return Data;
    } catch (e) {
      print(e);
    }
  }

}
