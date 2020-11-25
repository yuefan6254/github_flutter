import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_flutter/GSYTabBarWidget.dart';
import 'pages/error_page.dart';
import 'package:github_flutter/app.dart';

void collectLog(String line) {
  // 收集日志
}

void reportErrorAndLog(FlutterErrorDetails details) {
  // 上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误消息
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };

  runZoned(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
      return ErrorPage(
          details.exception.toString() + "\n" + details.stack.toString(),
          details);
    };
    runApp(FlutterReduxApp());
  }, onError: (Object obj, StackTrace stack) {
    var details = makeDetails(obj, stack);
    reportErrorAndLog(details);
  });
}
