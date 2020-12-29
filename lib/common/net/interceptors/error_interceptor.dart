import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:github_flutter/common/net/result_data.dart';
import 'package:github_flutter/common/net/code.dart';

/**
 * 错误拦截器
 */

class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      // 没有网络
      return _dio.resolve(ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "", false),
          false,
          Code.NETWORK_ERROR));
    }

    return options;
  }
}
