import 'package:flutter/material.dart';
import 'package:circlemanage/login/login.dart';
import 'package:circlemanage/ict/home.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(79, 92, 241, .1),
  100: Color.fromRGBO(79, 92, 241, .2),
  200: Color.fromRGBO(79, 92, 241, .3),
  300: Color.fromRGBO(79, 92, 241, .4),
  400: Color.fromRGBO(79, 92, 241, .5),
  500: Color.fromRGBO(79, 92, 241, .6),
  600: Color.fromRGBO(79, 92, 241, .7),
  700: Color.fromRGBO(79, 92, 241, .8),
  800: Color.fromRGBO(79, 92, 241, .9),
  900: Color.fromRGBO(79, 92, 241, 1),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MaterialColor myColor = MaterialColor(0xFF880E4F, color);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: myColor,
        primaryColor: Colors.white,
        accentColor: const Color(0xFF4f5cf1),
      ),
      home: HomePage(),
    );
  }
}
