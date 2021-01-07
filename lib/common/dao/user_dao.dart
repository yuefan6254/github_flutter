import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_flutter/common/dao/dao_result.dart';
import 'package:github_flutter/common/local/local_storage.dart';
import 'package:github_flutter/common/net/address.dart';
import 'package:github_flutter/common/net/api.dart';
import 'package:github_flutter/common/utils/common_utils.dart';
import 'package:github_flutter/db/provider/user_orgs_db_provider.dart';
import 'package:github_flutter/db/provider/userinfo_db_provider.dart';
import 'package:github_flutter/model/UserOrg.dart';
import 'package:github_flutter/redux/locale_redux.dart';
import 'package:github_flutter/redux/user_redux.dart';
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
      } else {
        res = await httpManager.netFetch(
            Address.getUserInfo(userName), null, null, null);
      }

      if (res != null && res.result) {
        String starred = "---";
        if (res.data["type"] != "Organization") {
          var countRes = await getUserStaredCountNet(res.data["login"]);

          if (countRes.result) {
            starred = countRes.data;
          }
        }

        User user = User.fromJson(res.data);
        user.starred = starred;

        if (userName == null) {
          LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
        } else {
          if (needDb) {
            provider.insert(userName, json.encode(user.toJson()));
          }
        }

        return DataResult(user, true);
      } else {
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
      return DataResult(user, true);
    } else {
      return DataResult(null, false);
    }
  }

  // 初始化用户信息
  static initUserInfo(Store store) async {
    print("************initUserInfo************");
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    var res = await getUserInfoLocal();
    //将localstorage中用户数据，主题数据，语言数据更新到store中

    //用户数据
    if (res != null && res.result && token != null) {
      store.dispatch(UpadateUserAction(res.data));
    }

    // 主题数据
    String themeIndex = await LocalStorage.get(Config.THEME_COLOR);
    if (themeIndex != null && themeIndex.length != 0) {
      CommonUtils.pushTheme(store, int.parse(themeIndex));
    }

    //语言数据
    String localIndex = await LocalStorage.get(Config.LOCALE);
    if (localIndex != null && localIndex.length != 0) {
      CommonUtils.changeLocale(store, int.parse(localIndex));
    } else {
      CommonUtils.curLocale = store.state.platformLocale;
      store.dispatch(RefreshLocaleAction(store.state.platformLocale));
    }

    return DataResult(res.data, (res.result && (token != null)));
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

    if (res != null && res.result) {
      var result = Uri.parse("gsy://oauth?" + res.data);
      var token = result.queryParameters["access_token"];
      var _token = "token " + token;
      await LocalStorage.save(Config.TOKEN_KEY, _token);

      resultData = await getUserInfo(null);

      if (resultData.result == true) {
        store.dispatch(UpadateUserAction(resultData.data));
      }
    }

    return new DataResult(resultData, res.result);
  }

  // 在header中提起stared count
  static getUserStaredCountNet(userName) async {
    String url = Address.userStar(userName, null) + "&per_page=1";
    var res = await httpManager.netFetch(url, null, null, null);

    if (res != null && res.result && res.headers != null) {
      try {
        List<String> link = res.headers['link'];

        if (link != null) {
          int indexStart = link[0].lastIndexOf("page=") + 5;
          int indexEnd = link[0].lastIndexOf(">");

          if (indexEnd >= 0 && indexStart >= 0) {
            String count = link[0].substring(indexStart, indexEnd);

            return DataResult(count, true);
          }
        }
      } catch (e) {
        print(e);
      }
    }

    return DataResult(null, false);
  }

  // 获取用户组织
  static getUserOrgsDao(userName, page, {needDb = false}) async {
    UserOrgsDbProvider provider = UserOrgsDbProvider();
    next() async {
      String url =
          Address.getUserOrgs(userName) + Address.getPageParams("?", page);
      var res = await httpManager.netFetch(url, null, null, null);
      if (res != null && res.result) {
        List<UserOrg> list = new List();
        var data = res.data;
        if (data == null || data.length == 0) {
          return new DataResult(null, false);
        }
        for (int i = 0; i < data.length; i++) {
          list.add(new UserOrg.fromJson(data[i]));
        }
        if (needDb) {
          provider.insert(userName, json.encode(data));
        }
        return new DataResult(list, true);
      } else {
        return new DataResult(null, false);
      }
    }

    if (needDb) {
      List<UserOrg> list = await provider.geData(userName);
      if (list == null) {
        return await next();
      }
      DataResult dataResult = new DataResult(list, true, next: next);
      return dataResult;
    }
    return await next();
  }
}
