
import 'package:flutter/material.dart';
import 'package:jamqpwa/Invite.dart';

import 'AboutUs.dart';

Drawer BuildDrawerLayout(BuildContext context,var userdata){
  return new Drawer(
    child: Container(
      color: Colors.purple,
      child:new ListView(
        children: <Widget>[
          new DrawerHeader(
              padding : EdgeInsets.zero,
              child:new Container(
                decoration: new BoxDecoration(
                    color: Colors.purple
                ),

              )
          ),
          new ListTile(
            leading:
            ImageIcon(
              AssetImage("assets/images/profileic.png"),
              color: Colors.white,
            ),
            title: new Text('دعوت از دوستان',style:TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  Invite(userdata))),(Route<dynamic> route) => false);
            },
          ),
          new ListTile(
            leading:
            ImageIcon(
              AssetImage("assets/images/profileic.png"),
              color: Colors.white,
            ),
            title: new Text('اخبار',style:TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
            onTap: (){
            },
          ),
          new ListTile(
            leading:
            ImageIcon(
              AssetImage("assets/images/profileic.png"),
              color: Colors.white,
            ),
            title: new Text('درباره ما',style:TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  Aboutus(userdata))),(Route<dynamic> route) => false);
            },
          ),
          new ListTile(
            leading: ImageIcon(
              AssetImage("assets/images/profileic.png"),
              color: Colors.white,
            ),
            title: new Text('تورنمنت ها ',style:TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
            onTap: (){},
          ),
          new ListTile(
            leading:  ImageIcon(
              AssetImage("assets/images/profileic.png"),
              color: Colors.white,
            ),
            title: new Text('رنکینگ',style:TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
            onTap: (){},
          ),
          new ListTile(
            leading:  ImageIcon(
              AssetImage("assets/images/profileic.png"),
              color: Colors.white,
            ),
            title: new Text('تنظیمات',style:TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
            onTap: (){


            },
          ),
          new ListTile(
            leading:  ImageIcon(
              AssetImage("assets/images/profileic.png"),
              color: Colors.white,
            ),
            title: new Text('پشتیبانی',style:TextStyle(
              fontSize: 16,

              color: Colors.white,
            )),
            onTap: (){},
          ),
        ],
      ),
    )
  );

}
