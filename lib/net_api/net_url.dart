
abstract class NetUrlKey {
  /// url名称
  static const String urlName = "urlName";

  /// 基础链接key
  static const String baseUrl = "baseUrl";

  /// 主页链接key
  static const String homeUrl = "homeUrl";

  /// 资源列表连接key
  static const String resourceListUrl = "resourceListUrl";

  /// 资源详情key
  static const String resourceDetailUrl = "resourceDetailUrl";

  /// 资源目录分类key-value
  static const String resourceCategoryTypeModelKeyMap =
      "resourceCategoryTypeModelKeyMap";

  /// 查询条件分类key-value
  static const String conditionModelKeyMap = "conditionModelKeyMap";

  /// 资源信息key-value
  static const String resourceModelKeyMap = "resourceModelKeyMap";

  /// 资源详情key-value
  static const String resourceDetailModelKeyMap = "resourceDetailModelKeyMap";

  static const String resourceListKey = "resourceListKey";
  static const String resourceCategoryTypeKey = "resourceCategoryTypeKey";
}

class NetUrlConfig {
  final List<dynamic> apiFilePathList;

  NetUrlConfig(this.apiFilePathList) {
    for (dynamic apiUrl in apiFilePathList) {
      String baseUrlStr = apiUrl[NetUrlKey.baseUrl] ?? "";
      Map<String, dynamic> homeUrlJson = apiUrl[NetUrlKey.homeUrl];
      print(homeUrlJson);
      UrlRequestData homeUrl = UrlRequestData.formJson(homeUrlJson);
      dynamic resourceListUrlJson = apiUrl[NetUrlKey.resourceListUrl];
      UrlRequestData resourceListUrl =
          UrlRequestData.formJson(resourceListUrlJson);
      dynamic resourceDetailUrlJson = apiUrl[NetUrlKey.resourceDetailUrl];
      UrlRequestData resourceDetailUrl =
          UrlRequestData.formJson(resourceDetailUrlJson);

      apiUrlMap[apiUrl[NetUrlKey.urlName]] = NetUrl(
        baseUrl: baseUrlStr,
        homeUrl: homeUrl,
        resourceListUrl: resourceListUrl,
        resourceDetailUrl: resourceDetailUrl,
        resourceCategoryTypeModelKeyMap:
            apiUrl[NetUrlKey.resourceCategoryTypeModelKeyMap],
        conditionModelKeyMap: apiUrl[NetUrlKey.conditionModelKeyMap],
        resourceModelKeyMap: apiUrl[NetUrlKey.resourceModelKeyMap],
        resourceDetailModelKeyMap: apiUrl[NetUrlKey.resourceDetailModelKeyMap],
        resourceListKey: apiUrl[NetUrlKey.resourceListKey],
        resourceCategoryTypeKey: apiUrl[NetUrlKey.resourceCategoryTypeKey],
      );
    }
  }

  static Map<String, NetUrl> apiUrlMap = {};
  static NetUrl? currentUseNetUrl;

  static setCurrentUseNetUrl(String urlName) {
    currentUseNetUrl = apiUrlMap[urlName];
  }
}

class NetUrl {
  final String baseUrl;
  final UrlRequestData homeUrl;
  final UrlRequestData resourceListUrl;
  final UrlRequestData resourceDetailUrl;
  final Map<String, String> resourceCategoryTypeModelKeyMap;
  final Map<String, String> conditionModelKeyMap;
  final Map<String, String> resourceModelKeyMap;
  final Map<String, String> resourceDetailModelKeyMap;

  final String resourceListKey;
  final String resourceCategoryTypeKey;

  NetUrl(
      {required this.baseUrl,
      required this.homeUrl,
      required this.resourceListUrl,
      required this.resourceDetailUrl,
      required this.resourceCategoryTypeModelKeyMap,
      required this.conditionModelKeyMap,
      required this.resourceModelKeyMap,
      required this.resourceDetailModelKeyMap, required this.resourceListKey, required this.resourceCategoryTypeKey, });
}

class UrlRequestData {
  final String url;
  final List<String> httpMethod;
  final Map<String, dynamic>? header;
  final Map<String, String>? params;
  final Map<String, String>? keyMap;

  UrlRequestData(
      {required this.url,
      required this.httpMethod,
      this.header,
      this.params,
      this.keyMap});

  factory UrlRequestData.formJson(Map<String, dynamic> json) => UrlRequestData(
      url: json["url"],
      httpMethod: json["httpMethod"],
      header: json["header"],
      params: json["params"],
      keyMap: json["keyMap"]
  );
}
