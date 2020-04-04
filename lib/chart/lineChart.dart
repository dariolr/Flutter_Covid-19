import 'package:covid19/model/novel_covid.dart';
import 'package:covid19/service/service.dart';
import 'package:covid19/view/single_int_report.dart';
import 'package:covid19/view/single_ita_report.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class TrendChart extends StatefulWidget {
  final String country;
  final bool italy;
  TrendChart({Key key, @required this.country, @required this.italy})
      : super(key: Key(country));
  @override
  _TrendChart createState() => _TrendChart();
}

class TrendData {
  Map<DateTime, int> data;
  Color color;
  String label;

  TrendData(this.data, this.color, this.label);
}

class _TrendChart extends State<TrendChart> {
  Future<CountryTrend> _trend;

  List<TrendData> _trendData = List();

  @override
  void initState() {
    super.initState();
    _trend = getCountryHistorical(widget.country);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CountryTrend>(
        future: _trend,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final trend = snapshot.data;
            if (trend == null ||
                trend.deaths == null ||
                trend.cases == null ||
                trend.deaths.length == 0 ||
                trend.cases.length == 0) {
              return SizedBox();
            } else {
              _trendData.add(TrendData(
                  trend.cases,
                  SingleIntReportView.totColor,
                  widget.italy
                      ? SingleITAReportView.active
                      : SingleIntReportView.active));
              _trendData.add(TrendData(
                  trend.deaths,
                  SingleIntReportView.colors[2],
                  widget.italy
                      ? SingleITAReportView.deaths
                      : SingleIntReportView.deaths));
              return Padding(
                padding: EdgeInsets.only(left: 0.0, right: 20.0),
                child: AspectRatio(
                  aspectRatio: 1.23,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 37,
                            ),
                            Text(
                              widget.italy
                                  ? "Andamento storico\n(ultimi 20 giorni)"
                                  : "Historical",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle2
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 37,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 30.0, left: 20.0),
                                child: LineChart(
                                  trendData(trend),
                                  swapAnimationDuration:
                                      Duration(milliseconds: 250),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  int startIndex(CountryTrend trend) {
    return max(
        trend.cases != null && trend.cases.length > 0
            ? trend.cases.values.length - 20
            : 0,
        0);
  }

  LineChartData trendData(CountryTrend trend) {
    int maxCases = trend.cases.values.reduce(max);
    int rounded = ((maxCases + 999) ~/ 1000) * 1000;
    double verticalInterval = (rounded.toDouble() / 4.0);
    double horizontalInterval = 3.0;
    return LineChartData(
      minY: 0,
      maxY: rounded.toDouble(),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          getTooltipItems: (spots) {
            return spots
                .asMap()
                .map((index, spot) {
                  return MapEntry(
                      index,
                      LineTooltipItem(
                          "${_trendData[index].label} - ${spot.y.toInt()}",
                          Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: _trendData[index].color)));
                })
                .values
                .toList();
          },
        ),
        handleBuiltInTouches: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(
            showTitles: true,
            interval: verticalInterval,
            getTitles: (value) {
              return "${NumberFormat.compact().format(value.toInt())}";
            },
            rotateAngle: 30.0),
        bottomTitles: SideTitles(
            interval: horizontalInterval,
            showTitles: true,
            getTitles: (value) {
              DateTime date =
                  trend.cases.keys.toList()[startIndex(trend) + value.toInt()];
              return widget.italy ? DateFormat("d/M").format(date) : DateFormat("M/d").format(date);
            },
            rotateAngle: 30.0),
      ),
      gridData: FlGridData(
        show: true,
        verticalInterval: horizontalInterval,
        horizontalInterval: verticalInterval,
      ),
      borderData: FlBorderData(
        show: false,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      lineBarsData: _trendData
          .map((set) => _fromData(set.data, set.color, trend))
          .toList(),
    );
  }

  LineChartBarData _fromData(
      Map<DateTime, int> data, Color color, CountryTrend trend) {
    var listData = List<FlSpot>();
    data.values
        .toList()
        .sublist(startIndex(trend))
        .asMap()
        .forEach((index, value) {
      listData.add(FlSpot(index.toDouble(), value.toDouble()));
    });
    if (listData.isEmpty) {
      listData.add(FlSpot(0.0, 0.0));
    }
    return LineChartBarData(
      spots: listData,
      isCurved: true,
      colors: [
        color,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true, dotColor: color),
    );
  }
}
