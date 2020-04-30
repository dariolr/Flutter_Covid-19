import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/model/utils.dart';
import 'package:covid19/service/service.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

typedef Null ItemSelectedCallback(Country value);

class ListCountryView extends StatefulWidget {
  static const search = 'Search';
  final ItemSelectedCallback onItemSelected;

  ListCountryView(
    this.onItemSelected,
  );

  @override
  _ListCountryViewState createState() => _ListCountryViewState();
}

class _ListCountryViewState extends State<ListCountryView>
    with TickerProviderStateMixin {
  List<Country> countries, _newcountries;
  final GlobalKey _refreshIndicatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (_refreshIndicatorKey.currentState as dynamic)?.show();
    });
    _getCountries();
  }

  Future<void> _getCountries() async {
    setState(() {
      _newcountries = [];
    });
    List<Country> temp = await getCountries();
    setState(() {
      countries = temp;
      _newcountries = countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return countries != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Covid-19',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 1.0,
            ),
            body: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colors.blue,
                            border: OutlineInputBorder(),
                            labelText: ListCountryView.search,
                            suffixIcon: Icon(Icons.search),
                          ),
                          onChanged: (text) {
                            setState(() {
                              _newcountries = countries
                                  .where((r) => (r.country
                                      .toLowerCase()
                                      .contains(text.trim().toLowerCase())))
                                  .toList();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: LiquidPullToRefresh(
                    springAnimationDurationInMilliseconds: 500,
                    key: _refreshIndicatorKey,
                    showChildOpacityTransition: false,
                    onRefresh: _getCountries,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _newcountries.length,
                      itemBuilder: (BuildContext context, int index) {
                        Widget leading = Icon(
                          Icons.public,
                          color: Colors.blue[800],
                          size: 36,
                        );
                        if (_newcountries[index].countryInfo != null &&
                            util.url(_newcountries[index].countryInfo.flag) &&
                            _newcountries[index].country != "World") {
                          leading = Image.asset(
                            "assets/" +
                                _newcountries[index].countryInfo.flag.split(
                                    "https://corona.lmao.ninja/assets/img/flags/")[1],
                            height: 24,
                          );
                        }
                        return Card(
                          elevation: 1,
                          color: Colors.grey[50],
                          child: ListTile(
                            onTap: () {
                              widget.onItemSelected(_newcountries[index]);
                            },
                            leading: leading,
                            title: Text(_newcountries[index].country),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
