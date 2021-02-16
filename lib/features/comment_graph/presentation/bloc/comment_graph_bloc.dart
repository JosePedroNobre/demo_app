import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo/features/comment_graph/data/comment_graph_repository.dart';
import 'package:demo/network/models/comment_graph.dart';

part 'comment_graph_event.dart';
part 'comment_graph_state.dart';

class CommentGraphBloc extends Bloc<CommentGraphEvent, CommentGraphState> {
  final CommentGraphRepository repository;
  CommentGraphBloc(this.repository) : super(CommentGraphInitial());

  @override
  Stream<CommentGraphState> mapEventToState(
    CommentGraphEvent event,
  ) async* {
    try {
      if (event is GetComments) {
        yield CommentGraphLoading();
        List<CommentGraph> _commentList = await repository.getGistList();
        yield CommentGraphLoaded(_commentList);
      }
    } catch (e) {
      yield CommentGraphError(message: e.toString());
    }
  }
}
