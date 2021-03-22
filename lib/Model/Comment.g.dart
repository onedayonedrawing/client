// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    comment_user: json['comment_user'] == null
        ? null
        : Users.fromJson(json['comment_user'] as Map<String, dynamic>),
    comment_content: json['comment_content'] as String,
    comment_date: json['comment_date'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'comment_user': instance.comment_user?.toJson(),
      'comment_content': instance.comment_content,
      'comment_date': instance.comment_date,
    };
