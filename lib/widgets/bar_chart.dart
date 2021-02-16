import 'package:demo/pallete.dart';
import 'package:demo/styles.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final int maleCount;
  final int femaleCount;

  const BarChart({Key key, this.maleCount, this.femaleCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalCount = maleCount + femaleCount;
    double femalePercentage =
        _calculatePercentage(totalCount, femaleCount) * 100;
    double malePercentage = _calculatePercentage(totalCount, maleCount) * 100;
    return Container(
        decoration: BoxDecoration(
            color: CARDCOLOR,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            )),
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Male - $malePercentage%",
                          style: muliSemiBold(19, GRAYLIGHER),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    _buildProgressBar(
                      _calculatePercentage(totalCount, maleCount),
                      context,
                      Color(0XFF665eff),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text("Female - $femalePercentage%",
                            style: muliSemiBold(19, GRAYLIGHER)),
                      ],
                    ),
                    SizedBox(height: 15),
                    _buildProgressBar(
                      _calculatePercentage(totalCount, femaleCount),
                      context,
                      Color(0XFF3acce1),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ],
            )));
  }

  _calculatePercentage(int total, int count) {
    return count / total;
  }

  _buildProgressBar(double percentage, context, [Color color]) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: GRAY1,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percentage,
        heightFactor: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color != null ? color : Colors.blue,
          ),
          child: Text(""),
        ),
      ),
    );
  }
}
