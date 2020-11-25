import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomePage.sName: (context) {
          return WelcomePage();
        }
      },
    );
  }
}
