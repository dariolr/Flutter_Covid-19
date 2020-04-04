import 'package:covid19/layout/master_detail_usa.dart';
import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/service/service.dart';
import 'package:covid19/view/list_all_countries.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

typedef Null ItemSelectedCallback(States value);

class ListUSAStatesView extends StatefulWidget {
  static const routeName = '/listUSAStatesView';
  static const tuttiGliStati = 'All States';
  final ItemSelectedCallback onItemSelected;
  final Country country;

  ListUSAStatesView(
    this.onItemSelected,
    this.country,
  );

  @override
  _ListUSAStatesViewState createState() => _ListUSAStatesViewState();
}

class _ListUSAStatesViewState extends State<ListUSAStatesView>
    with TickerProviderStateMixin {
  List<States> _states, _newstates;
  final GlobalKey _refreshIndicatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (_refreshIndicatorKey.currentState as dynamic)?.show();
    });
    _getStates();
  }

  Future<void> _getStates() async {
    List<States> temp = await getStates();
    setState(() {
      _states = temp;
      _newstates = _states;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _states != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                MasterDetailPageUSA.countryName,
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
                              _newstates = _states
                                  .where((r) => (r.state
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
                    onRefresh: _getStates,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _newstates.length,
                      itemBuilder: (BuildContext context, int index) {
                        Widget leading = _newstates[index].state ==
                                ListUSAStatesView.tuttiGliStati
                            ? Image.asset(
                                "assets/us.png",
                                height: 24,
                              )
                            : null;
                        return Card(
                          elevation: 1,
                          color: Colors.grey[50],
                          child: ListTile(
                            onTap: () {
                              widget.onItemSelected(_newstates[index]);
                            },
                            leading: leading,
                            title: Text(_newstates[index].state),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ))
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
