import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/widgets/pull/gsy_pull_load_widget.dart';
import 'package:github_flutter/common/config/config.dart';

/**
 * 上下拉刷新列表，通用state
 */

mixin GSYListState<T extends StatefulWidget>
    on State<T>, AutomaticKeepAliveClientMixin<T> {
  bool isShow = false;

  bool isLoading = false;

  int page = 1;

  bool isRefreshing = false;

  bool isLoadMoring = false;

  final List dataList = List();

  final GSYPullLoadWidgetControl pullLoadWidgetControl =
      GSYPullLoadWidgetControl();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // loading时，等待
  _lockToAwait() async {
    doDelayed() async {
      await Future.delayed(Duration(seconds: 1)).then((_) async {
        if (isLoading) {
          return await doDelayed();
        } else {
          return null;
        }
      });
    }

    await doDelayed();
  }

  // 刷新
  @protected
  Future<Null> handleRefresh() async {
    print("刷新");
    if (isLoading) {
      if (isRefreshing) {
        return null;
      }

      await _lockToAwait();
    }

    isLoading = true;
    isRefreshing = true;
    page = 1;
    var res = await requestRefresh();

    if (res != null && res.result) {
      pullLoadWidgetControl.dataList.clear();

      setState(() {
        pullLoadWidgetControl.dataList.addAll(res.data);
      });
    }

    isLoading = false;
    isRefreshing = false;
    return null;
  }

  // 加载更多
  Future<Null> onLoadMore() async {
    print("加载更多");
    if (isLoading) {
      if (isLoadMoring) {
        return null;
      }

      await _lockToAwait();
    }

    isLoading = true;
    isLoadMoring = true;
    page++;
    var res = await requestLoadMore();

    if (res != null && res.result) {
      setState(() {
        pullLoadWidgetControl.dataList.addAll(res);
        pullLoadWidgetControl.needLoadMore.value =
            (res.data != null && res.data.length >= Config.PAGE_SIZE);
      });
    }
  }

  // 应用方提供的下拉刷新数据方法
  @protected
  requestRefresh() async {}

  // 应用方提供的上滑加载更多数据方法
  @protected
  requestLoadMore() async {}

  // 首次进入是否自动刷新
  bool get isRefreshFirst;

  showRefreshLoading() {
    Future.delayed(Duration(seconds: 0), () {
      refreshIndicatorKey.currentState.show().then((e) => null);
      return true;
    });
  }

  @override
  void initState() {
    super.initState();

    if (pullLoadWidgetControl.dataList.length == 0 && isRefreshFirst) {
      showRefreshLoading();
    }
  }
}
