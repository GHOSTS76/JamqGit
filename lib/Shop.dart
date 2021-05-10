import 'dart:convert';
import 'dart:html';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jamqpwa/MainPage.dart';
import 'package:jamqpwa/PayBrowser.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'UserInfoClass.dart';


class Shop extends StatefulWidget{

  var UIC;


  Shop(this.UIC);

  Shop.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return ShopState();

  }

}
class ShopState extends State<Shop>{

  UserInfoClass UserInfo ;
  var selectedChoice = '99';
  var s= 0;
  var   selectedColor = Color.fromRGBO(80, 0, 131, 1);
  var   UnselectedColor = Colors.white;
  var _paymentUrl = null;
  final VoucherTextEdit = TextEditingController();
  final InputBuyedCode = TextEditingController();
  var OffPercent = 1;
  var TopPrice = 1;
  List InAppData,GoldenTicketInappData= [],BlueTicketInAppData= [],LifeInAppData= [];

  var VoucherButtonText = 'بررسی',VoucherButtonTextColor= Color.fromRGBO(80, 0, 131,1),VoucherButtonColor = Colors.white,VoucherState = false,Voucher='',Vouchertext = Colors.white,PriceText = Color.fromRGBO(80, 0, 131, 1);

  Future loadfuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
    loadfuture = InitInappitems();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double P_height = MediaQuery.of(context).size.height*0.6;
    double P_width = MediaQuery.of(context).size.width*0.6;
    var pink = Color.fromRGBO(249, 211, 248, 1);
    var themeColor = Color.fromRGBO(19, 2, 102, 1);
    var purplecolor = Color.fromRGBO(80, 0, 131,1);
    var Green = Color.fromRGBO(3, 170, 2,1);


