import 'package:flutter/material.dart';

/**
 * 通用逻辑
 */

class CommonUtils {
  static getThemeDtata(Color color) {
    return ThemeData(primaryColor: color, platform: TargetPlatform.android);
  }
}
