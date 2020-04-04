import 'package:covid19/layout/master_detail.dart';
import 'package:covid19/layout/master_detail_ita.dart';
import 'package:covid19/layout/master_detail_usa.dart';
import 'package:covid19/view/list_usa_states.dart';
import 'package:covid19/view/single_int_report.dart';
import 'package:covid19/view/list_ita_regioni.dart';
import 'package:covid19/view/single_ita_report.dart';
import 'package:covid19/view/single_ita_reg_report.dart';
import 'package:covid19/view/single_usa_states_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19',
      theme: ThemeData(
        primaryColor: Colors.grey[400],
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == SingleIntReportView.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return SingleIntReportView(country: settings.arguments);
            },
          );
        } else 
        if (settings.name == MasterDetailPageUSA.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return MasterDetailPageUSA(country: settings.arguments);
            },
          );
        } else 
        if (settings.name == ListUSAStatesView.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return ListUSAStatesView(null , settings.arguments);
            },
          );
        } else 
        if (settings.name == SingleUSAStatesReportView.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return SingleUSAStatesReportView(state: settings.arguments);
            },
          );
        } else 
        if (settings.name == MasterDetailPageITA.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return MasterDetailPageITA(selectedCountry: settings.arguments);
            },
          );
        } else 
        if (settings.name == ListITARegioniView.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return ListITARegioniView(null , settings.arguments);
            },
          );
        } else 
        if (settings.name == SingleITAReportView.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return SingleITAReportView(country: settings.arguments);
            },
          );
        } else 
        if (settings.name == SingleITARegReportView.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return SingleITARegReportView(provincia: settings.arguments);
            },
          );
        } else 
        return null;
      },
      routes: {
        '/': (context) => MasterDetailPage(),
      },
    );
  }


}
