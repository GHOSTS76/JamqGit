import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamqpwa/SplashScreen.dart';
import 'package:url_launcher/url_launcher.dart';
class PayBrowser extends StatefulWidget{

  var Url;
  PayBrowser(this.Url);
  PayBrowser.none();


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return PayBrowserState();

  }

}
class PayBrowserState extends State<PayBrowser>{
  Future<void> _launched;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _launched = _launchInBrowser(widget.Url);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new FutureBuilder(
        future:_launched,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot);

          return snapshot.hasData ?
          new Scaffold(
            body:  Container(
                width: width,
                height: height,
                child: Center(
                  child: new Text(snapshot.toString()),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/shopback.jpg'),
                        fit: BoxFit.fill),
                ),
            ),
          ) : new Center(child: CircularProgressIndicator(),);

        });
  }



  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,

      );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  SplashScreen())),(Route<dynamic> route) => false);
    } else {

      throw 'Could not launch $url';
    }
  }



}
