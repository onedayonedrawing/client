import 'package:onedayonedrawing/Model/Users.dart';
import 'package:onedayonedrawing/Model/Comment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onedayonedrawing/Model/Category.dart';
/// 이 구문은 `User` 클래스가 생성된 파일의 private 멤버들을
/// 접근할 수 있도록 해줍니다. 여기에는 *.g.dart 형식이 들어갑니다.
/// * 에는 소스 파일의 이름이 들어갑니다.
part 'Boards.g.dart';


@JsonSerializable(explicitToJson: true)
class Boards{
  Users create_user;
  List<int> category;
  String title;
  String image_name;
  String content;
  String created_at;
  String updated_at;
  int views;
  int good;
  List<Comment> comments;
  int comment_number;

  Boards({
    this.create_user,
    this.category,
    this.title,
    this.image_name,
    this.content,
    this.created_at,
    this.updated_at,
    this.views,
    this.good,
    this.comments,
    this.comment_number,
});
  /// map에서 새로운 User 인스턴스를 생성하기 위해 필요한 팩토리 생성자입니다.
  /// 생성된 `_$UserFromJson()` 생성자에게 map을 전달해줍니다.
  /// 생성자의 이름은 클래스의 이름을 따릅니다. 본 예제의 경우 User를 따릅니다.
  factory Boards.fromJson(Map<String, dynamic> json) => _$BoardsFromJson(json);

  /// `toJson`은 클래스가 JSON 인코딩의 지원을 선언하는 규칙입니다.
  /// 이의 구현은 생성된 private 헬퍼 메서드 `_$UserToJson`을 단순히 호출합니다.
  Map<String, dynamic> toJson() => _$BoardsToJson(this);
  //factory Boards.fromJson(Map<String, dynamic> json) {
  //  var comment_arr = json['comment'].map((value) => new Boards.fromJson(value)).toList();
  //  List<Comment> comments = new List<Comment>.from(comment_arr);
  //  var category_arr = json['category'].map((value) => new Category.fromJson(value)).toList();
  //  List<Category> categorys = new List<Category>.from(category_arr);
  //  return Boards(
  //    createUser: json["create_user"] as Users,
  //    category: categorys,
  //    title: json['title'] as String,
  //    imageName: json['image_name'] as String,
  //    content: json['content'] as String,
  //    createAt: json['create_at'] as String,
  //    updatedAt: json['update_at'] as String,
  //    views: json['views'] as int,
  //    good: json['good'] as int,
  //    comments: comments,
  //    commentNumber: json['comment_number'] as int,
  //  );
  //}
}

