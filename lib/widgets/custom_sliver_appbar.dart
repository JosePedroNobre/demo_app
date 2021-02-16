import 'package:demo/pallete.dart';
import 'package:demo/styles.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String text;
  const CustomSliverAppBar({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        elevation: 0,
        forceElevated: false,
        pinned: true,
        centerTitle: true,
        title: Text(text, style: muliSemiBold(18, GRAYLIGHER)),
        backgroundColor: BACKGROUNDCOLOR);
  }
}
