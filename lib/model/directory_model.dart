
import 'dart:convert';
import 'dart:io';


List<DirectoryModel> directoryModelListFromJson(String str) => List<DirectoryModel>.from(json.decode(str).map((x) => DirectoryModel.fromJson(x)));

String directoryModelListToJson(List<DirectoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
/// 目录
class DirectoryModel {
    DirectoryModel({required this.path, required this.name, this.fileNumber = 0, this.directorySourceType = DirectorySourceType.localDirectory});

    final String path;
    String name;
    int fileNumber;
    DirectorySourceType directorySourceType;

    factory DirectoryModel.fromJson(Map<String, dynamic> json) => DirectoryModel(
        path: json["path"] ?? "",
        name: json["name"] ?? "",
        fileNumber: json["fileNumber"] == null || (json["fileNumber"] is String && double.tryParse(json["fileNumber"])  == null) ? 0
            : json["fileNumber"] is int ? json["fileNumber"] : int.parse(json["fileNumber"].toString())
    );

    Map<String, dynamic> toJson() => {
        "path": path,
        "name": name,
        "fileNumber": fileNumber
    };

    File get file => File(path);

    bool get isExist => file.existsSync();

    FileStat get stat => file.statSync();

    //文件创建日期
    DateTime get createTime => stat.accessed;
    //文件修改日期
    DateTime get modTime => stat.modified;

}

enum DirectorySourceType {
    localDirectory,
    playDirectory
}