import 'package:dio/dio.dart';
import 'package:lchj_net/core/net_adapter.dart';
import 'package:lchj_net/core/net_error.dart';
import 'package:lchj_net/request/net_request.dart';

///Dio适配器
class DioAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(NetRequest request) async {
    var response, options = Options(headers: request.header);
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      response = e.response;
      /// 抛出NetError
      throw NetError(response?.statusCode ?? -1, e.toString(),
          data: await buildRes(e.response, request));
    }

    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<NetResponse<T>> buildRes<T>(
      Response? response, NetRequest request) {
    return Future.value(NetResponse(
      //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }
}
