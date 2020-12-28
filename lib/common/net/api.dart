import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:github_flutter/common/net/interceptors/token_interceptor.dart';
import 'package:github_flutter/common/net/result_data.dart';
import 'package:github_flutter/common/net/code.dart';

/**
 * http 请求
 */

class HttpManager {
  // 创建请求对象
  final Dio _dio = Dio();
  final TokenInterceptor _tokenInterceptor = TokenInterceptor();

  // 添加拦截器
  HttpManager() {
    _dio.interceptors.add(_tokenInterceptor);
  }

  // 网络请求 并对请求出错做处理
  Future<ResultData> netFetch(
      url, params, Map<String, dynamic> header, Options option,
      {noTip = false}) async {
    print("进入请求方法中");
    Map<String, dynamic> headers = HashMap();
    // 添加头部
    if (header != null) {
      headers.addAll(header);
    }

    // 添加设置
    if (option == null) {
      option = Options(method: 'get');
    }
    option.headers = headers;

    //错误处理
    resultError(DioError e) {
      Response errorResponse;

      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(statusCode: 666);
      }

      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }

      return ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    // 请求
    Response response;

    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      print("请求报错");
      print(e.toString());
      return resultError(e);
    }

    print("请求返回 $response");

    if (response.data is DioError) {
      return resultError(response.data);
    }

    return response.data;
  }

  // 清除授权
  clearAuthorization() {
    _tokenInterceptor.clearAuthorization();
  }

  // 添加授权
  getAuthorization() {
    return _tokenInterceptor.getAuthorization();
  }
}

final HttpManager httpManager = HttpManager();
