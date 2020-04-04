import 'package:flutter/material.dart';

class ChartLabel extends StatelessWidget {
  final Color color;
  final double percent;
  final String label;

  const ChartLabel({
    Key key,
    this.color,
    this.label,
    this.percent = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 3),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                ),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                '${percent.toStringAsFixed(2)}%',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
