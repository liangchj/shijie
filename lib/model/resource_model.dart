

class ResourceModel {
  final String name;
  final String type;
  final double? score;
  final int number;

  ResourceModel({required this.name, required this.type, this.score, required this.number});


  factory ResourceModel.formJson(Map<String, dynamic> json) => ResourceModel(name: json["name"] ?? "", type: json["type"] ?? "", score: json["score"], number: json["number"] ?? "");

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "score": score,
    "number": number
  };
}