    return new FutureBuilder(
        future:loadfuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ?
          new Scaffold(
            body:  Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/shopback.jpg'),
                      fit: BoxFit.fill)
              ),
              child: Container(
                height: height,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsets.only(right: 15),child: Text('فروشگاه',style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'MyFont',
                            fontSize: 20,
                          ),),),
                          Padding(padding: EdgeInsets.only(left: 15),child:InkWell(
                            child:Image.asset('assets/images/backico.png',height: 35,width: 35,),
                            onTap: (){
                              RefreshData(UserInfo.GetPhoneNumber());

                            },
                          ) )
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 0),
                        child:  Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.white
                                      ),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.only(right: 10),child: Text('فروشگاه',style: TextStyle(
                                            color: themeColor,
                                            fontFamily: 'MyFont',
                                            fontSize: 18,
                                          ),),),
                                          Padding(padding: EdgeInsets.only(left: 10),child: Image.asset('assets/images/shoplifeico.png',height: 35,width: 35,),)
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      child: Image.asset('assets/images/shopinnerico.png',height: 200,width: 150,),
                                      onTap: (){

                                      },
                                    ),
                                    Container(
                                      height: 50,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.white
                                      ),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.only(right: 10),child: Text('معاوضه',style: TextStyle(
                                            color: themeColor,
                                            fontFamily: 'MyFont',
                                            fontSize: 18,
                                          ),),),
                                          Padding(padding: EdgeInsets.only(left: 10),child: Image.asset('assets/images/chagecointojonico.png',height: 35,width: 35,),)
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Container(
                                  height: 2,
                                  child: Divider(
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                ),

                              ],
                            )
                        )
                    ),
                    Padding(child: Card(
                      color: themeColor,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      margin: EdgeInsets.all(10),
                      elevation: 10,
                      child:Container(
                        height: 50,
                        color: themeColor,
                        child: Center(
                            child:
                            Row(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(right: 15),child:  Text('کد تخفیف خود را وارد کنید',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                new Flexible(
                                  fit: FlexFit.loose,
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: TextField(
                                        controller: VoucherTextEdit,
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.deepPurple,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(8),
                                        ],
                                        style: TextStyle(color: Vouchertext,fontSize: 16,fontFamily: 'MyFont',fontWeight: FontWeight.bold),
                                        decoration: new InputDecoration(
                                            fillColor: Colors.white,
                                            border: InputBorder.none,
                                            hintText: '- - - - - -',
                                            hintStyle: TextStyle(color: Colors.white)
                                        ),
                                      )),
                                ),
                                Card(
                                  shadowColor: Colors.white,
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  elevation: 4,
                                  child:InkWell(
                                    child: Container(
                                      width: 80,
                                      height: 40,
                                      color:VoucherButtonColor,
                                      child: Center(
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(padding: EdgeInsets.only(right: 5),child:  Text(VoucherButtonText,style: TextStyle(color:VoucherButtonTextColor ,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                            ],
                                          )
                                      ),
                                    ),
                                    onTap: (){
                                      print(VoucherState);
                                      if(VoucherState){
                                        setState(() {
                                          VoucherButtonText = 'بررسی';
                                          VoucherButtonTextColor= purplecolor;
                                          VoucherButtonColor = Colors.white;
                                          Vouchertext = Colors.white;
                                          VoucherState = false;
                                          PriceText =  Color.fromRGBO(80, 0, 131, 1);
                                          Voucher='';
                                           OffPercent = 1;
                                           TopPrice = 1;
                                          VoucherTextEdit.clear();
                                        });

                                      }else{
                                        if(VoucherTextEdit.text == ''|| VoucherTextEdit.text == null){
                                          Fluttertoast.showToast(
                                              msg: "لطفا کد تخفیف را وارد کنید.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.yellowAccent,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else{
                                          CheckVoucher(VoucherTextEdit.text);
                                        }

                                      }
                                    },
                                  )
                                ),
                              ],
                            )
                        ),
                      ),
                    ),padding: EdgeInsets.only(left: 20,right: 20),),

                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      margin: EdgeInsets.all(10),
                      elevation: 10,
                      child:Container(
                        width: 250,
                        height: 40,
                        color: Colors.white,
                        child: Center(
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/goldticket.png',height: 50,width: 50),
                                Padding(padding: EdgeInsets.only(right: 5),child:  Text('بسته های بلیط طلایی',style: TextStyle(color: purplecolor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),

                              ],
                            )
                        ),
                      ),
                    ),
                    Container(
                      child:  Expanded(
                        child:    ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: GoldenTicketInappData.length,
                            itemBuilder: (BuildContext context,int index){
                              return  new Padding(padding: EdgeInsets.all(1),child: SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Card(
                                        child:Column(
                                          children: [
                                            Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(padding: EdgeInsets.only(right: 5),child:  Text( GoldenTicketInappData[index]['IACount']+' '+' بلیط اضافه',style: TextStyle(color: purplecolor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                  Image.asset(SetImage(int.parse(GoldenTicketInappData[index]['IACount']),'Gold'),height: 50,width: 50),
                                                  Padding(padding: EdgeInsets.only(right: 5),child:  Text(SetPrice(GoldenTicketInappData[index]['IAPrice']).toString()+' '+' تومان',style: TextStyle(color: PriceText,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                ],
                                              ),
                                              width: 200,
                                              color:Colors.white,
                                            ),
                                          ],
                                        ),
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight:  Radius.circular(0),bottomLeft:  Radius.circular(25),topRight:  Radius.circular(25)),
                                        ),
                                        margin: EdgeInsets.all(10),
                                        elevation: 5,
                                        color: Colors.white,
                                      ),
                                      InkWell(
                                        child: Card(
                                          semanticContainer: true,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight:  Radius.circular(25),bottomLeft:  Radius.circular(25),topRight:  Radius.circular(0)),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          elevation: 10,
                                          child:Container(
                                            height: 35,width: 200,
                                            color: Green,
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset('assets/images/shshopico.png',height: 25,width: 26),
                                                Padding(padding: EdgeInsets.only(right: 5),child:  Text('خرید',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                              ],
                                            ) ,
                                          ),
                                        ),
                                        onTap: (){
                                          if(VoucherTextEdit.text ==null || VoucherTextEdit.text == ''){
                                            PurchaseItem(GoldenTicketInappData[index]['_id'],'NoVoucher');
                                          }else{
                                            PurchaseItem(GoldenTicketInappData[index]['_id'],VoucherTextEdit.text);
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )
                              );
                            }
                        ),
                      ),
                    ),//بلیط  طلایی
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      margin: EdgeInsets.all(10),
                      elevation: 10,
                      child:Container(
                        width: 250,
                        height: 40,
                        color: Colors.white,
                        child: Center(
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/shoplifeico.png',height: 50,width: 50),
                                Padding(padding: EdgeInsets.only(right: 5),child:  Text('بسته های جون اضافه',style: TextStyle(color: purplecolor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),

                              ],
                            )
                        ),
                      ),
                    ),
                    Container(
                      child:  Expanded(
                        child:    ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: LifeInAppData.length,
                            itemBuilder: (BuildContext context,int index){
                              return  new Padding(padding: EdgeInsets.all(1),child: SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Card(
                                        child:Column(
                                          children: [
                                            Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(padding: EdgeInsets.only(right: 5),child:  Text( LifeInAppData[index]['IACount']+' '+' بلیط اضافه',style: TextStyle(color: purplecolor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                  Image.asset(SetImage(int.parse(LifeInAppData[index]['IACount']),'Life'),height: 50,width: 50),
                                                  Padding(padding: EdgeInsets.only(right: 5),child:  Text(SetPrice(LifeInAppData[index]['IAPrice']).toString()+' '+' تومان',style: TextStyle(color: PriceText,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                ],
                                              ),
                                              width: 200,
                                              color:Colors.white,
                                            ),
                                          ],
                                        ),
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight:  Radius.circular(0),bottomLeft:  Radius.circular(25),topRight:  Radius.circular(25)),
                                        ),
                                        margin: EdgeInsets.all(10),
                                        elevation: 5,
                                        color: Colors.white,
                                      ),
                                      InkWell(
                                        child: Card(
                                          semanticContainer: true,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight:  Radius.circular(25),bottomLeft:  Radius.circular(25),topRight:  Radius.circular(0)),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          elevation: 10,
                                          child:Container(
                                            height: 35,width: 200,
                                            color: Green,
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset('assets/images/shshopico.png',height: 25,width: 26),
                                                Padding(padding: EdgeInsets.only(right: 5),child:  Text('خرید',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                              ],
                                            ) ,
                                          ),
                                        ),
                                        onTap: (){
                                          if(VoucherTextEdit.text ==null || VoucherTextEdit.text == ''){
                                            PurchaseItem(LifeInAppData[index]['_id'],'NoVoucher');
                                          }else{
                                            PurchaseItem(LifeInAppData[index]['_id'],VoucherTextEdit.text);
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )
                              );
                            }
                        ),
                      ),
                    ),//جون اصافه
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      margin: EdgeInsets.all(10),
                      elevation: 10,
                      child:Container(
                        width: 250,
                        height: 40,
                        color: Colors.white,
                        child: Center(
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/blueticket.png',height: 50,width: 50),
                                Padding(padding: EdgeInsets.only(right: 5),child:  Text('بسته های بلیط ابی',style: TextStyle(color: purplecolor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),

                              ],
                            )
                        ),
                      ),
                    ),
                    Container(
                      child:  Expanded(
                        child:    ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: BlueTicketInAppData.length,
                            itemBuilder: (BuildContext context,int index){
                              return  new Padding(padding: EdgeInsets.all(1),child: SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Card(
                                        child:Column(
                                          children: [
                                            Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(padding: EdgeInsets.only(right: 5),child:  Text( BlueTicketInAppData[index]['IACount']+' '+' بلیط اضافه',style: TextStyle(color: purplecolor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                  Image.asset(SetImage(int.parse(BlueTicketInAppData[index]['IACount']),'Blue'),height: 50,width: 50),
                                                  Padding(padding: EdgeInsets.only(right: 5),child:  Text(SetPrice(BlueTicketInAppData[index]['IAPrice']).toString()+' '+'   تومان',style: TextStyle(color: PriceText,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),),
                                                ],
                                              ),
                                              width: 200,
                                              color:Colors.white,
                                            ),
                                          ],
                                        ),
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight:  Radius.circular(0),bottomLeft:  Radius.circular(25),topRight:  Radius.circular(25)),
                                        ),
                                        margin: EdgeInsets.all(10),
                                        elevation: 5,
                                        color: Colors.white,
                                      ),
                                      InkWell(
                                        child: Card(
                                          semanticContainer: true,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight:  Radius.circular(25),bottomLeft:  Radius.circular(25),topRight:  Radius.circular(0)),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          elevation: 10,
                                          child:Container(
                                            height: 35,width: 200,
                                            color: Green,
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset('assets/images/shshopico.png',height: 25,width: 26),
                                                Padding(padding: EdgeInsets.only(right: 5),child:  Text('خرید',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),),
                                              ],
                                            ) ,
                                          ),
                                        ),
                                        onTap: (){
                                          print(BlueTicketInAppData[index]['_id']);
                                          print('MVMVMVMV');
                                          if(VoucherTextEdit.text ==null || VoucherTextEdit.text == ''){
                                            PurchaseItem(BlueTicketInAppData[index]['_id'],'NoVoucher');
                                          }else{
                                            PurchaseItem(BlueTicketInAppData[index]['_id'],VoucherTextEdit.text);
                                          }

                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )
                              );
                            }
                        ),
                      ),
                    ),//بلیط آبی
                  ],
                ),
              )
            ),
          ) : new Center(child: CircularProgressIndicator(),);
        });
  }


  SetPrice(OriginalPrice){
    var IntPrice = OriginalPrice;

    if(TopPrice == 1 || OffPercent == 1){
      return IntPrice;
    }else {
      IntPrice = OffPercent / 100 * int.parse(OriginalPrice);
      if(TopPrice < IntPrice){
        IntPrice = TopPrice - IntPrice;
      }else{
        IntPrice = int.parse(OriginalPrice) - IntPrice;
      }
      print(IntPrice.toString());
      return IntPrice;
    }

  }

  PurchaseItem(InAppId,Voucher) async {

    FormData formData = FormData.fromMap({
      "inappid":InAppId,
      "Voucher":Voucher,
      "UserId":UserInfo.GetPhoneNumber(),
    });

    try {
      Response response = await Dio().post("http://jamq.ir:3000/InAppPayment/BuyInappItems",data: formData);
      print('BABARABARA');
      print(response.data);
      if(response.data == 'MerchentInvalid'){

      }else if(response.data == 'PayPortalError'){

      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:PayBrowser(response.data))),(Route<dynamic> route) => false);
      }

      return true;
    } catch (e) {
      print(e);
    }
  }

  RefreshData(Number) async {
    print('lAAAAAAAogin');
    FormData formData = FormData.fromMap({
      "usernumber":Number,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetUserInfoByPhone",data:formData);
      print(response.data);
      print('ASASa');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(response.data))),(Route<dynamic> route) => false);

    } catch (e) {
      print(e);
    }
  }

    InitInappitems() async {
      try {
        Response response = await Dio().post("http://jamq.ir:3000/InAppPayment/GetInAppItems");
        InAppData = response.data;
        print(InAppData.length);
        for(var Counter = 1;Counter <InAppData.length;Counter++){
          print(InAppData[Counter]['IAType']);
          print(InAppData[Counter]);

          switch(InAppData[Counter]['IAType']){

            case 'GoldenTicket' :
              {
                print('AAAAA'+InAppData[Counter].toString());
                GoldenTicketInappData.add(InAppData[Counter]);
              }
              break;
            case 'ExtraLife' :
              {
                LifeInAppData.add(InAppData[Counter]);
              }
              break;
            case 'BlueTicket' :
              {
                BlueTicketInAppData.add(InAppData[Counter]);
              }
              break;
          }
        }
        return true;
      } catch (e) {
        print(e);
      }
    }

  CheckVoucher(Vcode) async {
    FormData formData = FormData.fromMap({
      "VoucherID":Vcode,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/InAppPayment/CheckVoucher",data: formData);
      print(response.data);
      print('This IS RESponse');
     if(response.data == 'false'){
       Fluttertoast.showToast(
           msg: "کد تخفیف شما صحیح نمیباشد",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }else{

       var _ParsedData = await jsonDecode(response.data.toString());

        setState(() {
          print("GAGAGAGAGAGA");
          print(_ParsedData[0]);
          print(_ParsedData[1]);
          OffPercent =_ParsedData[0];
          TopPrice =_ParsedData[1];
          VoucherButtonText = 'حذف';
          VoucherButtonTextColor= Colors.white;
          VoucherButtonColor = Colors.red;
          VoucherState = true;
          Voucher=Vcode;
          VoucherTextEdit.text = Vcode;
          PriceText = Color.fromRGBO(3, 170, 2,1);
          Vouchertext = Color.fromRGBO(3, 170, 2,1);
        });
     }
    } catch (e) {
      print(e);
    }
  }

  SetImage(Count,ImageType){
    if(Count == 1){
      if(ImageType == 'Gold'){
        return 'assets/images/goldticket.png';
      }else if(ImageType == 'Blue'){
        return 'assets/images/blueticket.png';
      }else if(ImageType == 'Life'){
        return 'assets/images/shoplifeico.png';
      }
    }else if(Count <= 5){
      if(ImageType == 'Gold'){
        return 'assets/images/twogoldentcket.png';
      }else if(ImageType == 'Blue'){
        return 'assets/images/twoblueticket.png';
      }else if(ImageType == 'Life'){
        return 'assets/images/twolife.png';
      }
    }else if(Count > 5){
      if(ImageType == 'Gold'){
        return 'assets/images/threegoldenticket.png';
      }else if(ImageType == 'Blue'){
        return 'assets/images/threeblueticket.png';
      }else if(ImageType == 'Life'){
        return 'assets/images/threelife.png';
      }
    }
}


  InquiryCode(Code) async {

    print(Code);
    print(UserInfo.GetPhoneNumber());
    FormData formData = FormData.fromMap({
      "PurchasedCode":Code,
      "UserId":UserInfo.GetPhoneNumber(),
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/InAppPayment/InquiryPurchasedCode",data: formData);
      print(response.data);
      print('Fffff youuuu');
      switch(response.data){

        case 'Invalid':
          Alert(
          context: context,
          type: AlertType.error,
          title: "خطا",
          desc:  "کدی که وارد کردی اشتباهه",
          buttons: [
            DialogButton(
              child: Text(
                "باشه",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed:(){
                Navigator.pop(context);
              },
              color: selectedColor,
              radius: BorderRadius.circular(5.0),
            ),
          ],
        ).show();

        break;

        case 'UserDosentMatch':

          Alert(
            context: context,
            type: AlertType.error,
            title: "خطا",
            desc:  "کدی که وارد کردی متعلق به شما نیست",
            buttons: [
              DialogButton(
                child: Text(
                  "باشه",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed:(){
                  Navigator.pop(context);
                },
                color: selectedColor,
                radius: BorderRadius.circular(5.0),
              ),
            ],
          ).show();

          break;


        case 'CodeUsed':
          Alert(
            context: context,
            type: AlertType.warning,
            title: "خطلا",
            desc:  "کدی که وارد کردی قبلا استفاده شده",
            buttons: [
              DialogButton(
                child: Text(
                  "باشه",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed:(){
                  Navigator.pop(context);
                },
                color: selectedColor,
                radius: BorderRadius.circular(5.0),
              ),
            ],
          ).show();


          break;

        case 'PurchaseComplated':

          Alert(
            context: context,
            type: AlertType.success,
            title: "موفقیت آمیز",
            desc:  "خرید با موفقیت انجام شد و  به حسابت اضافه شد",
            buttons: [
              DialogButton(
                child: Text(
                  "باشه",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed:(){
                  Navigator.pop(context);

                },
                color: selectedColor,
                radius: BorderRadius.circular(5.0),
              ),
            ],
          ).show();

          break;
          case 'MerchentInvalid':

          Alert(
            context: context,
            type: AlertType.error,
            title: "خطا",
            desc:  "لطفا با پشتیبانی تماس بگیرید",
            buttons: [
              DialogButton(
                child: Text(
                  "باشه",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed:(){
                  Navigator.pop(context);
                },
                color: selectedColor,
                radius: BorderRadius.circular(5.0),
              ),
            ],
          ).show();

          break;

          case 'InvalidAuth':

          Alert(
            context: context,
            type: AlertType.error,
            title: "خطا",
            desc:  "پرداخت شما صحیح نمیباشد لطفا با پشتیبانی تماس بگیرید.",
            buttons: [
              DialogButton(
                child: Text(
                  "باشه",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed:(){
                  Navigator.pop(context);
                },
                color: selectedColor,
                radius: BorderRadius.circular(5.0),
              ),
            ],
          ).show();

          break;

  case 'AmountInvalid':

          Alert(
            context: context,
            type: AlertType.error,
            title: "خطا",
            desc:  "مبلغ پرداخت شما صحیح نمیباشد لطفا با پشتیبانی تماس بگیرید.",
            buttons: [
              DialogButton(
                child: Text(
                  "باشه",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed:(){
                  Navigator.pop(context);
                },
                color: selectedColor,
                radius: BorderRadius.circular(5.0),
              ),
            ],
          ).show();

          break;

          case 'UnexpectedError':

          Alert(
            context: context,
            type: AlertType.error,
            title: "خطا",
            desc:  "خطای غیرمنتظره لطفا با پشتیبانی تماس بگیرید.",
            buttons: [
              DialogButton(
                child: Text(
                  "باشه",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed:(){
                  Navigator.pop(context);
                },
                color: selectedColor,
                radius: BorderRadius.circular(5.0),
              ),
            ],
          ).show();

          break;


      }
    } catch (e) {
      print(e);
    }
  }
}
