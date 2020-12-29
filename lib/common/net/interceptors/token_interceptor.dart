import 'package:dio/dio.dart';
import 'package:github_flutter/common/local/local_storage.dart';
import 'package:github_flutter/common/config/config.dart';
import 'package:github_flutter/common/net/graphql/clinet.dart';

/**
 * token 拦截器
 */

class TokenInterceptor extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    // 请求头添加token
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
        initClient(authorizationCode);
      }

      options.headers['Authorization'] = _token;
      return options;
    }
  }

  @override
  onResponse(Response response) async {
    // 更新token
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        // _token = "token ${responseJson['token']}";
        _token = 'token ' + responseJson['token'];
        await LocalStorage.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }

    return response;
  }

  // 消除授权
  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
    releaseClient();
  }

  // 获取授权
  getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);

    if (token == null) {
      final String basic = await LocalStorage.get(Config.USER_BASIC_CODE);

      if (basic == null) {
      } else {
        return "Basic $basic";
      }
    } else {
      this._token = token;
      return token;
    }
  }
}
