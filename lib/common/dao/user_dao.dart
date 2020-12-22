import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

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
}
