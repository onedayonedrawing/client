import 'package:flutter/material.dart';
import 'package:onedayonedrawing/account_tap.dart';
import 'package:onedayonedrawing/home_tap.dart';
import 'package:onedayonedrawing/search_tap.dart';

class TapPage extends StatefulWidget {
  @override
  _TapPageState createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  int _selected_index = 0;

  List _pages = [
    HomeTap(),
    SearchTap(),
    AccountTap(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selected_index]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black38,
          onTap: _onItemTapped,
          currentIndex: _selected_index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
            BottomNavigationBarItem(icon: Icon(Icons.category), title: Text('image')),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('account'))
          ]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selected_index = index;
    });
  }
}
