


import 'package:jin_net/request/jin_net_request.dart';
import 'package:shijie/http/request/base_request.dart';

class TestRequest extends JinNetRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return 'uapi/test/test';
  }

}