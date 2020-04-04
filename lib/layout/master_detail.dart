import 'package:covid19/layout/master_detail_ita.dart';
import 'package:covid19/layout/master_detail_usa.dart';
import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/view/details.dart';
import 'package:covid19/view/list_all_countries.dart';
import 'package:covid19/view/single_int_report.dart';
import 'package:flutter/material.dart';

class MasterDetailPage extends StatefulWidget {
  static Color f   = const Color(0xffffffff);
  @override
  _MasterDetailPageState createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  Country _selectedCountry;
  var _isLargeScreen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        _isLargeScreen = MediaQuery.of(context).size.width > 600;
        return Row(children: <Widget>[
          Expanded(
            child: ListCountryView((value) {
              if (value.country == MasterDetailPageITA.countryName) {
                Navigator.pushNamed(context, MasterDetailPageITA.routeName,
                    arguments: value);
              } else if (value.country == MasterDetailPageUSA.countryName) {
                Navigator.pushNamed(context, MasterDetailPageUSA.routeName,
                    arguments: value);
              } else {
                _selectedCountry = value;
                if (_isLargeScreen) {
                  setState(() {});
                } else {
                  Navigator.pushNamed(context, SingleIntReportView.routeName,
                      arguments: _selectedCountry);
                }
              }
            }),
          ),
          _isLargeScreen && _selectedCountry != null
              ? Expanded(
                  child: _selectedCountry.country ==
                          MasterDetailPageITA.countryName
                      ? MasterDetailPageITA(
                          selectedCountry: _selectedCountry,
                        )
                      : _selectedCountry.country ==
                              MasterDetailPageUSA.countryName
                          ? MasterDetailPageUSA(
                              country: _selectedCountry,
                            )
                          : SingleIntReportView(country: _selectedCountry))
              : _isLargeScreen ? Expanded(child: DetailsView()) : Container(),
        ]);
      }),
    );
  }
}
