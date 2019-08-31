import 'package:flutter/material.dart';
import 'package:circlemanage/resource/dimen.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circlemanage/home/home.dart';

class CreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _passwordconfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text(
                      'Create\nAccount',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
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
                      /*
                      validator: (String value) {

                        return value.contains('@')
                            ? 'Do not use the @ char.'
                            : null;
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
                      /*
                      validator: (String value) {
                        return value.contains('@')
                            ? 'Do not use the @ char.'
                            : null;
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
                        labelText: 'PasswordConfirm',
                      ),
                      onSaved: (String value) {
                        _passwordconfirm = value;
                      },
                      obscureText: true,
                      /*
                      validator: (String value) {
                        return value.contains('@')
                            ? 'Do not use the @ char.'
                            : null;
                      },
                      */
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          padding: EdgeInsets.only(
                              right: 100, left: 100, top: 15, bottom: 15),
                          elevation: Dimen.elevation,
                          highlightElevation: Dimen.highlightelevation,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          color: Colors.blue,
                          child: Text(
                            'Create',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          onPressed: signUp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    if (_password == _passwordconfirm) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _email, password: _password);
          FirebaseUser user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          Firestore.instance.collection('users').document(user.uid).setData({
            "email": _email,
            "uid": user.uid,
            "circlenames": [],
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePage(user: user)));
        } catch (e) {
          print(e.message);
          final snackBar = SnackBar(
            content: Text('Please Check Email and Password Form!!'),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      final snackBar = SnackBar(
        content: Text('Please Check Password Confirm!!'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
