part of 'comment_list_bloc.dart';

abstract class CommentListEvent {
  const CommentListEvent();

  @override
  List<Object> get props => [];
}

class GetCommentList extends CommentListEvent {
  @override
  List<Object> get props => [];
}

class AddComment extends CommentListEvent {
  final String comment;
  final List<CommentGraph> comments;

  AddComment({this.comment, this.comments});
  @override
  List<Object> get props => [comment, comments];
}

class UpdateComment extends CommentListEvent {
  final String id;
  CommentGraph commentGraph;

  UpdateComment(this.id, this.commentGraph);
  @override
  List<Object> get props => [id];
}

class DeleteComment extends CommentListEvent {
  final List<CommentGraph> comments;
  final String id;

  DeleteComment({this.id, this.comments});
  @override
  List<Object> get props => [];
}
