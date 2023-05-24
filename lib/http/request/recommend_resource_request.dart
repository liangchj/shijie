

import 'package:lchj_net/request/net_request.dart';

class RecommendResourceRequest extends NetRequest {
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