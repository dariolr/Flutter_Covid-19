import 'package:covid19/chart/italy_chart.dart';
import 'package:covid19/model/pcm.dart';
import 'package:covid19/view/single_ita_report.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SingleITARegReportView extends StatefulWidget {
  static const routeName = '/singleITARegReportView';
  final Nazionale provincia;
  SingleITARegReportView({Key key, @required this.provincia}) : super(key: key);
  @override
  _SingleITARegReportViewState createState() => _SingleITARegReportViewState();
}

class _SingleITARegReportViewState extends State<SingleITARegReportView> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final isLargeScreen = MediaQuery.of(context).size.width > 600;
      return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            leading: isLargeScreen ? new Container() : null,
            title: Text(widget.provincia.denominazioneRegione),
            backgroundColor: Colors.white,
            elevation: 1.0,
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Container(
                      color: Colors.grey[50],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            DetailITA(nazionale: widget.provincia),
                            ItalyStatsPieChart(stats: widget.provincia),
                          ])))));
    });
  }
}
