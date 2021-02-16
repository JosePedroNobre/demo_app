import 'package:demo/constants.dart';
import 'package:demo/network/generic/base_api.dart';
import 'package:demo/network/models/comment_graph.dart';
import 'package:dio/dio.dart';

abstract class CommentGraphDataSource {
  Future<List<CommentGraph>> getCommentList();
}

class CommentGraphRemoteDataSource implements CommentGraphDataSource {
  BaseApi baseAPi = BaseApi();

  @override
  Future<List<CommentGraph>> getCommentList() async {
    try {
      var response = await baseAPi.dio.get(BASE_URL + "comment");
      Iterable l = response.data;
      List<CommentGraph> commentList =
          l.map((model) => CommentGraph.fromJson(model)).toList();
      return commentList;
    } catch (e) {
      throw DioError(error: e);
    }
  }
}

class CommentGraphMockDataSource implements CommentGraphDataSource {
  @override
  Future<List<CommentGraph>> getCommentList() {
    // TODO: implement getCommentList
    throw UnimplementedError();
  }
}
