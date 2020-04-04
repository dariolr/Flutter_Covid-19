import 'package:covid19/chart/italy_chart.dart';
import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/model/pcm.dart';
import 'package:covid19/service/service.dart';
import 'package:covid19/chart/lineChart.dart';
import 'package:covid19/view/list_ita_regioni.dart';
import 'package:covid19/view/single_int_report.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SingleITAReportView extends StatefulWidget {
  static const routeName = '/singleITAReportView';

  static const active = "Attualmente positivi";
  static const hospitalSymptomatic = "Ricoverati\ncon sintomi";
  static const critical = "Terapia\nintensiva";
  static const homeIsolation = "Isolamento\ndomiciliare";
  static const recovered = "Dimessi / Guariti";
  static const deaths = "Deceduti";
  static const cases = "Casi totali";
  static const cases1M = "Casi per milione";
  static const deaths1M = "Deceduti per milione";
  static const swabs = "Tamponi";

  final Country country;
  SingleITAReportView({Key key, this.country}) : super(key: key);
  @override
  _SingleITAReportViewState createState() => _SingleITAReportViewState();
}

class _SingleITAReportViewState extends State<SingleITAReportView> {
  Future<Nazionale> _nazionale;

  @override
  void initState() {
    super.initState();
    _nazionale = getNazionaleLatest();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final isLargeScreen = MediaQuery.of(context).size.width > 600;
      return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            leading: isLargeScreen ? new Container() : null,
            title: Text(isLargeScreen
                ? ListITARegioniView.tutteLeRegioni
                : widget.country.country),
            backgroundColor: Colors.white,
            elevation: 1.0,
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Container(
                      color: Colors.grey[50],
                      child: FutureBuilder<Nazionale>(
                          future: _nazionale,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final nazionale = snapshot.data;
                              return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    DetailITA(
                                        nazionale: nazionale,
                                        country: widget.country),
                                    ItalyStatsPieChart(
                                      stats: nazionale,
                                    ),
                                    TrendChart(country: widget.country.country, italy: true),
                                  ]);
                            } else {
                              return CircularProgressIndicator();
                            }
                          })))));
    });
  }
}

class DetailITA extends StatelessWidget {
  final Nazionale nazionale;
  final Country country;

  DetailITA({
    this.nazionale,
    this.country,
  });

  @override
  Widget build(BuildContext context) {
    //
    final inner = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _createDetailInnerItem(
            context: context,
            value: nazionale.ricoveratiConSintomi,
            text: SingleITAReportView.hospitalSymptomatic),
        _createDetailInnerItem(
            context: context,
            value: nazionale.terapiaIntensiva,
            text: SingleITAReportView.critical),
        _createDetailInnerItem(
            context: context,
            value: nazionale.isolamentoDomiciliare,
            text: SingleITAReportView.homeIsolation),
      ],
    );

    List<Widget> children = [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createDetailItem(
                context: context,
                color: SingleIntReportView.colors[0],
                value: nazionale.totaleAttualmentePositivi,
                text: SingleITAReportView.active,
                todaysUpdate: nazionale.variazioneTotalePositivi,
                innerWidget: inner),
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
                value: nazionale.dimessiGuariti,
                text: SingleITAReportView.recovered),
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
                value: nazionale.deceduti,
                text: SingleITAReportView.deaths),
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
                value: nazionale.totaleCasi,
                todaysUpdate: nazionale.nuoviPositivi,
                text: SingleITAReportView.cases),
          ],
        ),
      ),
      country == null
          ? SizedBox()
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  createDetailItem(
                      context: context,
                      value: country.casesPerOneMillion,
                      text: SingleITAReportView.cases1M),
                  createDetailItem(
                      context: context,
                      value: country.deathsPerOneMillion,
                      text: SingleITAReportView.deaths1M),
                ],
              ),
            ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createDetailItem(
                context: context,
                value: nazionale.tamponi,
                text: SingleITAReportView.swabs),
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

Widget _createDetailInnerItem({
  BuildContext context,
  dynamic value,
  String text,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$text',
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          '${value ?? 0}',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
