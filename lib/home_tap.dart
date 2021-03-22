import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:onedayonedrawing/Model/Boards.dart';

import 'package:http/http.dart' as http;

class HomeTap extends StatefulWidget {
  @override
  _HomeTap createState() => _HomeTap();
}

class _HomeTap extends State<HomeTap> {
  // List<Boards> list = List();
  List<String> _imagePath = new List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get("https://drawing.nopublisher.dev/return_image_path");
    if (response.statusCode == 200) {
      // list = (json.decode(response.body) as List)
      //     .map((data) => new Boards.fromJson(data))
      //     .toList();
      //category: (json['category'] as List)?.map((e) => e as int)?.toList(),
      var jsonData = json.decode(response.body).cast<Map<String, dynamic>>();
      print(jsonData[0]);
      print(jsonData[1]);
      _imagePath = (jsonData[0] as List)
                    .map((e) => e as String).toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data JSON"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: new Text("Fetch Data"),
            onPressed: _fetchData,
          ),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: _imagePath.length,
          itemBuilder: (context, index) {
            return Image.network("https://drawing.nopublisher.dev/images/"+_imagePath[index]);//list[index].image_name);
          },
        ));
  }
}