library lchj_net;

import 'dart:convert';


import 'package:jin_net/core/dio_adapter.dart';
import 'package:jin_net/core/jin_error.dart';
import 'package:jin_net/core/jin_interceptor.dart';
import 'package:jin_net/core/jin_net_adapter.dart';
import 'package:jin_net/request/jin_net_request.dart';
import 'package:logger/logger.dart';

/// 1.支持网络库插拔设计，且不干扰业务层
/// 2.基于配置请求请求，简洁易用
/// 3.Adapter设计，扩展性强
/// 4.统一异常和返回处理
class JinNet {
  JinNet._();
  Logger logger = Logger();

  ErrorInterceptor? _errorInterceptor;
  static JinNet? _instance;

  static JinNet getInstance() {
    _instance ??= JinNet._();
    return _instance!;
  }

  Future fire(JinNetRequest request) async {
    JinNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on JinNetError catch (e) {
      error = e;
      response = e.data;
      logger.e(e);
    } catch (e) {
      //其它异常
      error = e;
      logger.e(e);
    }
    var data = response?.data;
    var result = jsonDecode(data);
    var status = response?.statusCode;
    var hiError;
    switch (status) {
      case 200:
        return result;
      case 401:
        hiError = NeedLogin();
        break;
      case 403:
        hiError = NeedAuth(result.toString(), data: result);
        break;
      default:
      //如果error不为空，则复用现有的error
        hiError =
            error ?? JinNetError(status ?? -1, result.toString(), data: result);
        break;
    }
    //交给拦截器处理错误
    if (_errorInterceptor != null) {
      _errorInterceptor!(hiError);
    }
    throw hiError;
  }

  Future<JinNetResponse<T>> send<T>(JinNetRequest request) async {
    ///使用Dio发送请求
    JinNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void setErrorInterceptor(ErrorInterceptor interceptor) {
    _errorInterceptor = interceptor;
  }


}