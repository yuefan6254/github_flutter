/**
 * http请求返回体格式
 */

class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code, {this.headers});
}
