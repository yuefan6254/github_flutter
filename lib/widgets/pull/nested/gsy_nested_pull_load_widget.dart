import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 通用下上刷新控件
 */

class GSYNestedPullLoadWidget extends StatefulWidget {
  // 控制器
  // final

  // 上拉加载更多部分 widget
  final IndexedWidgetBuilder itemBuilder;

  GSYNestedPullLoadWidget(this.itemBuilder);

  _GSYNestedPullLoadWidgetState createState() =>
      _GSYNestedPullLoadWidgetState();
}

class _GSYNestedPullLoadWidgetState extends State<GSYNestedPullLoadWidget> {
  // 上拉加载更多 loading widget
  Widget _buildProcessIndicator() {}

  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: null,
      onRefresh: null,
    );
  }
}
