import 'package:github_flutter/common/config/ignoreConfig.dart';

/**
 * 地址数据
 */

class Address {
  static const String host = "https://api.github.com/";
  static const String hostWeb = "https://github.com/";
  static const String graphicHost = "https://ghchart.rshah.org";
  static const String updateUrl = "https://www.pgyer.com/gupa";

  // oauth 地址
  static getOauthUrl() {
    return "https://github.com/login/oauth/authorize?client_id=${NetConfig.CLIENT_ID}&state=app&redirect_uri=gsygithubapp://authed";
  }

  // 我的用户信息
  static getMyUserInfo() {
    return "${host}user";
  }
}
