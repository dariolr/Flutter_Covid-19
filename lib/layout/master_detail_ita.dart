import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/model/pcm.dart';
import 'package:covid19/view/list_ita_regioni.dart';
import 'package:covid19/view/single_ita_report.dart';
import 'package:covid19/view/single_ita_reg_report.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MasterDetailPageITA extends StatefulWidget {
  static const routeName = '/masterDetailPageITA';
  static const countryName = 'Italy';
  final Country selectedCountry;
  MasterDetailPageITA({Key key, this.selectedCountry}) : super(key: key);

  @override
  _MasterDetailPageITAState createState() => _MasterDetailPageITAState();
}

class _MasterDetailPageITAState extends State<MasterDetailPageITA> {
  Nazionale _nazionale;
  var _isLargeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        _isLargeScreen = MediaQuery.of(context).size.width > 600;
        return Row(children: <Widget>[
          Expanded(
            child: ListITARegioniView((value) {
              _nazionale = value;
              if (_isLargeScreen) {
                setState(() {});
              } else {
                _nazionale.denominazioneRegione ==
                        ListITARegioniView.tutteLeRegioni
                    ? Navigator.pushNamed(
                        context, SingleITAReportView.routeName,
                        arguments: widget.selectedCountry)
                    : Navigator.pushNamed(
                        context, SingleITARegReportView.routeName,
                        arguments: _nazionale);
              }
            }, widget.selectedCountry),
          ),
          _isLargeScreen && _nazionale != null
              ? Expanded(
                  child: _nazionale.denominazioneRegione ==
                          ListITARegioniView.tutteLeRegioni
                      ? SingleITAReportView(
                          country: widget.selectedCountry,
                        )
                      : SingleITARegReportView(provincia: _nazionale))
              : _isLargeScreen ? Expanded(child: Container()) : Container(),
        ]);
      }),
    );
  }
}
