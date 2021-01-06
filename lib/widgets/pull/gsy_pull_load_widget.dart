import 'package:flutter/material.dart';

/**
 * 通用上滑加载，下拉刷新组件
 */

class GSYPullLoadWidget extends StatefulWidget {
  // item渲染
  final IndexedWidgetBuilder itemBuilder;

  // 上滑加载更多回调
  final RefreshCallback onLoadMore;

  // 下拉刷新回调
  final RefreshCallback onRefresh;

  // 控制器
  final GSYPullLoadWidgetControl control;

  // globalkey, 外部获取refreshIndicator的State, 做显示刷新
  final Key refreshKey;

  final NestedScrollViewHeaderSliversBuilder headerSliverBuilder;

  // 滑动控制器
  final ScrollController scrollController;

  GSYPullLoadWidget({
    this.itemBuilder,
    this.onLoadMore,
    this.onRefresh,
    this.control,
    this.refreshKey,
    this.headerSliverBuilder,
    this.scrollController,
  });

  _GSYPullLoadWidgetState createState() => _GSYPullLoadWidgetState();
}

class _GSYPullLoadWidgetState extends State<GSYPullLoadWidget> {
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: widget.refreshKey,
      onRefresh: widget.onRefresh,
      child: NestedScrollView(
        controller: widget.scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: widget.headerSliverBuilder,
        body: NotificationListener(child: null),
      ),
    );
  }
}

// 控制器
class GSYPullLoadWidgetControl {
  // 数据，对齐增减，不能替换
  List dataList = List();

  // 是否需要加载更多
  ValueNotifier needLoadMore = ValueNotifier(false);

  // 是否需要头部
  bool needHeader = false;
}
