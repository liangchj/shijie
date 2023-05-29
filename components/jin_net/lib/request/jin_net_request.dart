
import 'package:logger/logger.dart';

enum HttpMethod { GET, POST, DELETE }
/// 基础请求
abstract class JinNetRequest {
  /// 链接上需要拼接的参数
  String? pathParams;
  bool useHttps = false;

  String authority() {
    return "www.kuaibozy.com";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    //http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    Logger().d('url:${uri.toString()}');
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = {};

  ///添加参数
  JinNetRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {};

  ///添加header
  JinNetRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}