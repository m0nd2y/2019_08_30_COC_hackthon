import 'package:flutter/material.dart';
import 'package:circlemanage/ict/homescreen.dart';
import 'package:circlemanage/ict/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 10,
        title: Container(
          child: Row(
            children: <Widget>[
              Image.asset(
                'lib/assets/ny_logo.png',
                height: 30,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProfilePage(name: '신승민'),
                        ),
                      );
                    },
                    child: Image.asset(
                      'lib/assets/menu.png',
                      height: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: HomeScreenPage(),
    );
  }
}
