import 'package:flutter/material.dart';

class GSYTabBarWidget extends StatefulWidget {
  GSYTabBarWidget({this.title}) : super();
  final String title;
  @override
  _GSYTabBarWidget createState() => _GSYTabBarWidget();
}

class _GSYTabBarWidget extends State<GSYTabBarWidget> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
