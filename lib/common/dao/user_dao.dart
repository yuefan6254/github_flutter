import 'package:flutter/material.dart';
import 'package:github_flutter/common/net/api.dart';
import 'package:redux/redux.dart';
import 'package:github_flutter/common/config/ignoreConfig.dart';

/**
 * 用户相关数据服务
 */
class UserDao {
  // 获取用户详细信息
  static getUserInfo(userName, {needDb = false}) async {
    print("***************获取用户数据*****************");
  }

  // 初始化用户信息
  static initUserInfo(Store store) async {
    return false;
  }

  // 通过oauth方式，获取用户数据
  static oauth(code, store) async {
    httpManager.clearAuthorization();

    var res = await httpManager.netFetch(
      "https://github.com/login/oauth/access_token?client_id=${NetConfig.CLIENT_ID}&client_secret=${NetConfig.CLIENT_SECTET}&code=&code=${code}",
      null,
      null,
      null,
    );
  }
}
