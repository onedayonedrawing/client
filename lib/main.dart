import 'package:onedayonedrawing/root_page.dart';
import 'package:flutter/material.dart';
import 'package:onedayonedrawing/set_nickname.dart';
import 'package:onedayonedrawing/image_upload.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness:Brightness.dark,
      ),
      home: RootPage(),
      routes: <String, WidgetBuilder>{
        '/root': (_) => RootPage(),
        '/set_nickname': (_) => SetNickname(),
        '/image_upload': (_) => ImageUpload(),
      },
    );
  }
}