import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/pages.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xfffbb448),
        primaryColor: Color(0xfff7892b),
        primaryColorDark: Color(0xfff7884c),
        backgroundColor: Colors.white,
      ),
      home: LoginPage(),
    );
  }
}
