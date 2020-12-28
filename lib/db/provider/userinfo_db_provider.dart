import 'package:github_flutter/db/sql_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:github_flutter/model/User.dart';
import 'dart:async';
import 'package:github_flutter/common/utils/code_utils.dart';
import 'package:flutter/foundation.dart';

/**
 * 用户表
 */

class UserInfoDBProvider extends BaseDBProvider {
  final String name = 'UserInfo';
  final String columnId = "_id";
  final String columnUserName = "userName";
  final String columnData = "data";

  int id;
  String userName;
  String data;

  UserInfoDBProvider();

  Map<String, dynamic> toMap(String userName, String data) {
    Map<String, dynamic> map = {columnUserName: userName, columnData: data};

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }

  UserInfoDBProvider.fromMap(Map map) {
    id = map[columnId];
    userName = map[columnUserName];
    data = map[columnData];
  }

  @override
  tableName() {
    return name;
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''$columnUserName text not null, $columnData text not null''';
  }

  Future _getUserProvider(Database db, String userName) async {
    List<Map<String, dynamic>> maps = await db.query(name,
        columns: [columnId, columnUserName, columnData],
        where: "$columnUserName = ?",
        whereArgs: [userName]);

    if (maps.length > 0) {
      UserInfoDBProvider provider = UserInfoDBProvider.fromMap(maps.first);
      return provider;
    }

    return null;
  }

  // 数据插入
  Future insert(String userName, String eventMapString) async {
    Database db = await getDatabase();
    var provider = await _getUserProvider(db, userName);

    if (provider != null) {
      await db
          .delete(name, where: "$columnUserName = ?", whereArgs: [userName]);
    }

    return await db.insert(name, toMap(userName, eventMapString));
  }

  // 获取事件数据
  Future<User> getUserInfo(String userName) async {
    Database db = await getDatabase();
    var provider = await _getUserProvider(db, userName);

    if (provider != null) {
      var mapData =
          await compute(CodeUtils.decodeMapResult, provider.data as String);
      return User.fromJson(mapData);
    }

    return null;
  }
}
