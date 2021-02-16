import 'package:demo/features/comment_graph/data/comment_graph_data_source.dart';
import 'package:demo/network/models/comment_graph.dart';

class CommentGraphRepository {
  final CommentGraphDataSource dataSource;

  CommentGraphRepository(this.dataSource);

  Future<List<CommentGraph>> getGistList() async {
    return dataSource.getCommentList();
  }
}
