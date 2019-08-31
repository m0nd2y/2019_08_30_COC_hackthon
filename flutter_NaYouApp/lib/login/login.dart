import 'package:flutter/material.dart';
import 'package:circlemanage/login/create.dart';
import 'package:circlemanage/resource/dimen.dart';
import 'package:circlemanage/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned(
              top: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '아이디가 없다면?',
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatePage()));
                      },
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 180,
                        height: 180,
                        child: Center(
                          child: Text(
                            '로고',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 50),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            //icon: Icon(Icons.email),
                            //hintText: 'What do people call you?',
                            labelText: 'Email',
                          ),
                          onSaved: (String value) {
                            _email = value;
                          },
                          /*validator: (String value) {
                      return value.contains('@')
                          ? 'Do not use the @ char.' : null;
                    },
                    */
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            //icon: Icon(Icons.lock),
                            //hintText: 'What do people call you?',
                            labelText: 'Password',
                          ),
                          onSaved: (String value) {
                            _password = value;
                          },
                          obscureText: true,
                          /*validator: (String value) {
                      return value.contains('@')
                          ? 'Do not use the @ char.' : null;
                    },
                    */
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: RaisedButton(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                elevation: Dimen.getelevation(),
                highlightElevation: Dimen.highlightelevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Container(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Center(
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  signIn();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomePage(user: user)));
      } catch (e) {
        print(e.message);
        setState(() {
          print("Error");
        });
      }
    }
  }
}
