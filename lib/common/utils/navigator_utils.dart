import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/pages/home/home_page.dart';
import 'package:github_flutter/pages/login/login_page.dart';
import 'package:github_flutter/pages/search/search_page.dart';

/**
 * 导航控制
 */

class NavigatorUtils {
  // 主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  // 登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  // 搜索页
  static Future goSearch(BuildContext context, Offset centerPosition) {
    return showGeneralDialog(
      context: context,
      barrierColor: Color(0x01000000),
      barrierDismissible: false,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Builder(builder: (BuildContext context) {
          return pageContainer(SearchPage(centerPosition), context);
        });
      },
    );
  }

  // page页面的容器，做一次通用自定义
  static Widget pageContainer(widget, BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: widget,
    );
  }

  // 弹框
  static Future<T> showGSYDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .copyWith(textScaleFactor: 1),
            child: SafeArea(
              child: builder(context),
            ),
          );
        });
  }
}
