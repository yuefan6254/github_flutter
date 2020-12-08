import 'package:flutter/material.dart';

/**
 * 我的 tab页
 */

class MyPage extends StatefulWidget {
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('我的'),
      ),
    );
  }
}
