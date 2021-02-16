import 'package:demo/features/comment_graph/presentation/bloc/comment_graph_bloc.dart';
import 'package:demo/network/models/comment_graph.dart';
import 'package:demo/pallete.dart';
import 'package:demo/styles.dart';
import 'package:demo/widgets/counter_card.dart';
import 'package:demo/widgets/custom_pie_chart.dart';
import 'package:demo/widgets/custom_sliver_appbar.dart';
import 'package:demo/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CommentGraphScreen extends StatefulWidget {
  CommentGraphScreen({Key key}) : super(key: key);

  @override
  _CommentGraphScreenState createState() => _CommentGraphScreenState();
}

class _CommentGraphScreenState extends State<CommentGraphScreen> {
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
    return CustomSliverAppBar(text: "Comment metrics");
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

  _buildEmptyState() {
    return Container(color: Colors.red);
  }

  _buildList(List<CommentGraph> _commentList) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildNumericCard(_commentList.length, "Total comments"),
            ),
            SizedBox(width: 20),
            Expanded(
              child: _buildNumericCard(5, "Today"),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text("Comment Timeline", style: muliSemiBold(20, GRAYLIGHER)),
          ],
        ),
        SizedBox(height: 14),
        _buildChart(_commentList),
        SizedBox(height: 20),
        Row(children: [
          Text("Prefered Color", style: muliSemiBold(20, GRAYLIGHER)),
        ]),
        SizedBox(height: 20),
        _buildPieChart(_commentList),
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

  _buildChart(List<CommentGraph> _commentList) {
    return CustomLineChart(
      commentList: _commentList,
    );
  }

  _buildPieChart(List<CommentGraph> _commentList) {
    return CustomPieChart(
      comments: _commentList,
      entryList: _getPieChartEntries(_commentList),
    );
  }

  _getPieChartEntries(List<CommentGraph> _commentList) {
    List<GraphEntry> entryList = [];
    var _map = Map();
    _commentList.forEach((element) {
      if (!_map.containsKey(element.preferedColor)) {
        _map[element.preferedColor] = 1;
      } else {
        _map[element.preferedColor] += 1;
      }
    });

    _map.forEach((k, v) {
      entryList.add(GraphEntry(description: k, value: v.toString()));
    });
    return entryList;
  }
}
