import 'package:demo/bloc_dependency.dart';
import 'package:demo/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:demo/features/comment_graph/presentation/pages/comment_graph_screen.dart';
import 'package:demo/features/comment_graph/presentation/pages/user_graph_screen.dart';
import 'package:demo/features/comment_list/presentation/pages/comment_list_screen.dart';

import 'package:demo/pallete.dart';
import 'package:demo/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocDependency.setBlocs(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MainScreen(),
        theme: ThemeData(
          backgroundColor: BACKGROUNDCOLOR,
          primaryColor: PURPLE1,
          fontFamily: 'Muli',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: CustomBottomBar(),
    );
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
          switch (state.currentIndex) {
            case 0:
              return CommentGraphScreen();
            case 1:
              return UserGraphScreen();
            case 2:
              return CommentList();
            default:
              return CommentGraphScreen();
          }
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
}
