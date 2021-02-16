import 'dart:math';

import 'package:demo/network/models/comment_graph.dart';
import 'package:demo/pallete.dart';
import 'package:demo/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatefulWidget {
  final List<CommentGraph> comments;
  final List<GraphEntry> entryList;

  CustomPieChart({this.comments, this.entryList});

  @override
  State<StatefulWidget> createState() => CustomPieChartState();
}

class CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex;
  List<Color> colorList = [
    Color(0XFF3acce1),
    Color(0XFF665eff),
    Color(0XFF3497fd),
  ];
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        decoration: BoxDecoration(
            color: CARDCOLOR,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            )),
        child: Row(
          children: <Widget>[
            const SizedBox(height: 18),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 5,
                      centerSpaceRadius: 50,
                      sections: showingSections()),
                ),
              ),
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> list = [];
    widget.entryList.forEach((e) {
      final isTouched = widget.entryList.indexOf(e) == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      list.add(PieChartSectionData(
        titlePositionPercentageOffset: 1.45,
        badgePositionPercentageOffset: 1.8,
        color: colorList[widget.entryList.indexOf(e)],
        value: double.parse(e.value),
        title: e.description,
        radius: radius,
        titleStyle: muliRegular(fontSize, GRAYLIGHER),
      ));
    });
    return list;
  }
}

class GraphEntry {
  String description;
  String value;
  GraphEntry({this.description, this.value});
}
