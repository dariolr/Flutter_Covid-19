import 'package:covid19/chart/chart_label.dart';
import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/view/single_int_report.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsPieChart extends StatefulWidget {
  final Country stats;
  StatsPieChart({Key key, final this.stats}) : super(key: key);
  @override
  _StatsPieChartState createState() => _StatsPieChartState();
}

class _StatsPieChartState extends State<StatsPieChart> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    Percent1M perc = new Percent1M(widget.stats);
    List<Widget> widgets = [
      ChartLabel(
        color: SingleIntReportView.colors[0],
        label: SingleIntReportView.active,
        percent: perc.activePerc,
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
                        sectionsSpace: 0,
                        centerSpaceRadius: 30,
                        sections: showingSections(touchedIndex, widget.stats.active, widget.stats.deaths, widget.stats.recovered)),
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

  List<PieChartSectionData> showingSections(int touchedIndex, int active, int deaths, int recovered) {
    return List.generate(recovered == null ? 2 : 3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: SingleIntReportView.colors[2],
            value: deaths + 0.0,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: SingleIntReportView.colors[0],
            value: active + 0.0,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: SingleIntReportView.colors[1],
            value: recovered + 0.0,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        default:
          return null;
      }
    });
  }

class Percent1M {
  Country report;
  double deathPerc, recoveredPerc, activePerc;

  Percent1M(Country _report) {
    this.report = _report;
    deathPerc = (report.deaths / (report.cases)) * 100;
    recoveredPerc = (report.recovered / (report.cases)) * 100;
    activePerc = (report.active / (report.cases)) * 100;
  }
}
