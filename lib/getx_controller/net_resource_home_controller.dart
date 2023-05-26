

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lchj_net/lchj_net.dart';
import 'package:shijie/http/request/net_resource_home_request.dart';
import 'package:shijie/model/resource_category_type_model.dart';
import 'package:shijie/model/resource_model.dart';
import 'package:shijie/net_api/net_url.dart';

class NetResourceHomeController extends GetxController with GetSingleTickerProviderStateMixin {
  var loading = true.obs;
  /// 资源目录
  var resourceCategoryType = <ResourceCategoryTypeModel>[].obs;
  /// 资源分类目录列表
  var resourceCategoryMap = <String, List<ResourceModel>>{}.obs;
  var resourceCategoryList = <List<ResourceModel>>[].obs;
  bool initNetUrl = true;
  UrlRequestData? homeUrl;
  NetResourceHomeRequest? request;
  Map<String, String> homeUrlKeyMap = {"list": "list", "categoryType": "categoryType"};

  late TabController tabController;

  var apiUrlData = {
    "urlName": "资源",
    "baseUrl": "www.kuaibozy.com",
    "homeUrl": {
      "url": "/api.php/provide/vod/from/kbm3u8/at/json",
      "httpMethod": ["get"],
    },
    "resourceListUrl": {
      "url": "/api.php/provide/vod/from/kbm3u8/at/json",
      "httpMethod": ["get"],
    },
    "resourceDetailUrl": {
      "url": "/api.php/provide/vod/from/kbm3u8/at/json",
      "httpMethod": ["get"],
    },
    "resourceCategoryTypeModelKeyMap": {
      "id": "type_id",
      "name": "type_name"
    },
    "conditionModelKeyMap": {
      "titleList": "titleList",
      "activeIndexList": "activeIndexList"
    },
    "resourceModelKeyMap": {
      "id": "vod_id",
      "name": "vod_name",
      "type": "type_name",
      "score": "score",
      "number": "number",
    },
    "resourceDetailModelKeyMap": {
      "id": "id",
      "name": "name",
    },
    "resourceListKey": "list",
    "resourceCategoryTypeKey": "class",
  };

  List tabs = ["新闻", "历史", "图片"];
  @override
  void onInit() {
    print("oninit 初始化");
    NetUrlConfig([apiUrlData]);
    print(NetUrlConfig.apiUrlMap);
    NetUrlConfig.setCurrentUseNetUrl("资源");
    print(NetUrlConfig.currentUseNetUrl);
    print(NetUrlConfig.currentUseNetUrl!.homeUrl.url);
    homeUrl = NetUrlConfig.currentUseNetUrl?.homeUrl;
    if (homeUrl == null) {
      initNetUrl = false;
    } else {
      request = NetResourceHomeRequest(homeUrl!);
    }
    print("resourceCategoryTypeKey: ${NetUrlConfig.currentUseNetUrl?.resourceCategoryTypeKey}");
    print("resourceCategoryTypeModelKeyMap: ${NetUrlConfig.currentUseNetUrl?.resourceCategoryTypeModelKeyMap}");
    print("resourceListKey: ${NetUrlConfig.currentUseNetUrl?.resourceListKey}");
    print("resourceModelKeyMap: ${NetUrlConfig.currentUseNetUrl?.resourceModelKeyMap}");
    loadNetResource();
    tabController = TabController(vsync: this, length: tabs.length);
    super.onInit();
  }

  /// 加载网络资源
  loadNetResource() async {
    try {
      loading(true);
    var result = await LchjNet.getInstance().fire(request!);
    print("======结果START======");
    List<dynamic> categoryTypeListJson = result[NetUrlConfig.currentUseNetUrl?.resourceCategoryTypeKey];
    if (categoryTypeListJson.isNotEmpty) {
      resourceCategoryType.addAll(resourceCategoryTypeModelListFromListByKeyMap(categoryTypeListJson, NetUrlConfig.currentUseNetUrl!.resourceCategoryTypeModelKeyMap));
      // resourceCategoryType.addAll(resourceCategoryTypeModelListFromJsonByKeyMap(jsonEncode(categoryTypeListJson), NetUrlConfig.currentUseNetUrl!.resourceCategoryTypeModelKeyMap));
    }
    print("资源目录类型列表");
    print(resourceCategoryType);

    List<dynamic> resourceListJson = result[NetUrlConfig.currentUseNetUrl?.resourceListKey];
    if (resourceListJson.isNotEmpty) {
      List<ResourceModel> resourceList = resourceModelListFromListByKeyMap(resourceListJson, NetUrlConfig.currentUseNetUrl!.resourceModelKeyMap);
      print("资源列表");
      print(resourceList);
      for (ResourceModel resourceModel in resourceList) {
        String resourceTypeName = resourceModel.type;
        List<ResourceModel> list = resourceCategoryMap[resourceTypeName] ?? [];
        list.add(resourceModel);
        resourceCategoryMap[resourceTypeName] = list;
      }
      resourceCategoryMap.forEach((key, value) {
        resourceCategoryList.add(value);
      });
    }
    print("资源分类列表");
    print(resourceCategoryMap);
    print("======结果END======");
    // List<dynamic> resourceCategoryJson = result[homeUrlKeyMap["list"]];
    } catch (e) {
      print("加载资源失败：$e");
    } finally {
      loading(false);
    }
  }
}