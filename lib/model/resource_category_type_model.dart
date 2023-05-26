

import 'dart:convert';

List<ResourceCategoryTypeModel> resourceCategoryTypeModelListFromListByKeyMap(
    List<dynamic> list, Map<String, String> keyMap) =>
    List<ResourceCategoryTypeModel>.from(list.map((x) => ResourceCategoryTypeModel.formJsonByKeyMap(x, keyMap)));
/// [keyMap] key：ResourceCategoryTypeModel的属性；value：json中key（对应ResourceCategoryTypeModel属性）
List<ResourceCategoryTypeModel> resourceCategoryTypeModelListFromJsonByKeyMap(
    String jsonStr, Map<String, String> keyMap) =>
    List<ResourceCategoryTypeModel>.from(json
        .decode(jsonStr)
        .map((x) => ResourceCategoryTypeModel.formJsonByKeyMap(x, keyMap)));

List<ResourceCategoryTypeModel> resourceCategoryTypeModelListFromJson(String str) =>
    List<ResourceCategoryTypeModel>.from(
        json.decode(str).map((x) => ResourceCategoryTypeModel.formJson(x)));

String resourceCategoryTypeModelListToJson(List<ResourceCategoryTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class ResourceCategoryTypeModel {
  final int? id;
  final String name;
  final String? code;
  final String? desc;

  ResourceCategoryTypeModel({this.id, required this.name, this.code, this.desc});

  factory ResourceCategoryTypeModel.formJson(Map<String, dynamic> json) => ResourceCategoryTypeModel(
      id: json["id"],
      name: json["name"],
    code: json["code"],
    desc: json["desc"],
  );

  /// [keyMap] key：ResourceCategoryTypeModel的属性；value：json中key（对应ResourceCategoryTypeModel属性）
  factory ResourceCategoryTypeModel.formJsonByKeyMap(
      Map<String, dynamic> json, Map<String, String> keyMap) {
    if (keyMap.isEmpty) {
      return ResourceCategoryTypeModel.formJson(json);
    }
    return ResourceCategoryTypeModel(
        id: json[keyMap["id"]],
        name: json[keyMap["name"]],
      code: json[keyMap["code"]],
      desc: json[keyMap["desc"]],
    );
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "code": code, "desc": desc};
}