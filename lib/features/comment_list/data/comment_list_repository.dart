import 'package:demo/features/comment_list/data/comment_list_data_source.dart';
import 'package:demo/network/models/comment_graph.dart';

class CommentListRepository {
  final CommentListDataSource dataSource;

  CommentListRepository(this.dataSource);

  Future<List<CommentGraph>> getCommentList() async {
    return dataSource.getCommentList();
  }

  Future<CommentGraph> deleteComment(String id) async {
    return dataSource.deleteComment(id);
  }

  Future<CommentGraph> addComment(String comment) async {
    return dataSource.addComment(comment);
  }

  Future<CommentGraph> updateComment(String id, CommentGraph comment) async {
    return dataSource.updateComment(id, comment);
  }
}
