import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:github_flutter/db/sql_mannager.dart';
import 'package:sqflite/sqflite.dart';

/**
 * 数据库表
 */

abstract class BaseDBProvider {
  bool isTableExits = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''create table $name ($columnId integer primary key autoincrement)''';
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await SqlManager.isTableExits(name);

    if (!isTableExits) {
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }

    return await SqlManager.getCurrentDatabase();
  }

  Future<Database> getDatabase() async {
    return await open();
  }
}
