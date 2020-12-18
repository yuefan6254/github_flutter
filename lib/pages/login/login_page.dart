import 'package:flutter/material.dart';

/**
 * 登录页
 */

class LoginPage extends StatefulWidget {
  static final String sName = 'login';

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('登录'),
      ),
    );
  }
}
