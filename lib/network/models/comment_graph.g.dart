// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_graph.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentGraph _$CommentGraphFromJson(Map<String, dynamic> json) {
  return CommentGraph(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      comment: json['comment'] as String,
      gender: json['gender'] as bool,
      country: json['country'] as String,
      created: json['created'] as String,
      preferedColor: json['preferedColor'] as String);
}

Map<String, dynamic> _$CommentGraphToJson(CommentGraph instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'comment': instance.comment,
      'gender': instance.gender,
      'country': instance.country,
      'created': instance.created,
      'preferedColor': instance.preferedColor
    };
