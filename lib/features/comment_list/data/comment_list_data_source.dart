import 'dart:math';

import 'package:demo/constants.dart';
import 'package:demo/network/generic/base_api.dart';

import 'package:demo/network/models/comment_graph.dart';
import 'package:dio/dio.dart';

abstract class CommentListDataSource {
  Future<List<CommentGraph>> getCommentList();
  Future<CommentGraph> deleteComment(String id);
  Future<CommentGraph> addComment(String comment);
  Future<CommentGraph> updateComment(String id, CommentGraph commentGraph);
}

class CommentListRemoteDataSource implements CommentListDataSource {
  BaseApi baseApi = BaseApi();

  @override
  Future<List<CommentGraph>> getCommentList() async {
    try {
      var response = await baseApi.dio.get(BASE_URL + "comment");
      Iterable l = response.data;
      List<CommentGraph> commentList =
          l.map((model) => CommentGraph.fromJson(model)).toList();
      return commentList;
    } catch (e) {
      throw DioError(error: e);
    }
  }

  @override
  Future<CommentGraph> deleteComment(String id) async {
    try {
      var response = await baseApi.dio.delete(BASE_URL + "comment/$id");
      return CommentGraph.fromJson(response.data);
    } catch (e) {
      throw DioError(error: e);
    }
  }

  @override
  Future<CommentGraph> addComment(String comment) async {
    try {
      Random r = new Random();
      double falseProbability = .3;
      bool gender = r.nextDouble() > falseProbability;
      CommentGraph _comment = CommentGraph(
          name: null,
          comment: comment,
          gender: gender,
          country: "Antartida",
          preferedColor: "blue");
      Map<String, dynamic> body = _comment.toJson();
      var response = await baseApi.dio.post(BASE_URL + "comment", data: body);
      return CommentGraph.fromJson(response.data);
    } catch (e) {
      throw DioError(error: e);
    }
  }

  @override
  Future<CommentGraph> updateComment(String id, CommentGraph comment) async {
    try {
      Map<String, dynamic> body = comment.toJson();
      var response =
          await baseApi.dio.put(BASE_URL + "comment/$id", data: body);
      return CommentGraph.fromJson(response.data);
    } catch (e) {
      throw DioError(error: e);
    }
  }
}

class CommentListMockDataSource implements CommentListDataSource {
  @override
  Future<List<CommentGraph>> getCommentList() {
    // TODO: implement getCommentList
    throw UnimplementedError();
  }

  @override
  Future<CommentGraph> deleteComment(String id) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<CommentGraph> addComment(String comment) {
    // TODO: implement addComment
    throw UnimplementedError();
  }

  @override
  Future<CommentGraph> updateComment(String id, CommentGraph commentGraph) {
    // TODO: implement updateComment
    throw UnimplementedError();
  }
}
