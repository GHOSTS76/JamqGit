
import 'package:flutter/material.dart';
import 'package:jamqpwa/Invite.dart';
import 'package:jamqpwa/Ticket.dart';
import 'package:jamqpwa/Wallet.dart';

import 'AboutUs.dart';
import 'Profile.dart';
import 'TransactionList.dart';

Drawer BuildDrawerLayout(BuildContext context,var userdata){
  return new Drawer(
    child: Container(
      child:new ListView(
        children: <Widget>[
          new DrawerHeader(
              padding : EdgeInsets.zero,
              child: Image.asset('assets/images/applogo.png',width: 150,height: 150,),
          ),

          new ListTile(
            leading:
            ImageIcon(
              AssetImage("assets/images/dwallet.png"),
              color: Colors.white,
            ),
            title: new Text('کیف پول',style:TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
            )),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:Wallet(userdata))),(Route<dynamic> route) => false);

            },
          ),

          new ListTile(
            leading:
            ImageIcon(
              AssetImage("assets/images/dsendticket.png"),
              color: Colors.white,
            ),
            title: new Text('تیکت ها',style:TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:Tickets(userdata))),(Route<dynamic> route) => false);
            },
          ),
          new ListTile(
            leading:
            ImageIcon(
              AssetImage("assets/images/dwatchad.png"),
              color: Colors.white,
            ),
            title: new Text('مشاهده تبلیغ ',style:TextStyle(
              fontSize: 18,
              color: Colors.white,
                fontWeight: FontWeight.bold
            )),
            onTap: (){

            },
          ),
          new ListTile(
            leading: ImageIcon(
              AssetImage("assets/images/dscores.png"),
              color: Colors.white,
            ),
            title: new Text('مشاهده امتیازات',style:TextStyle(
              fontSize: 18,
              color: Colors.white,
                fontWeight: FontWeight.bold
            )),
            onTap: (){

              
            },
          ),
          new ListTile(
            leading:  ImageIcon(
              AssetImage("assets/images/dtransactions.png"),
              color: Colors.white,
            ),
            title: new Text('مشاهده تراکنش ها',style:TextStyle(
              fontSize: 18,
              color: Colors.white,
                fontWeight: FontWeight.bold
            )),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:TransactionList(userdata))),(Route<dynamic> route) => false);

            },
          ),
          new ListTile(
            leading:  ImageIcon(
              AssetImage("assets/images/daboutus.png"),
              color: Colors.white,
            ),
            title: new Text('درباره ما',style:TextStyle(
              fontSize: 18,
              color: Colors.white,
                fontWeight: FontWeight.bold
            )),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  Aboutus(userdata))),(Route<dynamic> route) => false);


            },
          ),
          new ListTile(
            leading:  ImageIcon(
              AssetImage("assets/images/dinvitecode.png"),
              color: Colors.white,
            ),
            title: new Text('کد دعوت و اشتراک گذاری',style:TextStyle(
              fontSize: 18,

              color: Colors.white,
                fontWeight: FontWeight.bold
            )),
            onTap: (){

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>new Directionality(textDirection: TextDirection.rtl, child:  Invite(userdata))),(Route<dynamic> route) => false);

            },
          ),
        ],
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/drawerbkg.jpg'),
              fit: BoxFit.fill)
      ),
    )
  );

}
