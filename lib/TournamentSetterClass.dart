class TournamentSetter{
  var TournamentData;
  var SpecialLeage= [],SpeedLeage= [],TodayOne= [],TodayTwo= [],TomorowOne= [],TomorowTwo= [];
  TournamentSetter(this.TournamentData){
    for(var counter = 0 ;counter < TournamentData.length;counter++) {
      if (TournamentData[counter]['TrType'] == 'SpecialLeage') {
       // SeparateData[0] = TournamentData[counter];
        SpecialLeage.add(TournamentData[counter]);
      } else if (TournamentData[counter]['TrType'] == 'SpeedLeage') {
        SpeedLeage.add(TournamentData[counter]);
      } else if (TournamentData[counter]['TrType'] == 'TodayOne') {
        TodayOne.add(TournamentData[counter]);
      } else if (TournamentData[counter]['TrType'] == 'TodayTwo') {
        TodayTwo.add(TournamentData[counter]);
      } else if (TournamentData[counter]['TrType'] == 'TomorrowOne') {
        TomorowOne.add(TournamentData[counter]);
      } else if (TournamentData[counter]['TrType'] == 'TomorrowTwo') {
        TomorowTwo.add(TournamentData[counter]);
      }

    }

  }
  String GetSpecialLeageData(Type) {
    if (Type == 'Id') {
     return SpecialLeage[0]['_id'];
    } else if (Type == 'Title') {
      return SpecialLeage[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return SpecialLeage[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {
      return SpecialLeage[0]['TrPrize'];

    } else if (Type == 'TrExpireDate') {
      return SpecialLeage[0]['TrExpireDate'];

    } else if (Type == 'Time') {
      return SpecialLeage[0]['TrEndTime'].toString();

    } else if (Type == 'Icon') {
      return SpecialLeage[0]['TrIcon'];
    }else if(Type == 'Category'){
      return SpecialLeage[0]['TrCategoryName'];
    }else if(Type == 'Text'){
      return SpecialLeage[0]['TrText'];
    }
  }

  String GetSpeedLeageData(Type) {
    if (Type == 'Id') {
      return SpeedLeage[0]['_id'];
    } else if (Type == 'Title') {
      return SpeedLeage[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return SpeedLeage[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {

      return SpeedLeage[0]['TrPrize'];

    } else if (Type == 'Time') {
      return SpeedLeage[0]['TrEndTime'];

    } else if (Type == 'TrExpireDate') {
      return SpeedLeage[0]['TrExpireDate'];

    } else if (Type == 'Icon') {
      return SpeedLeage[0]['TrIcon'];

    }else if(Type == 'Category'){
      return SpeedLeage[0]['TrCategoryName'];
    }else if(Type == 'Text'){
      return SpeedLeage[0]['TrText'];
    }
  }
  String GetTodayOne(Type) {

    if (Type == 'Id') {
      return TodayOne[0]['_id'];
    } else if (Type == 'Title') {
      return TodayOne[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return TodayOne[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {
      return TodayOne[0]['TrPrize'];

    } else if (Type == 'Time') {
      return TodayOne[0]['TrEndTime'];

    }  else if (Type == 'TrExpireDate') {
      return TodayOne[0]['TrExpireDate'];

    } else if (Type == 'Icon') {
      return TodayOne[0]['TrIcon'];

    }else if(Type == 'Category'){
      return TodayOne[0]['TrCategoryName'];
    }else if(Type == 'Text'){
      return TodayOne[0]['TrText'];
    }
  }
  String GetTodayTwo(Type) {
    if (Type == 'Id') {
      return TodayTwo[0]['_id'];
    } else if (Type == 'Title') {
      return TodayTwo[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return TodayTwo[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {
      return TodayTwo[0]['TrPrize'];

    } else if (Type == 'TrExpireDate') {
      return TodayTwo[0]['TrExpireDate'];

    } else if (Type == 'Time') {
      return TodayTwo[0]['TrEndTime'];

    } else if (Type == 'Icon') {
      return TodayTwo[0]['TrIcon'];

    }else if(Type == 'Category'){
      return TodayTwo[0]['TrCategoryName'];

    }else if(Type == 'Text'){
      return TodayTwo[0]['TrText'];
    }
  }
  String GetTomorrowOne(Type) {
    if (Type == 'Id') {
      return TomorowOne[0]['_id'];
    } else if (Type == 'Title') {
      return TomorowOne[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return TomorowOne[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {
      return TomorowOne[0]['TrPrize'];

    } else if (Type == 'Prize') {
      return TomorowOne[0]['TrExpireDate'];

    } else if (Type == 'Time') {
      return TomorowOne[0]['TrStartTime'];

    } else if (Type == 'Icon') {
      return TomorowOne[0]['TrIcon'];

    }else if(Type == 'Category'){
      return TomorowOne[0]['TrCategoryName'];

    }else if(Type == 'Text'){
      return TomorowOne[0]['TrText'];
    }
  }
  String GetTomorrowTwo(Type) {
    if (Type == 'Id') {
      return TomorowTwo[0]['_id'];
    } else if (Type == 'Title') {
      return TomorowTwo[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return TomorowTwo[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {
      return TomorowTwo[0]['TrPrize'];

    }else if (Type == 'Prize') {
      return TomorowTwo[0]['TrExpireDate'];

    } else if (Type == 'Time') {
      return TomorowTwo[0]['TrStartTime'];

    } else if (Type == 'Icon') {
      return TomorowTwo[0]['TrIcon'];

    }else if(Type == 'Category'){
      return TomorowTwo[0]['TrCategoryName'];
    }else if(Type == 'Text'){
      return TomorowTwo[0]['TrText'];
    }
  }
}