

import 'package:jin_net/jin_net.dart';
import 'package:shijie/http/request/recommend_resource_request.dart';

class RecommendDao {
  static get() async {
    RecommendResourceRequest request = RecommendResourceRequest();
    var result = await JinNet.getInstance().fire(request);
    print(result);
  }

  static loadSource() {
    RecommendResourceRequest request = RecommendResourceRequest();
    return JinNet.getInstance().fire(request);
  }
}