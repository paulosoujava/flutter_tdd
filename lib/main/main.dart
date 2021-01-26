import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../ui/components/components.dart';
import './factories/factories.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: makeLoginPage,
        ),
        GetPage(
            name: '/home',
            page: () => Scaffold(
                  body: Text("HOME"),
                )),
      ],
    );
  }
}
