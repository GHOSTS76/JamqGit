class TournamentSetter{
  var TournamentData;
  var SpecialLeage= [],SpeedLeage= [],TodayOne= [],TodayTwo= [],TomorowOne= [],TomorowTwo= [];
  TournamentSetter(this.TournamentData){
    for(var counter = 0 ;counter < TournamentData.length;counter++) {
      print('fdsfdlfdslfslsdlfsd');
      print(counter);
      print(TournamentData[counter]['TrType']);
      if (TournamentData[counter]['TrType'] == 'SpecialLeage') {
       // SeparateData[0] = TournamentData[counter];
        SpeedLeage.add(TournamentData[counter]);
        print('Yohahahaha');
      } else if (TournamentData[counter]['TrType'] == 'SpeedLeage') {
        SpecialLeage.add(TournamentData[counter]);
      } else if (TournamentData[counter]['TrType'] == 'TodayOne') {
        TodayOne.add(TournamentData[counter]);
      } else if (TournamentData[counter]['TrType'] == 'TodayTwo') {
        TodayTwo.add(TournamentData[counter]);
      } else if (TournamentData[counter]['TrType'] == 'TomorowOne') {
        TomorowOne.add(TournamentData[counter]);
      } else if (TournamentData[counter]['TrType'] == 'TomorowTwo') {
        TomorowTwo.add(TournamentData[counter]);
      }

    }

  }
  String GetSpecialLeageData(Type) {

    print('ASASASASasasasaS');


    if (Type == 'id') {
     return SpecialLeage[0]['_id'];
    } else if (Type == 'Title') {
      return SpecialLeage[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return SpecialLeage[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {
      return SpecialLeage[0]['TrPrize'];

    } else if (Type == 'Time') {
      return SpecialLeage[0]['TrStartTime'].toString();

    } else if (Type == 'Icon') {
      return SpecialLeage[0]['TrIcon'];
    }else if(Type == 'Category'){
      return SpecialLeage[0]['TrCategoryName'];
    }
  }

  String GetSpeedLeageData(Type) {
    if (Type == 'id') {
      return SpeedLeage[0]['_id'];
    } else if (Type == 'Title') {
      return SpeedLeage[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return SpeedLeage[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {

      return SpeedLeage[0]['TrPrize'];

    } else if (Type == 'Time') {
      return SpeedLeage[0]['TrStartTime'];

    } else if (Type == 'Icon') {
      return SpeedLeage[0]['TrIcon'];

    }else if(Type == 'Category'){
      return SpeedLeage[0]['TrCategoryName'];
    }
  }
  String GetTodayOne(Type) {
    if (Type == 'id') {
      return TodayOne[0]['_id'];
    } else if (Type == 'Title') {
      return TodayOne[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return TodayOne[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {
      return TodayOne[0]['TrPrize'];

    } else if (Type == 'Time') {
      return TodayOne[0]['TrStartTime'];

    } else if (Type == 'Icon') {
      return TodayOne[0]['TrIcon'];

    }else if(Type == 'Category'){
      return TodayOne[0]['TrCategoryName'];
    }
  }
  String GetTodayTwo(Type) {
    if (Type == 'id') {
      return TodayTwo[0]['_id'];
    } else if (Type == 'Title') {
      return TodayTwo[0]['TrTitle'];

    } else if (Type == 'PlayersInGame') {
      return TodayTwo[0]['TrPlayersInGame'].toString();

    } else if (Type == 'Prize') {
      return TodayTwo[0]['TrPrize'];

    } else if (Type == 'Time') {
      return TodayTwo[0]['TrStartTime'];

    } else if (Type == 'Icon') {
      return TodayTwo[0]['TrIcon'];

    }else if(Type == 'Category'){
      return TodayTwo[0]['TrCategoryName'];
    }
  }
}