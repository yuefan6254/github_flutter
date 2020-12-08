import 'package:flutter/material.dart';

/**
 * 动态 tab页
 */

class DynamicPage extends StatefulWidget {
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('动态'),
      ),
    );
  }
}
