import 'package:json_annotation/json_annotation.dart';

part 'comment_graph.g.dart';

@JsonSerializable()
class CommentGraph {
  String id;
  String name;
  String avatar;
  String comment;
  bool gender;
  String country;
  String created;
  String preferedColor;

  CommentGraph(
      {this.id,
      this.name,
      this.avatar,
      this.comment,
      this.gender,
      this.country,
      this.created,
      this.preferedColor});

  factory CommentGraph.fromJson(Map<String, dynamic> json) =>
      _$CommentGraphFromJson(json);

  Map<String, dynamic> toJson() => _$CommentGraphToJson(this);
}
