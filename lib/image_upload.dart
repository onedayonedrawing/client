import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:onedayonedrawing/Model/Boards.dart';
import 'package:onedayonedrawing/sign_in.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  bool _titleNotice = false;
  bool _categoryNotice = false;
  bool _isLoading = false;
  List<String> dropdownValue = ['Category','Category','Category'];
  List<String> category = ['Category', 'Category', 'Category'];
  final List<String> _items = <String>[
    'Category',
    '1. 낙서',
    '2. 데셍',
    '3. 배경',
    '4. 사람',
    '5. 몬스터',
    '6. 동물',
    '7. 사물',
    '8. 게임 일러스트',
    '9. 판타지',
    '10. 기타'
  ];
  File _image;
  final titleController = TextEditingController();
  final contentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 그림'),
      ),
      body: _isLoading
          ?
      Center(
        child: CircularProgressIndicator(),
      )
          :
      Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: titleController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: _titleNotice
                          ? BorderSide(color: Colors.red)
                          : BorderSide(color: Colors.white),
                  ),
                  labelText: "Title",
                  hintText: '제목을 적어주세요!',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            _image == null
            ? RaisedButton(
                onPressed: () async {
                  await _selectImage();
                },
                child: Text('Select Image'),
              )
            : Image.file(_image,
              fit: BoxFit.fill,
              alignment: Alignment.center,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: contentController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide()
                  ),
                  labelText: "Content",
                  hintText: '내용을 적어주세요(선택)',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            // 카테고리를 최대 3개까지 선택할 수 있다.
            //선택할 때 마다 선택창이 하나씩 증가.
            dropdownMenu(0),
            category[0] != 'Category'
                ? dropdownMenu(1) : Container(),
            category[1] != 'Category'
                ? dropdownMenu(2) : Container(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: _image == null
                  ?
                (){}
                :
                _upload,
                ),
              ),
            ]
        ),
      ),
    );
  }

  _selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 512, imageQuality: 80);
    print(image.path);
    setState(() {
      _image = image;
    });
  }

  _upload() async {
    setState(() {
      _isLoading = true;
    });
    //if (_image == null) return;
    //ImageProperties properties = await FlutterNativeImage.getImageProperties(_image.path);
    //File compressedFile = await FlutterNativeImage.compressImage(_image.path,
    //    quality: 80, percentage: 50);
    //String base64Image = base64Encode(_image.readAsBytesSync());
    //String fileName = _image.path.split("/").last;
    //print(fileName);
    if(category[0] == 'Category'){
      setState(() {
        _categoryNotice = true;
        _isLoading = false;
      });
    }
    if(titleController.text == ""){
      setState(() {
        _titleNotice = true;
        _isLoading = false;
      });
    }
    if(category[0] == 'Category' || titleController.text == "" || _image == null){
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('작성해 주세요!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('제목, 카테고리, 그림을 확인해 주세요'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else{
      int _i = 0;
      for(var i = 0; i < category.length; ++i){
        if(category[i] != "Category"){
          ++_i;
        }
      }
      List<int> addCategory = new List(_i);
      for(var i = 0; i < _i; ++i){
        String _temp = category[i].split(".").first;
        int _number = int.parse(_temp);
        addCategory[i] = _number;
      }
      var _board = new Boards();
      _board.create_user = loginUser;
      _board.category = addCategory;
      _board.title = titleController.text;
      if(Platform.isAndroid){
        _board.image_name = _image.path.split("scaled_IMG_").last;
      } else if(Platform.isIOS){
        _board.image_name = _image.path.split("image_picker_").last;
      }
      _board.content = contentController.text;

      await _sendHttpReq(_board);

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  _sendHttpReq(Boards _board) async {
    var _boardJson = _board.toJson();//jsonEncode(_board);
    var encodeBoard = jsonEncode(_boardJson);
    var url = "https://drawing.nopublisher.dev/image_upload";
    //var res = await http.post(
    //    url,
    //    body: encodeBoard, 
    //    headers: { "accept": "application/json", "content-type": "application/json" }
    //  );
    //if(res.statusCode == 200){
    // 응답을 받았을 경우 처리
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    var length = await _image.length();
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    //request.fields['reqinfo'] = '12333';
    var multipartFile = new http.MultipartFile('image_name', stream, length,
        filename: _board.image_name,
        contentType: new MediaType('image', 'png'),
        );

    request.files.add(multipartFile);
    request.files.add(
      new http.MultipartFile.fromBytes(
        'board_info',
        utf8.encode(encodeBoard),
        contentType: new MediaType(
          'application',
          'json',
          {'charset': 'utf-8'},
        ),
      )
    );

    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    //} // else if (res.statusCode == 404,403,401){}
  }


  Widget dropdownMenu(int _index){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        value: dropdownValue[_index],
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            color: Colors.white30
        ),
        underline: _categoryNotice
        ?
        Container(
          height: 2,
          color: Colors.red,
        )
        :
        Container(
          height: 2,
          color: Colors.green,
        ),
        onChanged: (String newValue) {
          setState(() {
            _categoryNotice = false;
            dropdownValue[_index] = newValue;
            category[_index] = newValue;
          });
        },
        items: _items
            .map<DropdownMenuItem<String>>((String value) {
              if(category[0] == "Category"){
                for(var i = 0; i < category.length; ++i){
                  category[i] = "Category";
                  dropdownValue[i] = "Category";
                }
              }else if(category[1] == "Category"){
                category[2] = "Category";
                dropdownValue[2] = "Category";
              }
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        })
            .toList(),
      ),
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
}

