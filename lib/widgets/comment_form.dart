import 'package:demo/features/comment_list/presentation/bloc/comment_list_bloc.dart';
import 'package:demo/network/models/comment_graph.dart';
import 'package:demo/pallete.dart';
import 'package:demo/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentForm extends StatefulWidget {
  CommentGraph commentGraph;

  CommentForm({
    Key key,
    this.commentGraph,
  }) : super(key: key);

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController =
        TextEditingController(text: widget?.commentGraph?.comment ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: GRAYLIGHER,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Text("Comment",
                      textAlign: TextAlign.center,
                      style: muliSemiBold(20, GRAYLIGHER))),
              Flexible(
                  flex: 1,
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        _commentController.text.isEmpty ??
                            Navigator.of(context).pop();

                        if (widget.commentGraph == null) {
                          BlocProvider.of<CommentListBloc>(context).add(
                              AddComment(comment: _commentController.text));
                        } else {
                          CommentGraph comment = widget.commentGraph;
                          if (comment.comment != _commentController.text) {
                            comment.comment = _commentController.text;
                            BlocProvider.of<CommentListBloc>(context).add(
                                UpdateComment(widget.commentGraph.id, comment));
                          }
                        }
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        "assets/images/send.svg",
                        color: PURPLE1,
                      ),
                    ),
                  )),
            ],
          ), // Body
          Divider(),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: CARDCOLOR,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: TextFormField(
                  maxLines: 5,
                  cursorColor: PURPLE1,
                  style: muliSemiBold(18, GRAYLIGHER),
                  controller: _commentController,
                  decoration: InputDecoration(
                    labelStyle: muliSemiBold(14, Color(0XFF9F9F9F)),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
