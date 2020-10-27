
import 'package:aho_corasick/aho_corasick.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
class TestClass extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestState();
  }

}

class TestState extends State<TestClass>{

  @override
  void initState() {
    // TODO: implement initState

    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    var pink = Color.fromRGBO(249, 211, 248, 1);
    var themeColor = Color.fromRGBO(19, 2, 102, 1);
    var purplecolor = Color.fromRGBO(80, 0, 131,1);
    double width = MediaQuery.of(context).size.width;
    double c_width = MediaQuery.of(context).size.width*0.4;
    double c_height = MediaQuery.of(context).size.height*0.4;
    double P_width = MediaQuery.of(context).size.width*0.8;
    double P_height = MediaQuery.of(context).size.height*0.8;

    var profback = AssetImage('assets/images/profback.png');
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/aboutusport.jpg'),
                fit: BoxFit.fill)
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
            margin: EdgeInsets.all(10),
            elevation: 10,
            child:Container(
              width: P_width,
              height: P_height,
              color:Colors.white,
              child: Column(
                children: [
                  Padding(
                    child: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius: 60,
                      backgroundImage:  profback,
                    ),
                    padding: EdgeInsets.only(top: 20),
                  ),
                  CustomCheckBoxGroup(
                    unSelectedColor: Theme.of(context).canvasColor,
                    buttonLables: [
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                    ],
                    buttonValuesList: [
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                    ],
                    checkBoxButtonValues: (values) {
                      print(values);
                    },
                    defaultSelected: ["Monday"],
                    horizontal: true,
                    width: 120,
                    // hight: 50,
                    selectedColor: Theme.of(context).accentColor,
                    padding: 5,
                    spacing: 0.0,
                    // enableShape: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }






}