// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Boards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Boards _$BoardsFromJson(Map<String, dynamic> json) {
  return Boards(
    create_user: json['create_user'] == null
        ? null
        : Users.fromJson(json['create_user'] as Map<String, dynamic>),
    category: (json['category'] as List)?.map((e) => e as int)?.toList(),
    title: json['title'] as String,
    image_name: json['image_name'] as String,
    content: json['content'] as String,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
    views: json['views'] as int,
    good: json['good'] as int,
    comments: (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    comment_number: json['comment_number'] as int,
  );
}

Map<String, dynamic> _$BoardsToJson(Boards instance) => <String, dynamic>{
      'create_user': instance.create_user?.toJson(),
      'category': instance.category,
      'title': instance.title,
      'image_name': instance.image_name,
      'content': instance.content,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'views': instance.views,
      'good': instance.good,
      'comments': instance.comments?.map((e) => e?.toJson())?.toList(),
      'comment_number': instance.comment_number,
    };
