import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/view/list_usa_states.dart';
import 'package:covid19/view/single_int_report.dart';
import 'package:covid19/view/single_usa_states_report.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MasterDetailPageUSA extends StatefulWidget {
  static const routeName = '/masterDetailPageUSA';
  static const countryName = 'USA';
  final Country country;
  MasterDetailPageUSA({Key key, this.country}) : super(key: key);

  @override
  _MasterDetailPageUSAState createState() => _MasterDetailPageUSAState();
}

class _MasterDetailPageUSAState extends State<MasterDetailPageUSA> {
  States _states;
  var _isLargeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        _isLargeScreen = MediaQuery.of(context).size.width > 600;
        return Row(children: <Widget>[
          Expanded(
            child: ListUSAStatesView((value) {
              _states = value;
              if (_isLargeScreen) {
                setState(() {});
              } else {
                _states.state == ListUSAStatesView.tuttiGliStati
                    ? Navigator.pushNamed(
                        context, SingleIntReportView.routeName,
                        arguments: widget.country)
                    : Navigator.pushNamed(
                        context, SingleUSAStatesReportView.routeName,
                        arguments: _states);
              }
            }, widget.country),
          ),
          _isLargeScreen && _states != null
              ? Expanded(
                  child: _states.state == ListUSAStatesView.tuttiGliStati
                      ? SingleIntReportView(
                          country: widget.country,
                        )
                      : SingleUSAStatesReportView(state: _states))
              : _isLargeScreen
                  ? Expanded(child: Container())
                  : Container(),
        ]);
      }),
    );
  }
}
