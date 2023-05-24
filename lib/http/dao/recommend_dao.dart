

import 'package:lchj_net/lchj_net.dart';
import 'package:shijie/http/request/recommend_resource_request.dart';

class RecommendDao {
  static get() async {
    RecommendResourceRequest request = RecommendResourceRequest();
    var result = await LchjNet.getInstance().fire(request);
    print(result);
  }

  static loadSource() {
    RecommendResourceRequest request = RecommendResourceRequest();
    return LchjNet.getInstance().fire(request);
  }
}