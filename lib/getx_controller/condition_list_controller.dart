import 'dart:convert';

import 'package:get/get.dart';
import 'package:shijie/http/dao/recommend_dao.dart';
import 'package:shijie/model/condition_model.dart';
import 'package:shijie/model/resource_model.dart';

class ConditionListController extends GetxController {
  var conditionList = <ConditionModel>[].obs;
  var resourceModelList = <ResourceModel>[].obs;
  var loading = true.obs;

  @override
  void onInit() {
    /*conditionList.add(ConditionModel(titleList: ConditionDataList.typeList, activeIndexList: ConditionDataList.typeList.isNotEmpty ? [0] : []));
    conditionList.add(ConditionModel(titleList: ConditionDataList.countryList, activeIndexList: ConditionDataList.countryList.isNotEmpty ? [0] : []));
    conditionList.add(ConditionModel(titleList: ConditionDataList.yearList, activeIndexList: ConditionDataList.yearList.isNotEmpty ? [0] : []));
    conditionList.add(ConditionModel(titleList: ConditionDataList.orderList, activeIndexList: ConditionDataList.orderList.isNotEmpty ? [0] : []));*/
    super.onInit();
    loadSource();
  }

  loadSource() async {
    loading(true);
    try {

      var result = await RecommendDao.loadSource();
      // String code = (result["code"] ?? "").toString();
      List<dynamic> listJson = result["list"];
      List<dynamic> typeListJson = result["class"];

      if (listJson.isNotEmpty) {
        for (dynamic map in listJson) {
          resourceModelList.add(ResourceModel(name: map["vod_name"] ?? "", type: map["type_name"] ?? "", score:  0, number:  0));
          print(resourceModelList);
        }
      }

      if (typeListJson.isNotEmpty) {
        List<String> typeList = [];
        for (dynamic map in typeListJson) {
          typeList.add(map["type_name"]);
        }
        conditionList.add(ConditionModel(titleList: typeList, activeIndexList: typeList.isNotEmpty ? [0] : []));
        print(conditionList);
      }
    } catch (e) {
      print("报错：$e");
    } finally {
      loading(false);
    }
  }

}


class ConditionDataList {
  static List<String> typeList = ["全部", "剧情", "恐怖", "动作", "爱情", "战争", "历史"];
  static List<String> countryList = ["全部", "大陆", "美国", "英国", "日本", "韩国", "其他"];
  static List<String> yearList = ["全部", "2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "更早"];
  static List<String> orderList = ["最热", "最新", "评分"];
}