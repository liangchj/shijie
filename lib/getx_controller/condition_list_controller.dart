import 'package:get/get.dart';
import 'package:shijie/model/condition_model.dart';

class ConditionListController extends GetxController {
  var conditionList = <ConditionModel>[].obs;

  @override
  void onInit() {
    conditionList.add(ConditionModel(titleList: ConditionDataList.typeList, activeIndexList: ConditionDataList.typeList.isNotEmpty ? [0] : []));
    conditionList.add(ConditionModel(titleList: ConditionDataList.countryList, activeIndexList: ConditionDataList.countryList.isNotEmpty ? [0] : []));
    conditionList.add(ConditionModel(titleList: ConditionDataList.yearList, activeIndexList: ConditionDataList.yearList.isNotEmpty ? [0] : []));
    conditionList.add(ConditionModel(titleList: ConditionDataList.orderList, activeIndexList: ConditionDataList.orderList.isNotEmpty ? [0] : []));
    super.onInit();
  }

}


class ConditionDataList {
  static List<String> typeList = ["全部", "剧情", "恐怖", "动作", "爱情", "战争", "历史"];
  static List<String> countryList = ["全部", "大陆", "美国", "英国", "日本", "韩国", "其他"];
  static List<String> yearList = ["全部", "2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "更早"];
  static List<String> orderList = ["最热", "最新", "评分"];
}