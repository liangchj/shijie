
import 'package:shijie/model/directory_model.dart';
import 'package:shijie/model/file_model.dart';

abstract class MediaDataCache {
  // 是否加载了本地播放目录列表
  static bool loadedLocalVideoDirectoryList = false;
  // 本地播放目录列表
  static List<DirectoryModel> localVideoDirectoryList = [];
  // 视频文件列表
  static Map<String, List<FileModel>> videoFileListMap = {};
  // 是否加载了播放目录列表
  static bool loadedPlayDirectoryList = false;
  // 播放目录
  static List<DirectoryModel> playDirectoryList = [];
  // 播放目录文件
  static Map<String, List<FileModel>> playFileListMap = {};
}