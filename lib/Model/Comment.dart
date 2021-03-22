import 'package:onedayonedrawing/Model/Users.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Comment.g.dart';
/// 코드 생성기에 이 클래스가 JSON 직렬화 로직이 만들어져야 한다고 알려주는 어노테이션입니다.
@JsonSerializable(explicitToJson: true)
class Comment{
  Users comment_user;
  String comment_content;
  String comment_date;

  Comment({
    this.comment_user,
    this.comment_content,
    this.comment_date
  });
  /// map에서 새로운 User 인스턴스를 생성하기 위해 필요한 팩토리 생성자입니다.
  /// 생성된 `_$UserFromJson()` 생성자에게 map을 전달해줍니다.
  /// 생성자의 이름은 클래스의 이름을 따릅니다. 본 예제의 경우 User를 따릅니다.
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  /// `toJson`은 클래스가 JSON 인코딩의 지원을 선언하는 규칙입니다.
  /// 이의 구현은 생성된 private 헬퍼 메서드 `_$UserToJson`을 단순히 호출합니다.
  Map<String, dynamic> toJson() => _$CommentToJson(this);

//factory Comment.fromJson(Map<String, dynamic> json) {
//  return Comment(
//    user: json["comment_user"] as Users,
//    content: json["comment_content"] as String,
//    createAt: json["comment_date"] as String
//  );
//}
}