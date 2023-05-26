
import 'package:lchj_net/request/net_request.dart';
import 'package:shijie/net_api/net_url.dart';

class NetResourceHomeRequest extends NetRequest {
  final UrlRequestData urlRequestData;

  NetResourceHomeRequest(this.urlRequestData) {
    /*switch(urlRequestData.httpMethod) {
      case "get": method = HttpMethod.GET; break;
      case "post": method = HttpMethod.POST; break;
      case "delete": method = HttpMethod.DELETE; break;
    }*/
    urlPath = urlRequestData.url;
  }

  late HttpMethod method;
  late String urlPath;

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
    return urlPath;
  }

}