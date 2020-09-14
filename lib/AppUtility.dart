import 'dart:io';

import 'package:dio/dio.dart';

class AppUtility{

  CheckInternet() async {
    var State = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        State = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      State = false;
    }
    return State;
  }


  CheckApplicationAvilability() async{
    FormData formData = FormData.fromMap({
    });
    try {
      Response response = await Dio().post("http://jamq.ir:3000/Mainapp/ApplicationState",data:formData);
      var AVIsAvilable = response.data['AVIsAvilable'];
     return response.data;
    } catch (e) {
      print(e);
    }
  }
  }
