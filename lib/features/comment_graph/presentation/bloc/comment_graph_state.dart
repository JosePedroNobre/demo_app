part of 'comment_graph_bloc.dart';

abstract class CommentGraphState {}

class CommentGraphInitial extends CommentGraphState {}

class CommentGraphLoading extends CommentGraphState {}

class CommentGraphLoaded extends CommentGraphState {
  final List<CommentGraph> commentList;

  CommentGraphLoaded(this.commentList);
}

class CommentGraphError extends CommentGraphState {
  final String message;

  CommentGraphError({this.message});
}
