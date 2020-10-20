import 'dart:convert';

class UserInfoClass{
   var  data;
  UserInfoClass(this.data);


  String GetName(){
    return data[0][0]['Name'].toString();
}



String GetId(){
    return data[0][0]['_id'].toString();
  }

  String GetUserName(){
    return data[0][0]['UserName'].toString();
  }
  String GetFamily(){
    return data[0][0]['Family'].toString();
  }
  String GetPhoneNumber(){
    return data[0][0]['PhoneNumber'].toString();
  }
  String GetIsBanned(){
    return data[0][0]['IsBanned'].toString();
  }
  String GetProiflePic(){
    return data[0][0]['ProfilePicture'].toString();
  }
  String GetEmail(){
    return data[0][0]['Email'].toString();
  }
  String GetGender(){
    return data[0][0]['Gender'].toString();
  }
  String GetBirthDate(){
    return data[0][0]['BirthDate'].toString();
  }
  String GetIsOnline(){
    return data[0][0]['IsOnline'].toString();
  }
  String GetCoinAmount(){
    return data[1][0]['CAmount'].toString();
  }
   String GetExtraLifeAmount(){
     return data[2][0]['ELAmount'].toString();
   }
   String GetScoreAmount(){
     return data[3][0]['SCUserScore'].toString();
   }
}

