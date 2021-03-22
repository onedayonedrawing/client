import 'package:flutter/material.dart';
import 'package:onedayonedrawing/sign_in.dart';

class AccountTap extends StatefulWidget {
  @override
  _AccountTapState createState() => _AccountTapState();
}

class _AccountTapState extends State<AccountTap> {
  bool _isLogined;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Account'),
        ),
      ),
      body: _isLoading
      ?
      Center(
        child: CircularProgressIndicator(),
      )
      :
      _isLogined
      ?
      Container(
        child:
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Email : ', style: TextStyle(fontSize: 20),),
                  Text(loginUser.email, style: TextStyle(fontSize: 20),),
                ],
              ),
              //닉네임이 없으면 닉네임 설정창을 보여줌 (닉네임이 없으면 맨 처음 로그인한것과 같음 == )
              getNickname(),
              //GridView.builder(
              //    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //      crossAxisCount: 4,
              //    ),
              //    itemCount: loginUser.boardArr.length,
              //    itemBuilder: (context, i){
              //      return loginUser.boardArr.
              //    },
              //),


              //로그아웃 버튼은 나중에 따로 다른곳으로 빼기!!!!!!!!!!!!!!!!!!!!!!!!
              _signOutButton(),
            ],
          ),
        ),
      )
      :
      Container(
        child:
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
      //로딩중 일때는 게시 버튼 안보이게
        floatingActionButton: !_isLoading
      ?
        Visibility(
          //로그인 하지 않은 상태나 닉네임이 없다면 버튼이 안보이게
          visible: _isLogined && loginUser.nickname != null,
          child: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text("게시"),
            onPressed: (){
              Navigator.of(context).pushNamed('/image_upload');
            },
          ),
        )
      :
        Visibility(
          visible: false,
          child: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text("게시"),
            onPressed: (){

            },
          ),
        ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).pushReplacementNamed('/root');
        });
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
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _signOutButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signOutGoogle().whenComplete(() {
          Navigator.of(context).pushReplacementNamed('/root');
        });
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
                'Sign Out',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      _isLoading = true;
    });
    isLogined();
  }

  isLogined(){
    accountCheck().then((result) {
      setState(() {
        _isLogined = result;
        _isLoading = false;
      });
    });
  }

  Widget getNickname(){
    if(loginUser.nickname == null){
      return OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
            Navigator.of(context).pushNamed('/set_nickname');
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
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Set Nickname',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Nickname : ", style: TextStyle(fontSize: 20,),),
                Text(loginUser.nickname, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),)
              ]
            ),
          ),
      );
    }
  }
}


//Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return RootPage();}), ModalRoute.withName('/'));
//Navigator.of(context).push
