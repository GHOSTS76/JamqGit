import 'package:clipboard/clipboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jamqpwa/MainPage.dart';
class Aboutus extends StatefulWidget{

  var UIC;


  Aboutus(this.UIC);


  Aboutus.none();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutUsState();
  }

}
class AboutUsState extends State<Aboutus>{
  var version='.',text='.',website='.',email='.';

  Future loadfuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadfuture = GetAboutUsData();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(

      body: new FutureBuilder(
        future:loadfuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ?
          new Scaffold(body: new LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if(constraints.maxWidth > 1080 || constraints.maxHeight > 1920) {
                  return Stack(
                    children: <Widget>[
                      new Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/aboutusland.jpg'),
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
                                  'درباره ما',
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
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(padding: EdgeInsets.only(top: 1),
                                child: Image.asset('assets/images/applogo.png',height: 250,width: 250,),),
                            ),
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:  Radius.circular(15),bottomLeft:  Radius.circular(15),topRight:  Radius.circular(15)),
                              ),
                              margin: EdgeInsets.all(10),
                              elevation: 5,
                              child:Container(
                                  width: width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          child: Padding(padding: EdgeInsets.only(top: 100),
                                            child:Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(35),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 5,
                                              child:Container(
                                                width: 150,
                                                height: 50,
                                                color: Colors.deepPurple,
                                                child: Center(
                                                  child:
                                                  Text("ورژن"+"  "+version,style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20),),
                                                ),
                                              ),
                                            ),

                                          ),
                                          alignment: Alignment.center,
                                        ),
                                        Align(
                                          child: Padding(padding: EdgeInsets.only(bottom: 100),
                                            child:   Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(35),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 5,
                                              child:Container(
                                                  width: 350,
                                                  height: 200,
                                                  color: Colors.deepPurple,
                                                  child: Align(
                                                    child:Padding(padding: EdgeInsets.only(top: 20),child:
                                                    Column(
                                                      children: <Widget>[
                                                        Text(text,style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20),),
                                                        Padding(padding: EdgeInsets.only(top:60),child:    Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Padding(padding: EdgeInsets.only(right: 20),child: InkWell(
                                                              child:  Card(
                                                                semanticContainer: true,
                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(35),
                                                                ),
                                                                margin: EdgeInsets.all(10),
                                                                elevation: 5,
                                                                child:Container(
                                                                  width: 130,
                                                                  height: 50,
                                                                  color: Colors.white,
                                                                  child: Center(
                                                                      child:
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Padding(padding: EdgeInsets.only(right:0),child:  Image.asset('assets/images/phoneblue.png',height: 30,width: 30,),),
                                                                          Text("وبسایت",style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),

                                                                        ],
                                                                      )
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: (){
                                                                FlutterClipboard.copy(website).then(( value ) => Fluttertoast.showToast(
                                                                    msg: "سایت کپی شد.",
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    gravity: ToastGravity.CENTER,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.red,
                                                                    textColor: Colors.white,
                                                                    fontSize: 16.0
                                                                ));
                                                              },
                                                            )),
                                                            Padding(padding: EdgeInsets.only(left: 20),child: InkWell(
                                                              child: Card(
                                                                semanticContainer: true,
                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(35),
                                                                ),
                                                                margin: EdgeInsets.all(10),
                                                                elevation: 5,
                                                                child:Container(
                                                                  width: 130,
                                                                  height: 50,
                                                                  color: Colors.white,
                                                                  child: Center(
                                                                      child:
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Image.asset('assets/images/emailblue.png',height: 30,width: 30,),
                                                                          Padding(padding: EdgeInsets.only(right: 5),child: Text('ایمیل',style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),)
                                                                        ],
                                                                      )
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: (){
                                                                FlutterClipboard.copy(email).then(( value ) => Fluttertoast.showToast(
                                                                    msg: "ایمیل کپی شد.",
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    gravity: ToastGravity.CENTER,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.red,
                                                                    textColor: Colors.white,
                                                                    fontSize: 16.0
                                                                ));
                                                              },
                                                            ))
                                                          ],
                                                        ),)
                                                      ],
                                                    )
                                                    ),
                                                    alignment: Alignment.topCenter,
                                                  )
                                              ),
                                            ),

                                          ),
                                          alignment: Alignment.bottomCenter,
                                        ),

                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),

                        ),
                        alignment: Alignment.topCenter,
                      ),



                    ],
                  );
                } else {
                  return Stack(
                    children: <Widget>[
                      new Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/aboutusport.jpg'),
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
                                  'درباره ما',
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
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(padding: EdgeInsets.only(top: 1),
                                child: Image.asset('assets/images/applogo.png',height: 250,width: 250,),),
                            ),
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:  Radius.circular(15),bottomLeft:  Radius.circular(15),topRight:  Radius.circular(15)),
                              ),
                              margin: EdgeInsets.all(10),
                              elevation: 5,
                              child:Container(
                                  width: width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          child: Padding(padding: EdgeInsets.only(top: 100),
                                            child:Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(35),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 5,
                                              child:Container(
                                                width: 150,
                                                height: 50,
                                                color: Colors.deepPurple,
                                                child: Center(
                                                  child:
                                                  Text("ورژن"+"  "+version,style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20),),
                                                ),
                                              ),
                                            ),

                                          ),
                                          alignment: Alignment.center,
                                        ),
                                        Align(
                                          child: Padding(padding: EdgeInsets.only(bottom: 100),
                                            child:   Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(35),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              elevation: 5,
                                              child:Container(
                                                  width: 350,
                                                  height: 200,
                                                  color: Colors.deepPurple,
                                                  child: Align(
                                                    child:Padding(padding: EdgeInsets.only(top: 20),child:
                                                    Column(
                                                      children: <Widget>[
                                                        Text(text,style: TextStyle(color: Colors.white,fontFamily: 'MyFont',fontSize: 20),),
                                                        Padding(padding: EdgeInsets.only(top:60),child:    Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Padding(padding: EdgeInsets.only(right: 20),child: InkWell(
                                                              child:  Card(
                                                                semanticContainer: true,
                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(35),
                                                                ),
                                                                margin: EdgeInsets.all(10),
                                                                elevation: 5,
                                                                child:Container(
                                                                  width: 130,
                                                                  height: 50,
                                                                  color: Colors.white,
                                                                  child: Center(
                                                                      child:
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Padding(padding: EdgeInsets.only(right:0),child:  Image.asset('assets/images/phoneblue.png',height: 30,width: 30,),),
                                                                          Text("وبسایت",style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),

                                                                        ],
                                                                      )
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: (){
                                                                FlutterClipboard.copy(website).then(( value ) => Fluttertoast.showToast(
                                                                    msg: "سایت کپی شد.",
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    gravity: ToastGravity.CENTER,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.red,
                                                                    textColor: Colors.white,
                                                                    fontSize: 16.0
                                                                ));
                                                              },
                                                            )),
                                                            Padding(padding: EdgeInsets.only(left: 20),child: InkWell(
                                                              child: Card(
                                                                semanticContainer: true,
                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(35),
                                                                ),
                                                                margin: EdgeInsets.all(10),
                                                                elevation: 5,
                                                                child:Container(
                                                                  width: 130,
                                                                  height: 50,
                                                                  color: Colors.white,
                                                                  child: Center(
                                                                      child:
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Image.asset('assets/images/emailblue.png',height: 30,width: 30,),
                                                                          Padding(padding: EdgeInsets.only(right: 5),child: Text('ایمیل',style: TextStyle(color: Colors.black,fontFamily: 'MyFont',fontSize: 20),),)
                                                                        ],
                                                                      )
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: (){
                                                                FlutterClipboard.copy(email).then(( value ) => Fluttertoast.showToast(
                                                                    msg: "ایمیل کپی شد.",
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    gravity: ToastGravity.CENTER,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.red,
                                                                    textColor: Colors.white,
                                                                    fontSize: 16.0
                                                                ));
                                                              },
                                                            ))
                                                          ],
                                                        ),)
                                                      ],
                                                    )
                                                    ),
                                                    alignment: Alignment.topCenter,
                                                  )
                                              ),
                                            ),

                                          ),
                                          alignment: Alignment.bottomCenter,
                                        ),

                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),

                        ),
                        alignment: Alignment.topCenter,
                      ),



                    ],
                  );
                }
              }
          ),	) : new Center(child: CircularProgressIndicator(),);

        }),
    );

  }

   GetAboutUsData() async {
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainapp/GetAboutUs");
      print(response);
      setState(() {
        text =response.data[0]['AUText'];
        version =response.data[0]['AUAppversion'];
        website =response.data[0]['AUWebsite'];
        email =response.data[0]['AUEmail'];
        print(text);
        print(version);
        print(website);
        print(email);
      });
      return true;
    } catch (e) {
      print(e);
    }
  }
}

