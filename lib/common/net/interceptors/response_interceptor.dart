import 'package:dio/dio.dart';
import 'package:github_flutter/common/net/result_data.dart';
import 'package:github_flutter/common/net/code.dart';

/**
 * response 拦截器
 */

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];

      if ((header != null && header.toString().contains("text"))) {
        value = ResultData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      value = ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }

    print(value);

    return value;
  }
}
