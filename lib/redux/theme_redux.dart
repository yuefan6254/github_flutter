import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

/**
 * 主题redux
 */

final ThemeDataReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, RefreshThemeDataAction>(_refresh),
]);

ThemeData _refresh(ThemeData themeData, action) {
  print("***********RefreshThemeDataAction**********");
  themeData = action.themeData;
  return themeData;
}

class RefreshThemeDataAction {
  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}
