import 'package:flutter/material.dart';
import 'package:onedayonedrawing/sign_in.dart';

class SetNickname extends StatefulWidget {
  @override
  _SetNicknameState createState() => _SetNicknameState();
}

class _SetNicknameState extends State<SetNickname> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _isNickname = false;
    return Scaffold(
      appBar: AppBar(title: Text('test input text'),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
              children: <Widget>[
                Text('Set Your Nickname', style: TextStyle(fontSize: 20),),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: myController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: _isNickname
                                ? BorderSide(color: Colors.red)
                                : BorderSide(color: Colors.white),
                        ),
                        labelText: "Nickname",
                        hintText: '닉네임을 적어주세요!',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                  ),
                ),
                OutlineButton(
                  splashColor: Colors.grey,
                  onPressed: () async{
                    if(myController.text == ""){
                      setState(() {
                        _isNickname = true;
                      });
                      plzSetNickname();
                    } else{
                      loginUser.nickname = myController.text;
                      await setNickname();
                      Navigator.of(context).pop();
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  highlightElevation: 0,
                  borderSide: BorderSide(color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'confirm',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]
          ),
        ),
        )

    );
  }
  plzSetNickname (){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('작성해 주세요!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('닉네임을 적어주세요'),
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
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
}
