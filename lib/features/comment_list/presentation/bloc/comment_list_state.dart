part of 'comment_list_bloc.dart';

abstract class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

class CommentListInitial extends CommentListState {}

class CommentListLoading extends CommentListState {}

class CommentListLoaded extends CommentListState {
  final List<CommentGraph> commentList;
  CommentListLoaded({this.commentList});
}

class CommentListError extends CommentListState {
  final String message;
  CommentListError({this.message});
}
