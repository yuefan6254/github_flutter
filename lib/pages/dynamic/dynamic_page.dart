import 'package:flutter/material.dart';

/**
 * 动态 tab页
 */

class DynamicPage extends StatefulWidget {
  DynamicPage({Key key}) : super(key: key);
  @override
  DynamicPageState createState() => DynamicPageState();
}

class DynamicPageState extends State<DynamicPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('动态'),
      ),
    );
  }
}
