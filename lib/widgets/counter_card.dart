import 'package:demo/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles.dart';

class CounterCard extends StatelessWidget {
  final int counter;
  final String label;
  const CounterCard({Key key, this.counter, this.label}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: CARDCOLOR,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            )),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [Text(label, style: muliRegular(17, GRAYLIGHER))],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_getTotalCommentCount(counter),
                      style: muliSemiBold(30, GRAYLIGHER)),
                  SizedBox(
                    width: 25,
                  ),
                  SvgPicture.asset("assets/images/chart.svg",
                      fit: BoxFit.cover, color: PURPLE1)
                ],
              )
            ],
          ),
        ));
  }

  _getTotalCommentCount(int counter) {
    return counter >= 0 ? counter.toString() : "0";
  }
}
