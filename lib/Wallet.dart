import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalali_date/jalali_date.dart';
import 'package:jamqpwa/MainPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'UserInfoClass.dart';

class Wallet extends StatefulWidget{
  var UIC;
  Wallet(this.UIC);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WalletState();
  }

}
class WalletState extends State<Wallet>{
  UserInfoClass UserInfo ;
  List RQdata;
  Future loadfuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
    loadfuture = GetCheckOutRequests();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double P_height = MediaQuery.of(context).size.height*0.45;
    double P_width = MediaQuery.of(context).size.width*0.9;
    double c_width = MediaQuery.of(context).size.width*0.8;
    var pink = Color.fromRGBO(249, 211, 248, 1);
    var themeColor = Color.fromRGBO(19, 2, 102, 1);
    var purplecolor = Color.fromRGBO(80, 0, 131,1);
    var Green = Color.fromRGBO(3, 170, 2,1);
    final CheckoutPrice = TextEditingController();
    // TODO: implement build
    return FutureBuilder(
        future:loadfuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ?
          new      Scaffold(
            body:  Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/shopback.jpg'),
                        fit: BoxFit.fill)
                ),
                child:Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Padding(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 15),child:InkWell(
                                child:Image.asset('assets/images/backico.png',height: 40,width: 40,),
                                onTap: (){
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: MainPage(widget.UIC))),(Route<dynamic> route) => false);
                                },
                              )
                              )
                            ],
                          ),
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              color: Colors.white,
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Container(
                                  width: P_width,
                                  height: P_height,
                                  child:SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Image.asset('assets/images/walletpic.png',width: 300,height: 300,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('موجودی حساب : '+UserInfo.GetWalletAmount() + 'تومان',style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 18,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        Padding(
                                          child: InkWell(
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(45),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 10,
                                              child:Container(
                                                width: 220,
                                                height: 50,
                                                color: purplecolor,
                                                child: Center(
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        InkWell(
                                                          child:   Text('درخواست تسویه',style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20),),
                                                          onTap: (){
                                                            Alert(
                                                                context: context,
                                                                title: "مبلغ مورد نظر خود را وارد نمایید",
                                                                content: Column(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      child:    TextField(
                                                                        controller: CheckoutPrice,
                                                                        textAlign: TextAlign.center,
                                                                        cursorColor: Colors.deepPurple,
                                                                        style: TextStyle(color: themeColor,fontSize: 16,fontFamily: 'MyFont',fontWeight: FontWeight.bold),
                                                                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,
                                                                          LengthLimitingTextInputFormatter(8),
                                                                        ],
                                                                        decoration: new InputDecoration(
                                                                            fillColor: themeColor,
                                                                            border: InputBorder.none,
                                                                            hintText: '- - - - - -',
                                                                            hintStyle: TextStyle(color:themeColor)
                                                                        ),
                                                                      ),
                                                                      padding: EdgeInsets.only(top: 10),
                                                                    )
                                                                  ],
                                                                ),
                                                                buttons: [
                                                                  DialogButton(
                                                                    onPressed:(){
                                                                      if(CheckoutPrice.text == null || CheckoutPrice.text == ''){
                                                                        Fluttertoast.showToast(
                                                                            msg: "مبلغ را وارد نمایید.",
                                                                            toastLength: Toast.LENGTH_SHORT,
                                                                            gravity: ToastGravity.CENTER,
                                                                            timeInSecForIosWeb: 1,
                                                                            backgroundColor: Colors.red,
                                                                            textColor: Colors.white,
                                                                            fontSize: 16.0
                                                                        );
                                                                      }else if(int.parse(CheckoutPrice.text) < 5000){
                                                                        Fluttertoast.showToast(
                                                                            msg: "مبلغ کمتر از حد مجاز کمتر است.",
                                                                            toastLength: Toast.LENGTH_SHORT,
                                                                            gravity: ToastGravity.CENTER,
                                                                            timeInSecForIosWeb: 1,
                                                                            backgroundColor: Colors.red,
                                                                            textColor: Colors.white,
                                                                            fontSize: 16.0
                                                                        );
                                                                      }else if(int.parse(CheckoutPrice.text)> int.parse(UserInfo.GetWalletAmount())){
                                                                        print(UserInfo.GetWalletAmount());
                                                                        print('fffff');
                                                                        Fluttertoast.showToast(
                                                                            msg: "مبلغ انتخابی بیشتر از کیف پول شماست .",
                                                                            toastLength: Toast.LENGTH_SHORT,
                                                                            gravity: ToastGravity.CENTER,
                                                                            timeInSecForIosWeb: 1,
                                                                            backgroundColor: Colors.red,
                                                                            textColor: Colors.white,
                                                                            fontSize: 16.0
                                                                        );
                                                                      }else{
                                                                        CheckOutRequest(UserInfo.GetPhoneNumber(),CheckoutPrice.text);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      "بررسی",
                                                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                                                    ),
                                                                    color: purplecolor,
                                                                  )
                                                                ]).show();
                                                          },
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ),
                                            onTap: (){

                                            },
                                          ),
                                          padding: EdgeInsets.only(top: 15),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: RQdata.length,
                            itemBuilder: (BuildContext context,int index){
                              return Padding(
                                child:  Card(
                                  color: Colors.white,
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(65),
                                  ),
                                  child: Container(
                                      width: c_width,
                                      height: 100,
                                      child:Padding(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(SetItemText(RQdata[index]['RQState']),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
                                            Text(SetItemDate(RQdata[index]['RQState'],RQdata[index]['RequestDate'],RQdata[index]['CheckoutDate']).toString(),style: TextStyle(color: themeColor,fontFamily: 'MyFont',fontSize: 16,fontWeight: FontWeight.bold),),
                                            InkWell(child: Image.asset(SetItemIcon(RQdata[index]['RQState']),width: 50,height: 50,),
                                              onTap: (){
                                                if(RQdata[index]['RQState'] == '0'){
                                                  DeclineRequest(RQdata[index]['_id']);
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                      )
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 20,right: 20),
                              );
                            }
                        ),
                      ],
                    ),

                  ],
                )
            ),
          ) : new Center(child: CircularProgressIndicator(),);
        });


  }


  GetCheckOutRequests() async {
    FormData formData = FormData.fromMap({
      "UserName":UserInfo.GetPhoneNumber(),
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetRequests",data: formData);
      print(response);
      RQdata = response.data;
      return true;
    } catch (e) {
      print(e);
    }
  }

  SetItemText(State){
    var ItemtextText = '';
    if(State=='0') {
      ItemtextText = 'در حال بررسی';
    }else if(State == '1'){
      ItemtextText = 'تسویه شده';
    }else if(State == '2'){
      ItemtextText = 'لغو مدیریت';
    }else if(State == '3'){
      ItemtextText = 'لغو کاربر';
    }
    return ItemtextText;
  }

  SetItemIcon(State){
    var ItemtextIco = '';
    if(State=='0'){
      ItemtextIco = 'assets/images/deleteico.png';
    }else if(State == '1'){
      ItemtextIco = 'assets/images/confirmico.png';
    }else if(State == '2'){
      ItemtextIco = 'assets/images/failico.png';
    }else if(State == '3'){
      ItemtextIco = 'assets/images/failico.png';
    }
    return ItemtextIco;
  }

  SetItemDate(State,RequestDate,CheckOutDate){
    var Date = '';
    if(State=='0'){
      Date = RequestDate;
    }else if(State == '1'){
      Date = CheckOutDate;
    }else if(State == '2'){
      Date = RequestDate;
    }else if(State == '3'){
      Date = RequestDate;
    }

    var DateArray =  Date.split('/');
    var DateForConvert = DateArray[0]+''+DateArray[1]+''+DateArray[2];

    return PersianDate.fromGregorianString(DateForConvert);
  }
  DeclineRequest(CheckId) async {
    FormData formData = FormData.fromMap({
      "CheckId":CheckId,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/DeclineRequest",data: formData);
      if(response.data == 'Declined'){
        RefreshData(UserInfo.GetPhoneNumber());
      }
    } catch (e) {
      print(e);
    }
  }
  CheckOutRequest(UserName,Price) async {
    FormData formData = FormData.fromMap({
      "UserName":UserName,
      "Price":Price,
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/MainUser/RequestCheckout",data: formData);
      switch(response.data){
        case 'WrongAmount':
          Fluttertoast.showToast(
              msg: "مبلغ صحیح نیست.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          break;

        case 'UserNotFound':
          Fluttertoast.showToast(
              msg: "لطفا دوباره وارد شوید",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          break;

        case 'RequestCreated':
          Fluttertoast.showToast(
              msg: "درخواست واریز شما ثبت شد",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          RefreshData(UserInfo.GetPhoneNumber());
          break;

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
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: Wallet(response.data))),(Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }
}