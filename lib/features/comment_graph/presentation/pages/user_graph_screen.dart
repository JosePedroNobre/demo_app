import 'package:demo/features/comment_graph/presentation/bloc/comment_graph_bloc.dart';
import 'package:demo/network/models/comment_graph.dart';
import 'package:demo/pallete.dart';
import 'package:demo/styles.dart';
import 'package:demo/widgets/bar_chart.dart';
import 'package:demo/widgets/counter_card.dart';
import 'package:demo/widgets/custom_pie_chart.dart';
import 'package:demo/widgets/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserGraphScreen extends StatefulWidget {
  UserGraphScreen({Key key}) : super(key: key);

  @override
  _UserGraphScreenState createState() => _UserGraphScreenState();
}

class _UserGraphScreenState extends State<UserGraphScreen> {
  @override
  void initState() {
    BlocProvider.of<CommentGraphBloc>(context).add(GetComments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUNDCOLOR,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [_buildAppBar(), _buildBody()],
        ),
      ),
    );
  }

  _buildAppBar() {
    return CustomSliverAppBar(text: "User metrics");
  }

  _buildBody() {
    return SliverToBoxAdapter(
      child: BlocConsumer<CommentGraphBloc, CommentGraphState>(
        cubit: BlocProvider.of<CommentGraphBloc>(context),
        buildWhen: (previous, current) {
          return current is CommentGraphInitial ||
              current is CommentGraphLoading ||
              current is CommentGraphLoaded;
        },
        listenWhen: (previous, current) {
          return current is CommentGraphError;
        },
        builder: (context, state) {
          if (state is CommentGraphInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommentGraphLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommentGraphLoaded) {
            if (state.commentList.isNotEmpty)
              return _buildList(state.commentList);
            else
              return _buildEmptyState();
          } else {
            return Container();
          }
        },
        listener: (previous, current) async {
          if (current is CommentGraphError) {
            print(current.toString);
          }
        },
      ),
    );
  }

  _buildList(List<CommentGraph> _commentList) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildNumericCard(_commentList.length, "Total users"),
            ),
            SizedBox(width: 20),
            Expanded(
              child: _buildNumericCard(5, "Daily average"),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text("Gender Difference", style: muliSemiBold(20, GRAYLIGHER)),
          ],
        ),
        SizedBox(height: 14),
        _buildPieChart(_commentList),
        SizedBox(height: 20),
        Row(children: [
          Text("Comments by gender", style: muliSemiBold(20, GRAYLIGHER)),
        ]),
        SizedBox(height: 20),
        _buildBarChart(_commentList),
        SizedBox(height: 20),
      ]),
    );
  }

  _buildNumericCard(int counter, String label) {
    return CounterCard(
      counter: counter,
      label: label,
    );
  }

  _buildEmptyState() {
    return Container(color: Colors.red);
  }

  _buildPieChart(List<CommentGraph> _commentList) {
    return CustomPieChart(
      comments: _commentList,
      entryList: _getPieChartEntries(_commentList),
    );
  }

  _buildBarChart(List<CommentGraph> _commentList) {
    List<GraphEntry> entryList = _getPieChartEntries(_commentList);
    return BarChart(
      femaleCount: int.parse(entryList.last.value),
      maleCount: int.parse(entryList.first.value),
    );
  }

  _getPieChartEntries(List<CommentGraph> _commentList) {
    List<GraphEntry> entryList = [];
    var _map = Map();
    _commentList.forEach((element) {
      if (!_map.containsKey(element.gender)) {
        _map[element.gender] = 1;
      } else {
        _map[element.gender] += 1;
      }
    });

    _map.forEach((k, v) {
      String gender;
      if (k) {
        gender = "Male";
      } else {
        gender = "Female";
      }
      entryList.add(GraphEntry(description: gender, value: v.toString()));
    });
    return entryList;
  }
}
