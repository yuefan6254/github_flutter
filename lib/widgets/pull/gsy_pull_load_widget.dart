import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:github_flutter/common/localization/localizations.dart';

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
  _getItem(int index) {
    print(index);

    // if (index == 49) {
    //   return _buildProgressIndicator();
    // }

    return Container(
      alignment: Alignment.center,
      color: Colors.lightBlue[100 * (index % 9)],
      child: Text('list item $index'),
      height: 130,
    );
  }

  Future<Null> onRefresh() async {
    print('立即执行下拉刷新');
    await Future.delayed(Duration(seconds: 1), () {
      print('下拉刷新');
    });
  }

  // 上拉加载更多
  Widget _buildProgressIndicator() {
    Widget bottomWidget = (widget.control.needLoadMore.value)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitRotatingCircle(
                color: Theme.of(context).primaryColor,
              ),
              Container(
                width: 5,
              ),
              Text(
                GSYLocalizations.i18n(context).load_more_text,
                style: TextStyle(
                    color: Color(0xFF121917),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        : Container();

    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: bottomWidget,
      ),
    );
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      notificationPredicate: (_) => true,
      key: widget.refreshKey,
      onRefresh: onRefresh,
      child: NestedScrollView(
        controller: widget.scrollController,
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: widget.headerSliverBuilder,
        body: NotificationListener(
            child: ListView.builder(
          itemBuilder: (_, index) {
            return _getItem(index);
          },
          itemCount: 50,
        )),
      ),

      // child: ListView.builder(
      //   physics: BouncingScrollPhysics(),
      //   itemBuilder: (_, index) {
      //     return _getItem(index);
      //   },
      //   itemCount: 6,
      // ),
    );
  }
}

// 控制器
class GSYPullLoadWidgetControl {
  // 数据，对齐增减，不能替换
  List dataList = List();

  // 是否需要加载更多
  ValueNotifier<bool> needLoadMore = ValueNotifier(false);

  // 是否需要头部
  bool needHeader = false;
}
