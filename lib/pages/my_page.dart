import 'package:flutter/material.dart';

/**
 * 我的 tab页
 */

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('我的'),
      ),
    );
  }
}
