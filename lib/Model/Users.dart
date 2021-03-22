import 'package:onedayonedrawing/Model/Boards.dart';
import 'package:json_annotation/json_annotation.dart';
/// 이 구문은 `User` 클래스가 생성된 파일의 private 멤버들을
/// 접근할 수 있도록 해줍니다. 여기에는 *.g.dart 형식이 들어갑니다.
/// * 에는 소스 파일의 이름이 들어갑니다.
part 'Users.g.dart';

/// 코드 생성기에 이 클래스가 JSON 직렬화 로직이 만들어져야 한다고 알려주는 어노테이션입니다.
@JsonSerializable(explicitToJson: true)
class Users {
  String uid;
  String id;
  String email;
  String nickname;
  int level;
  int exp;
  int latest_drawing_m;
  int latest_drawing_d;
  int drawing_continue;
  String created_at;
  int drawing_number;

  Users(
    this.uid,
    this.id,
    this.email,
    this.nickname,
    this.level,
    this.exp,
    this.latest_drawing_m,
    this.latest_drawing_d,
    this.drawing_continue,
    this.created_at,
    this.drawing_number,
);
  //factory Users.fromJson(Map<String, dynamic> json) {
  //  var board_arr = json['board_arr'].map((value) => new Boards.fromJson(value)).toList();
  //  List<Boards> board = new List<Boards>.from(board_arr);
  //  return Users(
  //    uid: json['uid'] as String,
  //    id: json['id'] as String,
  //    email: json['email'] as String,
  //    nickname: json['nickname'] as String,
  //    level: json['level'] as int,
  //    exp: json['ext'] as int,
  //    latestDrawingM: json['latest_drawing_m'] as int,
  //    latestDrawingD: json['latest_drawing_d'] as int,
  //    drawingContinue: json['drawing_continue'] as int,
  //    createdAt: json['created_at'] as String,
  //    boardArr: board,
  //  );
  //}

  /// map에서 새로운 User 인스턴스를 생성하기 위해 필요한 팩토리 생성자입니다.
  /// 생성된 `_$UserFromJson()` 생성자에게 map을 전달해줍니다.
  /// 생성자의 이름은 클래스의 이름을 따릅니다. 본 예제의 경우 User를 따릅니다.
  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  /// `toJson`은 클래스가 JSON 인코딩의 지원을 선언하는 규칙입니다.
  /// 이의 구현은 생성된 private 헬퍼 메서드 `_$UserToJson`을 단순히 호출합니다.
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}

//Users _$UsersFromJson(Map<String, dynamic> json) {
//  return Users(
//    json['uid'] as String,
//    json['id'] as String,
//    json['email'] as String,
//    json['nickname'] as String,
//    json['level'] as int,
//    json['exp'] as int,
//    json['latest_drawing_m'] as int,
//    json['latest_drawing_d'] as int,
//    json['drawing_continue'] as int,
//    json['created_at'] as String,
//    (json['board_arr'] as List)
//        ?.map((e) =>
//            e == null ? null : e.runtimeType == String ? null : Boards.fromJson(e as Map<String, dynamic>))
//        ?.toList(),
//  );
//}
