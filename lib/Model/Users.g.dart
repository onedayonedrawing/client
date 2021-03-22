// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) {
  return Users(
    json['uid'] as String,
    json['id'] as String,
    json['email'] as String,
    json['nickname'] as String,
    json['level'] as int,
    json['exp'] as int,
    json['latest_drawing_m'] as int,
    json['latest_drawing_d'] as int,
    json['drawing_continue'] as int,
    json['created_at'] as String,
    json['drawing_number'] as int,
  );
}

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'level': instance.level,
      'exp': instance.exp,
      'latest_drawing_m': instance.latest_drawing_m,
      'latest_drawing_d': instance.latest_drawing_d,
      'drawing_continue': instance.drawing_continue,
      'created_at': instance.created_at,
      'drawing_number': instance.drawing_number,
    };
