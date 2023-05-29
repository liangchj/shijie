
/// 网络异常统一格式类
class JinNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  JinNetError(this.code, this.message, {this.data});
}

///需要登录的异常
class NeedLogin extends JinNetError {
  NeedLogin({code = 401, message = '请先登录'}) : super(code, message);
}

///需要授权的异常
class NeedAuth extends JinNetError {
  NeedAuth(message, {code = 403, data})
      : super(code, message, data: data);
}