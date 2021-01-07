import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:github_flutter/common/localization/localizations.dart';
import 'package:github_flutter/common/style/gsy_style.dart';

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

  // 空页面
  Widget _buildEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // FlatButton(
          //   onPressed: () {},
          //   child: Image(
          //     image: AssetImage(GSYICons.DEFAULT_USER_ICON),
          //     width: 70,
          //     height: 70,
          //   ),
          // ),
          Container(
            child: Text(
              GSYLocalizations.i18n(context).app_empty,
              style: GSYConstant.normalText,
            ),
          )
        ],
      ),
    );
  }

  _getListCount() {
    if (widget.control.dataList.length == 0) {
      return 1;
    }

    return widget.control.dataList.length + 1;
  }

  _getItem(int index) {
    if (widget.control.dataList.length == 0) {
      return _buildEmpty();
    }

    if (index == widget.control.dataList.length) {
      return _buildProgressIndicator();
    }

    return widget.itemBuilder(context, index);
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      notificationPredicate: (_) => true,
      key: widget.refreshKey,
      onRefresh: widget.onRefresh,
      child: NestedScrollView(
        controller: widget.scrollController,
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: widget.headerSliverBuilder,
        body: NotificationListener(
            onNotification: (ScrollNotification p) {
              if (p.metrics.pixels >= p.metrics.maxScrollExtent) {
                if (widget.control.needLoadMore.value) {
                  widget.onLoadMore.call();
                }
              }
              return false;
            },
            child: ListView.builder(
              itemBuilder: (_, index) {
                return _getItem(index);
              },
              itemCount: _getListCount(),
            )),
      ),
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
