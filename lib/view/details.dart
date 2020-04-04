import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatefulWidget {
  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    final pcmUrl = "https://github.com/pcm-dpc/COVID-19";
    final novelCovidUrl = "https://github.com/NovelCOVID/API";
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          leading: new Container(),
        ),
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text("Credits: ",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      InkWell(
                        child: Text(pcmUrl,
                            style: TextStyle(
                              color: Colors.blue[800],
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () async {
                          if (await canLaunch(pcmUrl)) {
                            await launch(pcmUrl);
                          }
                        },
                      ),
                    ]),
                    Divider(
                      height: 50,
                    ),
                    Row(children: <Widget>[
                      Text("Credits: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      InkWell(
                        child: Text(novelCovidUrl,
                            style: TextStyle(
                              color: Colors.blue[800],
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () async {
                          if (await canLaunch(novelCovidUrl)) {
                            await launch(novelCovidUrl);
                          }
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
