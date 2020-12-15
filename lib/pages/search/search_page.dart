import 'package:flutter/material.dart';

/**
 * 搜索页
 */

class SearchPage extends StatefulWidget {
  final Offset centerPosition;
  SearchPage(this.centerPosition);
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Scaffold(
          appBar: AppBar(
            title: Text('搜索页'),
          ),
        ));
  }
}
