import 'package:dio/dio.dart';

/**
 * 日志 拦截器
 */

class LogInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    print("请求url: " + options.path);
    print("请求头：" + options.headers.toString());
    print("请求参数：" + options?.data.toString());

    return options;
  }
}
