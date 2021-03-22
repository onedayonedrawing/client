import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:onedayonedrawing/Model/Users.dart';
import 'dart:convert';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
Users loginUser;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
                                      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  print(user);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  var url = "https://drawing.nopublisher.dev/user/login";
  var res = await http.post(url, body:{'email': user.email, 'uid': user.uid, 'id': googleSignInAccount.id});

  //print('Response status: ${res.statusCode}');
  //print('Response body: ${res.body}');
  //502 베드 게이트웨이 처리 추가!!! (서버가 다운되었습니다.)
  //401 서버에서 처리 오류

  return 'signInWithGoogle succeeded: $user';
}

signOutGoogle() async{
  await googleSignIn.signOut();
  await _auth.signOut();
  loginUser = null;
  print("User Sign Out");
}

Future<bool> accountCheck() async {
  final FirebaseUser user = await _auth.currentUser();
  GoogleSignInAccount googleUser;// = await googleSignIn.currentUser;
  await googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    googleUser = account;
  });
  if(googleUser == null){
    googleUser = googleSignIn.currentUser;
  }
  await googleSignIn.signInSilently();

  if(user != null && googleUser != null){
    //유저 정보 받아오기
    var url = "https://drawing.nopublisher.dev/user/info";
    var res = await http.post(url, body: {'uid': user.uid});
    if (res.statusCode == 200) {
      var result = json.decode(res.body);

      // req login 리턴시 처리 추가할 것
      loginUser = new Users.fromJson(result);
    }
    return true;
  }
  //구글이나 파이어베이스 하나라도 로그인이 안되어 있다면 false 반환
  return false;
}

setNickname() async{
  final FirebaseUser user = await _auth.currentUser();
  var url = "https://drawing.nopublisher.dev/user/set_nickname";
  var res = await http.post(url, body: {'uid': user.uid, 'nickname': loginUser.nickname});
  if(res.statusCode == 200){
    print(res.body);
  }
}