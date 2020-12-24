import 'package:dio/dio.dart';
import 'package:github_flutter/common/local/local_storage.dart';
import 'package:github_flutter/common/config/config.dart';

/**
 * token 拦截器
 */

class TokenInterceptor extends InterceptorsWrapper {
  String _token;

  // 消除授权
  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  // 获取授权
  getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);

    if (token == null) {
    } else {
      this._token = token;
      return token;
    }
  }
}
