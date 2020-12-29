import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_flutter/common/dao/dao_result.dart';
import 'package:github_flutter/common/local/local_storage.dart';
import 'package:github_flutter/common/net/address.dart';
import 'package:github_flutter/common/net/api.dart';
import 'package:github_flutter/db/provider/userinfo_db_provider.dart';
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
    UserInfoDBProvider provider = UserInfoDBProvider();
    next() async {
      var res;

      if (userName == null) {
        res = await httpManager.netFetch(
            Address.getMyUserInfo(), null, null, null);

        print(res.data);

        return DataResult(res.data, false);
      }
    }

    if (needDb) {
      User user = await provider.getUserInfo(userName);

      if (user == null) {
        return await next();
      }

      DataResult dataResult = DataResult(user, true, next: next);
      return dataResult;
    }
    return await next();
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
    httpManager.clearAuthorization();

    var resultData;
    var res = await httpManager.netFetch(
      "https://github.com/login/oauth/access_token?client_id=${NetConfig.CLIENT_ID}&client_secret=${NetConfig.CLIENT_SECTET}&code=&code=${code}",
      null,
      null,
      null,
    );

    print(res);
    print(res.data);
    if (res != null && res.result) {
      var result = Uri.parse("gsy://oauth?" + res.data);
      var token = result.queryParameters["access_token"];
      var _token = "token " + token;
      await LocalStorage.save(Config.TOKEN_KEY, _token);

      resultData = await getUserInfo(null);
    }

    return DataResult(resultData, res.result);
  }
}
