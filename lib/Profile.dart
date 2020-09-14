

import 'package:flutter/material.dart';

class profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }

}
class ProfileState extends State<profile>{
    var picdef = AssetImage('assets/images/profileic.png');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                    image:picdef,
                    fit: BoxFit.cover)
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 150,left: 15,right: 15,bottom: 15),child: new Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.all(10),
            elevation: 5,
            child:Container(
              child:Column(
                children: <Widget>[
                Row(children: <Widget>[
                  Image.asset('assets/images/name.png',width: 50,height: 50,),
                ],
                )
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color.fromRGBO(82, 2, 133, 1),Color.fromRGBO(7, 15, 87, 1), ],
                  )
              ),
            ),
          ),),
          Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 80),child: Align(
                  alignment: Alignment.topCenter,
                  child:
                  Column(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          radius: 80,
                          child:CircleAvatar(
                            radius:75,
                            backgroundImage: picdef
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 100),child: InkWell(
                          child: Image.asset('assets/images/cam.png',height: 60,width: 60,),
                          onTap: () async {
                            try{
                             await selectPic();
                            }catch(e)
                            {
                              print('FFFFFF  '+e.toString());
                            }
                          },
                        ))
                      ],
                    )
                  ],
                  )
              ),
              ),
            ],
          )

        ],
      )
    );
  }

    selectPic() async{

    }
}