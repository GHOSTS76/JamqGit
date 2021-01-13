import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:jalali_date/jalali_date.dart';
import 'package:jamqpwa/MainPage.dart';
import 'package:jamqpwa/transactiondetails.dart';
import 'UserInfoClass.dart';

class TransactionList extends StatefulWidget{

  var UIC;


  TransactionList(this.UIC);


  TransactionList.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TransactionListState();
  }

}
class TransactionListState extends State<TransactionList>{
  UserInfoClass UserInfo ;
  int fail  = 0,success = 0 ;
  var themeColor = Color.fromRGBO(19, 2, 102, 1);
  List data;
  var purplecolor = Color.fromRGBO(80, 0, 131,1);
  var StateColor = Color.fromRGBO(1, 1, 1,1);
  Future loadfuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo = new UserInfoClass(widget.UIC);
    loadfuture =GetTransactionList();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double c_width = MediaQuery.of(context).size.width*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double c_height = MediaQuery.of(context).size.height*0.8;
    final TitleController = TextEditingController();
    final Textcontroller = TextEditingController();
    // TODO: implement build
    return new FutureBuilder(
      future:loadfuture ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        var appscaffold;
        if(snapshot.hasData){
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
                          height: height,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(padding: EdgeInsets.only(right: 30,left: 30,top: 20),child:
                                Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'تعداد تراکنش ها',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: themeColor,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                      Text(
                                        'تراکنش های موفق',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: themeColor,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                      Text(
                                        'تراکنش های ناموفق',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: themeColor,
                                            fontFamily: 'MyFont'
                                        ),
                                      ),
                                    ],),
                                  Padding(padding: EdgeInsets.only(left: 30,right: 30,top: 30),child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: themeColor
                                          ),
                                          child: Center(
                                            child:  Text(data.length.toString(),style: TextStyle(fontSize: 20,fontFamily: 'MyFont',color: Colors.white ),),
                                          )
                                      ),
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: themeColor
                                          ),
                                          child: Center(
                                            child:  Text(success.toString(),style: TextStyle(fontSize: 20,fontFamily: 'MyFont',color: Colors.white ),),
                                          )
                                      ),
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: themeColor
                                          ),
                                          child: Center(
                                            child:  Text(fail.toString(),style: TextStyle(fontSize: 20,fontFamily: 'MyFont',color: Colors.white ),),
                                          )
                                      ),
                                    ],),),
                                  Padding(padding: EdgeInsets.only(top:20,right: 50,left: 50),child: Container(
                                    height: 1,
                                    child: Divider(
                                      thickness: 2,
                                      color: purplecolor,
                                    ),
                                  ),)
                                ],)
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
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            PersianDate.fromGregorianString(Convertdate(data[index]['TCCreationDate'])).toString(),
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
                                                              'پکیج',
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
                                                            data[index]['TCPackageName'],
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

                                                            TransactionState(data[index]['TCState']),
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.bold,
                                                                color: StateColor,
                                                                fontFamily: 'MyFont'
                                                            ),
                                                          ),
                                                        ],
                                                        ),),

                                                      ],
                                                    )
                                                  ],
                                                ),
                                                height: 150,
                                                color:purplecolor,
                                              ),
                                              onTap: () {
                                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child: TransactionDetails(widget.UIC,data[index]['_id']))),(Route<dynamic> route) => false);
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
                            ),
                          )
                      ),

                    ],
                  )
              ),),
              Padding(padding: EdgeInsets.only(top: 10,left: 5,right: 5),child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(right: 15),child:Text(
                    'تراکنش ها',
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
              ),),
            ],
          ));
        }else
        {
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
                    FloatingActionButton(onPressed: null,backgroundColor: themeColor,child: Center(
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
        }
        return snapshot.hasData ?  new Scaffold(
          body: appscaffold,
        ) : new Center(child: CircularProgressIndicator(),);
      },

    );

  }

  Convertdate(String Date){
    var DateArray =  Date.split('/');
    var DateForConvert = DateArray[0]+''+DateArray[1]+''+DateArray[2];

    print(DateForConvert);
    return DateForConvert;
  }

  TransactionState(var state){

    if(state){
      StateColor = Color.fromRGBO(0, 150, 0, 1);
      return "موفق";

    }else{
      StateColor = Color.fromRGBO(100, 0, 0, 1);
      return "ناموفق";
    }

  }

  GetTransactionList() async {
    FormData formData = FormData.fromMap({
      "usernumber":UserInfo.GetPhoneNumber(),
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Transaction/GetTransactionsById",data: formData);
      print(response);
      data = response.data;
      print(data.length);
      print('asasa');
      for(var i = 0;i < data.length; i++){
        print('Runs');
        print(data[i]['TCState']);
        if(data[i]['TCState']){
          print('BlaLoca');

          success = success +1;
        }else{
          print('Seraloca');
          fail = fail + 1;
        }
      }
      return true;
    } catch (e) {
      print(e);
    }
  }
}

