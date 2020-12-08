import 'package:flutter/material.dart';

/**
 * 趋势 tab页
 */

class TrendPage extends StatefulWidget {
  TrendPage({Key key}) : super(key: key);
  @override
  TrendPageState createState() => TrendPageState();
}

class TrendPageState extends State<TrendPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('趋势'),
      ),
    );
  }
}
