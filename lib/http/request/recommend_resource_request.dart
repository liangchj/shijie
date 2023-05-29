


import 'package:jin_net/request/jin_net_request.dart';

class RecommendResourceRequest extends JinNetRequest {
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
    return "/api.php/provide/vod/from/kbm3u8/at/json";
  }

}