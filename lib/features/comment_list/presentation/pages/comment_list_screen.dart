import 'package:demo/features/comment_list/presentation/bloc/comment_list_bloc.dart';
import 'package:demo/network/models/comment_graph.dart';
import 'package:demo/pallete.dart';
import 'package:demo/styles.dart';
import 'package:demo/widgets/comment_form.dart';
import 'package:demo/widgets/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentList extends StatefulWidget {
  CommentList({Key key}) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  void initState() {
    BlocProvider.of<CommentListBloc>(context).add(GetCommentList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUNDCOLOR,
      floatingActionButton: _buildButton(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [_buildAppBar(), _buildBody()],
        ),
      ),
    );
  }

  _buildAppBar() {
    return CustomSliverAppBar(text: "Comments Page");
  }

  _buildBody() {
    return SliverFillRemaining(
      child: BlocConsumer<CommentListBloc, CommentListState>(
        cubit: BlocProvider.of<CommentListBloc>(context),
        buildWhen: (previous, current) {
          return current is CommentListInitial ||
              current is CommentListLoading ||
              current is CommentListLoaded;
        },
        listenWhen: (previous, current) {
          return current is CommentListError;
        },
        builder: (context, state) {
          if (state is CommentListInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommentListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommentListLoaded) {
            if (state.commentList.isNotEmpty)
              return _buildCommentList(state.commentList);
            else
              return _buildCommentsEmpty();
          } else {
            return Container();
          }
        },
        listener: (previous, current) async {
          if (current is CommentListError) {
            print(current.toString);
          }
        },
      ),
    );
  }

  _buildCommentsEmpty() {}

  _buildCommentList(List<CommentGraph> commentList) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: commentList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildCommentCard(commentList[index], commentList);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.transparent);
        },
      ),
    );
  }

  _buildCommentCard([CommentGraph comment, List<CommentGraph> commentList]) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
            color: GRAYDARKER,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 15, right: 8, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: SvgPicture.network(
                              "https://static.foqal.io/avatar.9a3a77b036e71e348abe3dfabb4e5486.svg"),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  comment?.name ?? "Anon",
                                  style: muliSemiBold(20, GRAYLIGHER),
                                ),
                              ),
                              SizedBox(height: 4),
                              Flexible(
                                child: Text(
                                  "Country: " + comment.country,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: muliSemiBold(12, GRAYLIGHER),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              _showCommentDialog(comment);
                            },
                            child: SvgPicture.asset(
                              "assets/images/pencil.svg",
                              color: GRAYLIGHER,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              _showDeleteDialog(comment.id, commentList);
                            },
                            child: SvgPicture.asset(
                              "assets/images/delete.svg",
                              color: GRAYLIGHER,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(color: Colors.transparent),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      comment.comment,
                      style: muliRegular(15, GRAYLIGHER),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildButton([CommentGraph comment]) {
    return FloatingActionButton(
      tooltip: "Add Comment",
      backgroundColor: PURPLE1,
      onPressed: () {
        _showCommentDialog(comment);
      },
      child: Icon(
        Icons.add,
        size: 38,
      ),
    );
  }

  _showDeleteDialog(String id, List<CommentGraph> commentList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
            child: AlertDialog(
          backgroundColor: GRAY1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Warning",
            style: muliSemiBold(19, GRAYLIGHER),
          ),
          content: Text(
            "Do you want to delete this comment?",
            style: muliRegular(19, GRAYLIGHER),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "No",
                style: muliSemiBold(19, GRAYLIGHER),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "YES!",
                style: muliSemiBold(19, GRAYLIGHER),
              ),
              onPressed: () {
                BlocProvider.of<CommentListBloc>(context)
                    .add(DeleteComment(id: id, comments: commentList));
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
      },
    );
  }

  _showCommentDialog([CommentGraph commentGraph]) async {
    await showModalBottomSheet(
        backgroundColor: BACKGROUNDCOLOR,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (BuildContext context) {
          return CommentForm(
            commentGraph: commentGraph,
          );
        });
  }
}
