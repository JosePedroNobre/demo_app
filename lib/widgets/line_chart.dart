import 'dart:math';

import 'package:demo/network/models/comment_graph.dart';
import 'package:demo/pallete.dart';
import 'package:demo/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomLineChart extends StatefulWidget {
  final List<CommentGraph> commentList;

  const CustomLineChart({Key key, this.commentList}) : super(key: key);
  @override
  _CustomLineChartState createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  List<FlSpot> spots;
  int maxValue;
  int midValue;

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    spots = _getValues(widget.commentList);
    maxValue = _getMaxScale(spots);

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.50,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: CARDCOLOR),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(maxValue),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(final maxValue) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 12,
          getTextStyles: (value) => muliSemiBold(15, GRAYLIGHER),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'JAN';
              case 5:
                return 'JUN';
              case 11:
                return 'DEC';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => muliSemiBold(15, GRAYLIGHER),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 5:
                return '5';
              case 10:
                return '10';
            }
            return '';
          },
          reservedSize: 10,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: maxValue.toDouble() + 3,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _getValues(List<CommentGraph> comments) {
    var _map = Map();

    comments.forEach((element) {
      if (!_map.containsKey(
          DateTime.parse(element?.created ?? "2020-11-26T19:25:37.268Z")
              .month
              .toDouble())) {
        _map[DateTime.parse(element?.created ?? "2020-11-26T19:25:37.268Z")
            .month
            .toDouble()] = 1;
      } else {
        _map[DateTime.parse(element?.created ?? "2020-11-26T19:25:37.268Z")
            .month
            .toDouble()] += 1;
      }
    });
    List<FlSpot> spots = _map.entries.map<FlSpot>((entry) {
      var key = entry.key as double;
      var value = entry.value;

      return FlSpot(key.toDouble() - 1.0, value.toDouble());
    }).toList();

    spots.sort((a, b) => a.x.compareTo(b.x));
    return spots;
  }

  _getMaxScale(List<FlSpot> spots) {
    if (spots != null && spots.isNotEmpty) {
      return spots.map<int>((e) => e.y.toInt()).reduce(max);
    }
  }
}
