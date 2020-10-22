import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shop extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopState();
  }

}
class ShopState extends State<Shop>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: SizedBox(

          child: Shimmer.fromColors(
            baseColor: Colors.deepPurple,
            highlightColor: Colors.yellowAccent,
            child: Text(
              'تا مسابقه بعدی',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
  GetUserInfo() async {
    FormData formData = FormData.fromMap({
      "usernumber":'9337335323',
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainuser/GetUserInfoByPhone",data:formData);
      print('LALOLAODLAO');
      print(response.data[0][0]['Email']);
    } catch (e) {
      print(e);
    }
  }
}