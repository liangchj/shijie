
import 'dart:convert';

List<ResourceModel> resourceModelListFromListByKeyMap(
    List<dynamic> list, Map<String, String> keyMap) =>
    List<ResourceModel>.from(list.map((x) => ResourceModel.formJsonByKeyMap(x, keyMap)));
/// [keyMap] key：ResourceModel的属性；value：json中key（对应ResourceModel属性）
List<ResourceModel> resourceModelListFromJsonByKeyMap(
    String jsonStr, Map<String, String> keyMap) =>
    List<ResourceModel>.from(json
        .decode(jsonStr)
        .map((x) => ResourceModel.formJsonByKeyMap(x, keyMap)));

List<ResourceModel> resourceModelListFromJson(String str) =>
    List<ResourceModel>.from(
        json.decode(str).map((x) => ResourceModel.formJson(x)));

String resourceModelListToJson(List<ResourceModel> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));
class ResourceModel {
  final int id;
  final String name;
  final String type;
  final double? score;
  final int number;

  ResourceModel({required this.id, required this.name, required this.type, this.score, required this.number});


  factory ResourceModel.formJson(Map<String, dynamic> json) => ResourceModel(id: json["id"], name: json["name"] ?? "", type: json["type"] ?? "", score: json["score"], number: json["number"] ?? "");

  /// [keyMap] key：ResourceModel的属性；value：json中key（对应ResourceModel属性）
  factory ResourceModel.formJsonByKeyMap(
      Map<String, dynamic> json, Map<String, String> keyMap) {
    if (keyMap.isEmpty) {
      return ResourceModel.formJson(json);
    }
    print(json);
    return ResourceModel(
      id: json[keyMap["id"]],
      name: json[keyMap["name"]],
      type: json[keyMap["type"]],
      score: json[keyMap["score"]] ?? 0,
      number: json[keyMap["number"]] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "score": score,
    "number": number
  };
}