

import 'dart:convert';

List<BarrageSubtitleModel> barrageSubtitleModelListFromJson(String str) => List<BarrageSubtitleModel>.from(json.decode(str).map((x) => BarrageSubtitleModel.fromJson(x)));
String barrageSubtitleModelListToJson(List<BarrageSubtitleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// 弹幕和字幕的model
class BarrageSubtitleModel {
  BarrageSubtitleModel({
    required this.path,
    required this.name,
    required this.source,
  });
  final String path; // 本地为路径，网络等同于url地址
  String name; // 名称
  final String source; // 来源

  factory BarrageSubtitleModel.fromJson(Map<String, dynamic> json) =>
      BarrageSubtitleModel(
          path: json["path"] ?? "",
          name: json["name"] ?? "",
          source: json[""] ?? "");

  Map<String, dynamic> toJson() =>
      {"path": path, "name": name, "source": source};
}
