import 'package:covid19/chart/chart.dart';
import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/view/single_int_report.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SingleUSAStatesReportView extends StatefulWidget {
  static const routeName = '/singleUSAStatesReportView';
  final States state;
  SingleUSAStatesReportView({Key key, @required this.state}) : super(key: key);
  @override
  _SingleUSAStatesReportViewState createState() =>
      _SingleUSAStatesReportViewState();
}

class _SingleUSAStatesReportViewState extends State<SingleUSAStatesReportView> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final isLargeScreen = MediaQuery.of(context).size.width > 600;
      return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            leading: isLargeScreen ? new Container() : null,
            title: Text(widget.state.state),
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
                            Details(state: widget.state),
                            StatsPieChart(stats: Country.fromStates(widget.state)),
                          ])))));
    });
  }
}

class Details extends StatelessWidget {
  final States state;

  Details({
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    //
    List<Widget> children = [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createDetailItem(
                context: context,
                color: SingleIntReportView.colors[0],
                value: state.active,
                text: SingleIntReportView.active),
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createDetailItem(
                context: context,
                color: SingleIntReportView.colors[1],
                value: state.cases - state.active - state.deaths,
                text: SingleIntReportView.recovered),
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createDetailItem(
              context: context,
              color: SingleIntReportView.colors[2],
              value: state.deaths,
              text: SingleIntReportView.deaths,
              todaysUpdate: state.todayDeaths,
            ),
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createDetailItem(
                context: context,
                colors: SingleIntReportView.colors,
                value: state.cases,
                todaysUpdate: state.todayCases,
                text: SingleIntReportView.cases),
          ],
        ),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
      child: Container(
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
