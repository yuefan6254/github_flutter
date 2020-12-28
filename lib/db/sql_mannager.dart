import 'package:github_flutter/common/dao/user_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:github_flutter/model/User.dart';
import 'dart:io';

/**
 * 数据库管理
 */

class SqlManager {
  // 基础数据
  static const _NAME = "gsy_github_app_flutter.db";
  static Database _database;
  static const _VERSION = 1;

  // 初始化
  static init() async {
    var databasePath = await getDatabasesPath();
    var userRes = await UserDao.getUserInfoLocal();
    String dbName = _NAME;

    if (userRes != null && userRes.result) {
      User user = userRes.data;

      if (user != null && user.login != null) {
        dbName = "${user.login}_$_NAME";
      }
    }

    String path = databasePath + dbName;

    if (Platform.isIOS) {
      path = databasePath + "/" + dbName;
    }

    _database = await openDatabase(path, version: _VERSION);
  }

  // 判断表是否存在
  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  // 获取当前数据库对象
  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }

    return _database;
  }

  // 关闭数据库
  static close() {
    _database.close();
    _database = null;
  }
}
