import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:demo/features/comment_list/data/comment_list_repository.dart';
import 'package:demo/network/models/comment_graph.dart';
import 'package:equatable/equatable.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final CommentListRepository repository;
  CommentListBloc(this.repository) : super(CommentListInitial());

  @override
  Stream<CommentListState> mapEventToState(
    CommentListEvent event,
  ) async* {
    try {
      if (event is GetCommentList) {
        yield CommentListLoading();
        List<CommentGraph> _commentList = await repository.getCommentList();
        yield CommentListLoaded(commentList: _commentList);
      } else if (event is DeleteComment) {
        yield CommentListLoading();
        CommentGraph _comment = await repository.deleteComment(event.id);
        List<CommentGraph> comments = event.comments;
        comments.removeWhere((CommentGraph c) => c.id == _comment.id);
        print(comments);
        yield CommentListLoaded(commentList: comments);
      } else if (event is AddComment) {
        await repository.addComment(event.comment);
        yield CommentListLoading();
        List<CommentGraph> _commentList = await repository.getCommentList();
        yield CommentListLoaded(commentList: _commentList);
      } else if (event is UpdateComment) {
        await repository.updateComment(event.id, event.commentGraph);
        yield CommentListLoading();
        List<CommentGraph> _commentList = await repository.getCommentList();
        yield CommentListLoaded(commentList: _commentList);
      }
    } catch (e) {
      yield CommentListError(message: e.toString());
    }
  }
}
