import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_flutter/common/net/result_data.dart';

/**
 * http 请求
 */

class HttpManager {
  // 创建请求对象
  final Dio _dio = Dio();

  // 添加拦截器
  HttpManager() {}

  // 网络请求 并对请求出错做处理
  Future<ResultData> netFetch(
      url, params, Map<String, dynamic> header, Options option,
      {noTip = false}) {}

  // 清除授权
  clearAuthorization() {}

  // 添加授权
  getAuthorization() {}
}

final HttpManager httpManager = HttpManager();
