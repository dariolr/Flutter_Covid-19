import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/chart/chart.dart';
import 'package:covid19/chart/lineChart.dart';
import 'package:flutter/material.dart';

class SingleIntReportView extends StatefulWidget {
  static const routeName = '/singleIntReportView';
  static const String allCountries = "World";

  static const active = "Active";
  static const critical = "Critical";
  static const recovered = "Recovered";
  static const deaths = "Deaths";
  static const cases = "Cases";
  static const cases1M = "Cases per million";
  static const deaths1M = "Deaths per million";

  static List<Color> colors = [
    Colors.yellow[500],
    Colors.green[400],
    Colors.red[400],
  ];
  static Color totColor = Colors.orange[400];

  final Country country;
  SingleIntReportView({Key key, final this.country}) : super(key: key);
  @override
  _SingleIntReportViewState createState() => _SingleIntReportViewState();
}

class _SingleIntReportViewState extends State<SingleIntReportView> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final isLargeScreen = MediaQuery.of(context).size.width > 600;
      return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            leading: isLargeScreen ? new Container() : null,
            title: Text('${widget.country.country}'),
            actions: <Widget>[],
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
                    Details(countryStats: widget.country),
                    StatsPieChart(stats: widget.country),
                    widget.country.country == SingleIntReportView.allCountries
                        ? SizedBox()
                        : TrendChart(country: widget.country.country, italy: false),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}

class Details extends StatelessWidget {
  final Country countryStats;

  Details({
    this.countryStats,
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
                value: countryStats.active,
                text: SingleIntReportView.active),
            createDetailItem(
                context: context,
                value: countryStats.critical,
                text: SingleIntReportView.critical),
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
                value: countryStats.recovered,
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
              value: countryStats.deaths,
              todaysUpdate: countryStats.todayDeaths,
              text: SingleIntReportView.deaths,
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
                value: countryStats.cases,
                text: SingleIntReportView.cases,
                todaysUpdate: countryStats.todayCases),
          ],
        ),
      ),
      countryStats.country == SingleIntReportView.allCountries
          ? SizedBox()
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  createDetailItem(
                      context: context,
                      value: countryStats.casesPerOneMillion,
                      text: SingleIntReportView.cases1M),
                  createDetailItem(
                      context: context,
                      value: countryStats.deathsPerOneMillion,
                      text: SingleIntReportView.deaths1M),
                ],
              ),
            )
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

Widget createDetailItem(
    {BuildContext context,
    dynamic value,
    Color color,
    List<Color> colors,
    String text,
    int todaysUpdate,
    Row innerWidget}) {
  List<Widget> listWidgets = [];
  if (colors != null) {
    for (Color col in colors) {
      listWidgets.add(Container(
        margin: EdgeInsets.only(right: 8.0),
        width: 13,
        height: 13,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: col ?? Colors.transparent,
            borderRadius: BorderRadius.circular(2.0)),
      ));
    }
  }

  return Expanded(
    child: Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: color == null ? Colors.white : color.withAlpha(20),
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              color != null
                  ? Container(
                      margin: EdgeInsets.only(right: 8.0),
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: color ?? Colors.transparent,
                          borderRadius: BorderRadius.circular(2.0)),
                    )
                  : colors != null
                      ? Row(
                          children: listWidgets,
                        )
                      : SizedBox(),
              Text(
                '$text',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            children: <Widget>[
              Text(
                '${value ?? 0}',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              todaysUpdate != null && todaysUpdate > 0
                  ? Text(
                      ' +$todaysUpdate',
                      style: Theme.of(context).textTheme.caption,
                    )
                  : SizedBox()
            ],
          ),
          innerWidget ?? SizedBox()
        ],
      ),
    ),
  );
}

