import 'package:covid19/chart/chart.dart';
import 'package:covid19/chart/chart_label.dart';
import 'package:covid19/model/pcm.dart';
import 'package:covid19/view/single_int_report.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ItalyStatsPieChart extends StatefulWidget {
  final Nazionale stats;
  ItalyStatsPieChart({Key key, this.stats}) : super(key: key);
  @override
  _ItalyStatsPieChart createState() => _ItalyStatsPieChart();
}

class _ItalyStatsPieChart extends State<ItalyStatsPieChart> {

  int touchedIndex;
  Percent1M perc;

  @override
  void initState() {
    super.initState();
    perc = new Percent1M(widget.stats);
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = [
      ChartLabel(
        color: SingleIntReportView.colors[0],
        label: SingleIntReportView.active,
        percent: perc.activePerc,
      ),
      SizedBox(
        height: 10,
      ),
      ChartLabel(
        color: SingleIntReportView.colors[1],
        label: SingleIntReportView.recovered,
        percent: perc.recoveredPerc,
      ),
      ChartLabel(
        color: SingleIntReportView.colors[2],
        label: SingleIntReportView.deaths,
        percent: perc.deathPerc,
      ),
    ];

    return Container(
      child: Card(
        elevation: 0.0,
        color: Colors.grey[50],
        child: Column( 
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: PieChart(
                    PieChartData(
                        pieTouchData:
                            PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex =
                                  pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 2,
                        centerSpaceRadius: 30,
                        sections: showingSections(touchedIndex, widget.stats.totaleAttualmentePositivi, widget.stats.deceduti, widget.stats.dimessiGuariti)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets,
                ),
                const SizedBox(
                  width: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class Percent1M {
  Nazionale report;
  double deathPerc, recoveredPerc, activePerc;

  Percent1M(Nazionale _report) {
    this.report = _report;
    deathPerc = (report.deceduti / (report.totaleCasi)) * 100;
    recoveredPerc = (report.dimessiGuariti / (report.totaleCasi)) * 100;
    activePerc = (report.totaleAttualmentePositivi / (report.totaleCasi)) * 100;
  }
}
