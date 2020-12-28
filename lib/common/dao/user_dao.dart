import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_flutter/common/dao/dao_result.dart';
import 'package:github_flutter/common/local/local_storage.dart';
import 'package:github_flutter/common/net/api.dart';
import 'package:redux/redux.dart';
import 'package:github_flutter/common/config/ignoreConfig.dart';
import 'package:github_flutter/common/config/config.dart';
import 'package:github_flutter/model/User.dart';

/**
 * 用户相关数据服务
 */
class UserDao {
  // 获取用户详细信息
  static getUserInfo(userName, {needDb = false}) async {
    print("***************获取用户数据*****************");
  }

  // 获取本地登录用户信息
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);

    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return DataResult(user, false);
    } else {
      return DataResult(null, true);
    }
  }

  // 初始化用户信息
  static initUserInfo(Store store) async {
    return false;
  }

  // 通过oauth方式，获取用户数据
  static oauth(code, store) async {
    print("进入oauth方法内");
    httpManager.clearAuthorization();

    var resultData = null;
    // var res = await httpManager.netFetch(
    //   "https://github.com/login/oauth/access_token?client_id=${NetConfig.CLIENT_ID}&client_secret=${NetConfig.CLIENT_SECTET}&code=&code=${code}",
    //   null,
    //   null,
    //   null,
    // );

    var res = await httpManager.netFetch(
        "https://github.com/login/oauth/access_token?"
        "client_id=${NetConfig.CLIENT_ID}"
        "&client_secret=${NetConfig.CLIENT_SECTET}"
        "&code=$code",
        null,
        null,
        null);

    print("res结果 ${res.toString()}");

    print("########## ${res.data.toString()}");
    if (res != null && res.result) {}

    return DataResult(resultData, res.result);
  }
}
