import 'package:github_flutter/common/event/http_error_event.dart';
import 'package:github_flutter/common/event/event_bus.dart';

/**
 * 错误编码
 */

class Code {
  // 网络错误
  static const NETWORK_ERROR = -1;

  // 网络超时
  static const NETWORK_TIMEOUT = -2;

  // 网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  // github 接口拒绝访问
  static const GITHUB_API_REFUSED = -4;

  static const SUCCESS = 200;

  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }

    if (message != null &&
        message is String &&
        (message.contains("Connection refused") ||
            message.contains("Connection reset"))) {
      code = GITHUB_API_REFUSED;
    }

    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}
