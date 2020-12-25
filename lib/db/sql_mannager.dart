import 'package:sqflite/sqflite.dart';

/**
 * 数据库管理
 */

class SqlManager {
  // 基础数据
  static const _NAME = "gsy_github_app_flutter.db";
  static Database _database;

  // 初始化

  // 判断表是否存在

  // 获取当前数据库对象

  // 关闭数据库
  static close() {
    _database.close();
    _database = null;
  }
}
