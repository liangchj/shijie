import 'dart:convert';

/// [keyMap] key：ConditionModel的属性；value：jsonStr中key（对应ConditionModel属性）
List<ConditionModel> conditionModelListFromJsonByKeyMap(
        String jsonStr, Map<String, String> keyMap) =>
    List<ConditionModel>.from(json
        .decode(jsonStr)
        .map((x) => ConditionModel.formJsonByKeyMap(x, keyMap)));

List<ConditionModel> conditionModelListFromJson(String str) =>
    List<ConditionModel>.from(
        json.decode(str).map((x) => ConditionModel.formJson(x)));

String conditionModelListToJson(List<ConditionModel> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class ConditionModel {
  final List<String> titleList;
  final List<int> activeIndexList;
  ConditionModel({required this.titleList, required this.activeIndexList});

  factory ConditionModel.formJson(Map<String, dynamic> json) => ConditionModel(
      titleList: json["titleList"] ?? [],
      activeIndexList: json["activeIndexList"] ?? []);

  /// [keyMap] key：ConditionModel的属性；value：json中key（对应ConditionModel属性）
  factory ConditionModel.formJsonByKeyMap(
      Map<String, dynamic> json, Map<String, String> keyMap) {
    if (keyMap.isEmpty) {
      return ConditionModel.formJson(json);
    }
    return ConditionModel(
        titleList: json[keyMap["titleList"]] ?? [],
        activeIndexList: json[keyMap["activeIndexList"]] ?? []);
  }

  Map<String, dynamic> toJson() =>
      {"titleList": titleList, "activeIndexList": activeIndexList};
}
