import 'package:bloc_test/bloc_test.dart';
import 'package:demo/features/comment_list/data/comment_list_data_source.dart';
import 'package:demo/features/comment_list/data/comment_list_repository.dart';
import 'package:demo/features/comment_list/presentation/bloc/comment_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var dataSource = CommentListRemoteDataSource();
  group('integration test on comment API', () {
    blocTest(
      'Add comment to the db',
      build: () => CommentListBloc(CommentListRepository(dataSource)),
      act: (bloc) => bloc.add(AddComment(comment: "test")),
      expect: [CommentListLoading(), CommentListLoaded()],
    );
  });

  group('Unit test on commentList', () {
    CommentListRepository commentListRepository =
        CommentListRepository(dataSource);
    test("this should load a list of comments", () async {
      var commentList = await commentListRepository.getCommentList();
      expect(commentList[0].country, "China");
    });
    test("this should load a list of comments", () async {
      var commentList = await commentListRepository.getCommentList();
      expect(commentList[0].preferedColor, "green");
    });
  });
}
