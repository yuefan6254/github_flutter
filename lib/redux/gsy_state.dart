import 'package:flutter/material.dart';
import 'package:github_flutter/model/User.dart';
import 'package:github_flutter/redux/locale_redux.dart';
import 'package:github_flutter/redux/middleware/epic_middleware.dart';
import 'package:github_flutter/redux/theme_redux.dart';
import 'package:github_flutter/redux/user_redux.dart';
import 'package:redux/redux.dart';

/**
 * Redux 全局State
 */

// 全局Redux Store对象，保存State对象
class GSYState {
  // 用户信息
  User userInfo;

  // 主题数据
  ThemeData themeData;

  // 语言
  Locale locale;

  // 当前手机平台默认语言；
  Locale platformLocale;

  // 是否登录
  bool login;

  GSYState({this.userInfo, this.themeData, this.locale, this.login});
}

GSYState appReducer(GSYState state, action) {
  return GSYState(
    userInfo: UserReducer(state.userInfo, action),
    themeData: ThemeDataReducer(state.themeData, action),
    locale: LocaleReducer(state.locale, action),
  );
}

final List<Middleware<GSYState>> middleware = [
  EpicMiddleware<GSYState>(userInfoEpic),
  UserInfoMiddleware(),
];
