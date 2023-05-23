
import 'dart:convert';
import 'dart:ffi';

List<ConditionModel> conditionModelListFromJson(String str) => List<ConditionModel>.from(json.decode(str).map((x) => ConditionModel.formJson(x)));
String conditionModelListToJson(List<ConditionModel> data) => json.encode(List<dynamic>.from(data.map((e) => e.toJson())));
class ConditionModel {
  final List<String> titleList;
  final List<int> activeIndexList;
  ConditionModel({required this.titleList, required this.activeIndexList});

  factory ConditionModel.formJson(Map<String, dynamic> json) => ConditionModel(titleList: json["titleList"] ?? [], activeIndexList: json["activeIndexList"] ?? []);

  Map<String, dynamic> toJson() => {
    "titleList": titleList,
    "activeIndexList": activeIndexList
  };
}