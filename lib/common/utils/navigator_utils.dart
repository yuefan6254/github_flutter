import 'package:flutter/cupertino.dart';
import 'package:github_flutter/pages/home/home_page.dart';

/**
 * 导航控制
 */

class NavigatorUtils {
  // 主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }
}
