import 'package:dio/dio.dart';

class LiveClass{



Future<String> SendQuestion(QuestionId,MatchId,selectedChoice) async {
  FormData formData = FormData.fromMap({
    "QsId":QuestionId,
    "MatchId": MatchId,
    "TrueAnswer":selectedChoice,
  });
  try {
    Response response = await Dio().post("http://jamq.ir:3000/LiveMatch/QuestionAnalyzer",data:formData);

    if(response.data == 'TrueAnswer'){

      return 'True';
    }else if(response.data == 'WrongAnswer'){
      return 'False';
    }

  } catch (e) {
    print(e);
  }
}

}