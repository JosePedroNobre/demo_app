import 'package:demo/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:demo/pallete.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatefulWidget {
  final Function onTap;
  const CustomBottomBar({Key key, this.onTap}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  void initState() {
    BlocProvider.of<BottombarBloc>(context).add(SetBottomBarIndex(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return BlocConsumer<BottombarBloc, BottombarState>(
      cubit: BlocProvider.of<BottombarBloc>(context),
      buildWhen: (previous, current) {
        return current is BottombarUpdatedTab;
      },
      listenWhen: (previous, current) {
        return current is BottombarError;
      },
      builder: (context, state) {
        if (state is BottombarUpdatedTab) {
          return _buildBottomBar(state.currentIndex);
        } else {
          return Container();
        }
      },
      listener: (previous, current) async {
        if (current is BottombarError) {
          print(current.toString);
        }
      },
    );
  }

  _buildBottomBar(int index) {
    return BottomNavigationBar(
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      backgroundColor: BACKGROUNDCOLOR,
      selectedItemColor: GRAYLIGHER,
      unselectedItemColor: GRAYDARKER,
      items: _getBottomItems,
      currentIndex: index,
      onTap: (value) {
        BlocProvider.of<BottombarBloc>(context).add(SetBottomBarIndex(value));
      },
    );
  }

  List<BottomNavigationBarItem> get _getBottomItems {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          title: Text("chart"),
          activeIcon: SvgPicture.asset(
            "assets/images/chart-arc.svg",
            color: PURPLE1,
          ),
          icon: SvgPicture.asset("assets/images/chart-arc.svg",
              color: GRAYDARKER)),
      BottomNavigationBarItem(
          title: Text("chart"),
          activeIcon: SvgPicture.asset(
            "assets/images/chart-areaspline.svg",
            color: PURPLE1,
          ),
          icon: SvgPicture.asset("assets/images/chart-areaspline.svg",
              color: GRAYDARKER)),
      BottomNavigationBarItem(
          title: Text("comments"),
          activeIcon: SvgPicture.asset(
            "assets/images/comment-text-multiple.svg",
            color: PURPLE1,
          ),
          icon: SvgPicture.asset("assets/images/comment-text-multiple.svg",
              color: GRAYDARKER))
    ];
  }
}
