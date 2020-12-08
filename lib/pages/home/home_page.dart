import 'dart:io';

import 'package:flutter/material.dart';
import 'package:github_flutter/widgets/gsy_tabbar_widget.dart';
import 'package:github_flutter/pages/dynamic/dynamic_page.dart';
import 'package:github_flutter/pages/trend/trend_page.dart';
import 'package:github_flutter/pages/my_page.dart';
import 'package:github_flutter/common/style/gsy_style.dart';

/**
 * 主页
 */

class HomePage extends StatefulWidget {
  static final String sName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<DynamicPageState> dynamicKey = GlobalKey();
  final GlobalKey<TrendPageState> trendKey = GlobalKey();
  final GlobalKey<MyPageState> myKey = GlobalKey();

  _renderTab(icon, text) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Icon(icon, size: 16), Text(text)],
      ),
    );
  }

  // 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    // 如果是android回到桌面
    if (Platform.isAndroid) {}
  }

  Widget build(BuildContext context) {
    List<Widget> tabItems = [
      _renderTab(GSYICons.MAIN_DT, '动态'),
      _renderTab(GSYICons.MAIN_QS, '趋势'),
      _renderTab(GSYICons.MAIN_MY, '我的')
    ];

    return WillPopScope(
        onWillPop: () {
          return _dialogExitApp(context);
        },
        child: GSYTabBarWidget(
          type: TabType.bottom,
          tabItems: tabItems,
          tabViews: [
            DynamicPage(key: dynamicKey),
            TrendPage(key: trendKey),
            MyPage(key: myKey)
          ],
        ));
  }
}
