library lchj_net;

import 'dart:convert';

import 'package:lchj_net/core/dio_adapter.dart';
import 'package:lchj_net/core/error_interceptor.dart';
import 'package:lchj_net/core/net_adapter.dart';
import 'package:lchj_net/core/net_error.dart';
import 'package:lchj_net/request/net_request.dart';
import 'package:logger/logger.dart';

/// 1.支持网络库插拔设计，且不干扰业务层
/// 2.基于配置请求请求，简洁易用
/// 3.Adapter设计，扩展性强
/// 4.统一异常和返回处理
class LchjNet {
  LchjNet._();
  Logger logger = Logger();

  ErrorInterceptor? _errorInterceptor;
  static LchjNet? _instance;

  static LchjNet getInstance() {
    _instance ??= LchjNet._();
    return _instance!;
  }

  Future fire(NetRequest request) async {
    NetResponse? response;
    var error;
    try {
      response = await send(request);
    } on NetError catch (e) {
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
            error ?? NetError(status ?? -1, result.toString(), data: result);
        break;
    }
    //交给拦截器处理错误
    if (_errorInterceptor != null) {
      _errorInterceptor!(hiError);
    }
    throw hiError;
  }

  Future<NetResponse<T>> send<T>(NetRequest request) async {
    ///使用Dio发送请求
    NetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void setErrorInterceptor(ErrorInterceptor interceptor) {
    _errorInterceptor = interceptor;
  }


}
