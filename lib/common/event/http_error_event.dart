/**
 * http请求错误类
 */

class HttpErrorEvent {
  final int code;
  final String message;

  HttpErrorEvent(this.code, this.message);
}
