import 'package:flutter/cupertino.dart';
import 'package:github_flutter/widgets/pull/gsy_pull_load_widget.dart';

/**
 * 上下拉刷新列表，通用state
 */

mixin GSYListState<T extends StatefulWidget>
    on State<T>, AutomaticKeepAliveClientMixin<T> {
  bool isShow = false;

  bool isLoading = false;

  final GSYPullLoadWidgetControl pullLoadWidgetControl =
      GSYPullLoadWidgetControl();

  @protected
  Future<Null> handleRefresh() async {
    print("上滑刷新");
  }

  @override
  void initState() {
    super.initState();

    isShow = true;

    print('dikskksk isshow $isShow');
  }
}
