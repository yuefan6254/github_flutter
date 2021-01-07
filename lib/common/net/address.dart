import 'package:github_flutter/common/config/config.dart';
import 'package:github_flutter/common/config/ignoreConfig.dart';

/**
 * 地址数据
 */

class Address {
  static const String host = "https://api.github.com/";
  static const String hostWeb = "https://github.com/";
  static const String graphicHost = "https://ghchart.rshah.org/";
  static const String updateUrl = "https://www.pgyer.com/gupa";

  // oauth 地址
  static getOauthUrl() {
    return "https://github.com/login/oauth/authorize?client_id=${NetConfig.CLIENT_ID}&state=app&redirect_uri=gsygithubapp://authed";
  }

  // 我的用户信息
  static getMyUserInfo() {
    return "${host}user";
  }

  // 用户信息
  static getUserInfo(userName) {
    return "${host}users/$userName";
  }

  // 用户的star
  static userStar(userName, sort) {
    sort ??= 'updated';

    return "${host}users/$userName/starred?sort=$sort";
  }

  ///获取用户组织
  static getUserOrgs(userName) {
    return "${host}users/$userName/orgs";
  }

  ///处理分页参数
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return "${tab}page=$page&per_page=$pageSize";
      } else {
        return "${tab}page=$page";
      }
    } else {
      return "";
    }
  }

  ///用户收到的事件信息 get
  static getEventReceived(userName) {
    return "${host}users/$userName/received_events";
  }

  ///用户相关的事件信息 get
  static getEvent(userName) {
    return "${host}users/$userName/events";
  }
}
