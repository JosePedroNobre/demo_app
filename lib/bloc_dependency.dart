import 'package:demo/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:demo/features/comment_graph/data/comment_graph_data_source.dart';
import 'package:demo/features/comment_graph/data/comment_graph_repository.dart';
import 'package:demo/features/comment_graph/presentation/bloc/comment_graph_bloc.dart';
import 'package:demo/features/comment_list/data/comment_list_data_source.dart';
import 'package:demo/features/comment_list/data/comment_list_repository.dart';
import 'package:demo/features/comment_list/presentation/bloc/comment_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocDependency {
  static setBlocs() {
    return [
      BlocProvider<CommentGraphBloc>(
        create: (context) => CommentGraphBloc(
            CommentGraphRepository(CommentGraphRemoteDataSource())),
      ),
      BlocProvider<CommentListBloc>(
        create: (context) => CommentListBloc(
            CommentListRepository(CommentListRemoteDataSource())),
      ),
      BlocProvider<BottombarBloc>(
        create: (context) => BottombarBloc(),
      ),
    ];
  }
}
