import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html';
class PaymentResult extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentResultState();
  }
}
class PaymentResultState extends State<PaymentResult>{


  var url ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url =  window.location.href;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  new Scaffold(
      body:  Container(
        width: width,
        height: height,
        child: Center(
          child: new Text(url),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/shopback.jpg'),
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
