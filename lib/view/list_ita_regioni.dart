import 'package:covid19/layout/master_detail_ita.dart';
import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/model/pcm.dart';
import 'package:covid19/service/service.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

typedef Null ItemSelectedCallback(Nazionale value);

class ListITARegioniView extends StatefulWidget {
  static const routeName = '/listITARegioniView';
  static const tutteLeRegioni = 'Tutte le regioni';
  static const search = 'Cerca';
  final ItemSelectedCallback onItemSelected;
  final Country country;

  ListITARegioniView(
    this.onItemSelected,
    this.country,
  );

  @override
  _ListITARegioniViewState createState() => _ListITARegioniViewState();
}

class _ListITARegioniViewState extends State<ListITARegioniView>
    with TickerProviderStateMixin {
  List<Nazionale> _regioni, _newregioni;
  final GlobalKey _refreshIndicatorKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (_refreshIndicatorKey.currentState as dynamic)?.show();
    });
    _getRegionaleLatest();
  }

  Future<void> _getRegionaleLatest() async {
    List<Nazionale> temp = await getRegionaleLatest();
    setState(() {
      _regioni = temp;
      _newregioni = _regioni;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _regioni != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                MasterDetailPageITA.countryName,
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
                            labelText: ListITARegioniView.search,
                            suffixIcon: Icon(Icons.search),
                          ),
                          onChanged: (text) {
                            setState(() {
                              _newregioni = _regioni
                                  .where((r) => (r.denominazioneRegione
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
                    onRefresh: _getRegionaleLatest,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _newregioni.length,
                      itemBuilder: (BuildContext context, int index) {
                        Widget leading =
                            _newregioni[index].denominazioneRegione ==
                                    ListITARegioniView.tutteLeRegioni
                                ? Image.asset(
                                    "assets/it.png",
                                    height: 24,
                                  )
                                : null;
                        return Card(
                          elevation: 1,
                          color: Colors.grey[50],
                          child: ListTile(
                            onTap: () {
                              widget.onItemSelected(_newregioni[index]);
                            },
                            leading: leading,
                            title:
                                Text(_newregioni[index].denominazioneRegione),
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
