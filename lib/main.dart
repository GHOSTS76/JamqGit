import 'package:flutter/material.dart';
import 'package:jamqpwa/Category.dart';
import 'package:jamqpwa/Invite.dart';
import 'package:jamqpwa/LiveMain.dart';
import 'package:jamqpwa/NextQuestion.dart';
import 'package:jamqpwa/OtherApps.dart';
import 'package:jamqpwa/PayBrowser.dart';
import 'package:jamqpwa/Question.dart';
import 'package:jamqpwa/SelectOpponent.dart';
import 'package:jamqpwa/TournamentMain.dart';
import 'package:jamqpwa/TournamentNextQuestion.dart';
import 'package:jamqpwa/TransactionList.dart';
import 'package:jamqpwa/transactiondetails.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'AboutUs.dart';
import 'InputNumber.dart';
import 'MainPage.dart';
import 'OneVsOneMatchMainPage.dart';
import 'PeymentResult.dart';
import 'Profile.dart';
import 'SendTicket.dart';
import 'Shop.dart';
import 'SplashScreen.dart';
import 'TicketDetails.dart';
import 'TournamentQuestion.dart';
import 'VerifyCode.dart';
import 'Ticket.dart';

void main() => runApp(JamQ());


class JamQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'جام کیو',
      debugShowCheckedModeBanner: false,
      initialRoute: "/SplashScreen",
        routes: {
          "/MainPage": (context) => new Directionality(textDirection: TextDirection.rtl, child: MainPage.none()),
          "/SplashScreen": (context) => new Directionality(textDirection: TextDirection.rtl, child: SplashScreen()),
          "/Pay": (context) => new Directionality(textDirection: TextDirection.rtl, child: PayBrowser.none()),
          "/PaymentResult": (context) => new Directionality(textDirection: TextDirection.rtl, child: PaymentResult()),
          "/InputNumber": (context) => new Directionality(textDirection: TextDirection.rtl, child: InputNumber()),
          "/tickets": (context) => new Directionality(textDirection: TextDirection.rtl, child: Tickets.none()),
          "/Question": (context) => new Directionality(textDirection: TextDirection.rtl, child: Question.none()),
          "/Category": (context) => new Directionality(textDirection: TextDirection.rtl, child: Category.none()),
          "/NextQuestion": (context) => new Directionality(textDirection: TextDirection.rtl, child: NextQuestion()),
          "/LiveMain": (context) => new Directionality(textDirection: TextDirection.rtl, child: LiveMain.none()),
          "/SelectOp": (context) => new Directionality(textDirection: TextDirection.rtl, child: SelectOpponent.none()),
          "/TrMain": (context) => new Directionality(textDirection: TextDirection.rtl, child: TournamentMain.none()),
          "/OtherApps": (context) => new Directionality(textDirection: TextDirection.rtl, child: TestClass()),
          "/SendTicket": (context) => new Directionality(textDirection: TextDirection.rtl, child: SendTicket.none()),
          "/Trnextqs": (context) => new Directionality(textDirection: TextDirection.rtl, child: Tournament.none()),
          "/TournamentQuestion": (context) => new Directionality(textDirection: TextDirection.rtl, child: TournamentQuestion.none()),
          "/VerifyCode": (context) => new Directionality(textDirection: TextDirection.rtl, child: VerifyCode('', '')),
          "/Shop": (context) => new Directionality(textDirection: TextDirection.rtl, child: new Directionality(textDirection: TextDirection.rtl, child: Shop.none())),
          "/OneVsOneMatch": (context) => new Directionality(textDirection: TextDirection.rtl, child: new Directionality(textDirection: TextDirection.rtl, child: OneVsOneMatch())),
          "/Profile": (context) => new Directionality(textDirection: TextDirection.rtl, child: new Directionality(textDirection: TextDirection.rtl, child: profile.none())),
          "/AboutUs": (context) => new Directionality(textDirection: TextDirection.rtl, child: new Directionality(textDirection: TextDirection.rtl, child: Aboutus.none())),
          "/invite": (context) => new Directionality(textDirection: TextDirection.rtl, child: new Directionality(textDirection: TextDirection.rtl, child: Invite.none())),
          "/TicketDetails": (context) => new Directionality(textDirection: TextDirection.rtl, child: new Directionality(textDirection: TextDirection.rtl, child: TicketDetails.none())),
          "/TransactionList": (context) => new Directionality(textDirection: TextDirection.rtl, child: new Directionality(textDirection: TextDirection.rtl, child: TransactionList.none())),
          "/TransactionDetails": (context) => new Directionality(textDirection: TextDirection.rtl, child: new Directionality(textDirection: TextDirection.rtl, child: TransactionDetails.none())),
        }
    );
  }
}

