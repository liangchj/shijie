
import 'package:get/get.dart';
import 'package:shijie/cache/mmkv_cache.dart';
import 'package:shijie/constant/cache_constant.dart';
import 'package:shijie/cache/media_data_constant.dart';
import 'package:shijie/model/directory_model.dart';
import 'package:shijie/model/file_model.dart';
import 'package:shijie/utils/file_directory_utils.dart';


/// 视频文件Controller
class VideoFileController extends GetxController {
  var loading = true.obs;
  var videoFileList = <FileModel>[].obs;
  /*@override
  void onInit() {
    super.onInit();
  }*/

  Future<void> getVideoFileList(String path, DirectorySourceType directorySourceType) async {
    try {
      loading(true);
      videoFileList.clear();
      if (directorySourceType == DirectorySourceType.playDirectory) {
        videoFileList.clear();
        if (MediaDataCache.playFileListMap.containsKey(CacheConstant.cachePrev + path)) {
          videoFileList.addAll(MediaDataCache.playFileListMap[CacheConstant.cachePrev + path] ?? []);
        } else {
          /// 从存储中获取播放文件列表（path相当于key）
          String? playFileListJson = PlayListMMKVCache.getInstance().getString(CacheConstant.cachePrev + path);
          if (playFileListJson != null && playFileListJson.isNotEmpty) {
            /// 转换为list
            videoFileList.assignAll(fileModelListFromJson(playFileListJson));
            videoFileList.sort((FileModel a, FileModel b) {
              return a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase());
            });
          }
          MediaDataCache.playFileListMap[CacheConstant.cachePrev + path] = videoFileList;
        }
        for (var element in videoFileList) {
          element.fileSourceType = FileSourceType.playListFile;
          // element.directory = CacheConstant.cachePrev + path;
          element.barragePath = DanmakuMMKVCache.getInstance().getString(CacheConstant.cachePrev + element.path);
        }
      } else {
        var fileList = await FileDirectoryUtils.getFileListByPath(path: path, fileFormat: FileFormat.video);
        if (fileList.isNotEmpty) {
          for (var element in fileList) {
            element.barragePath = DanmakuMMKVCache.getInstance().getString(CacheConstant.cachePrev + element.path);
          }
          videoFileList.assignAll(fileList);
        }
      }
    } finally {
      loading(false);
    }
  }
  /// 排序
  void reorder() {
    videoFileList.sort((FileModel a, FileModel b) {
      return a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase());
    });
    videoFileList.refresh();
  }

  /// 从播放列表中移除视频
  bool removeVideoFromPlayDirectory(FileModel fileModel) {
    bool remove = videoFileList.remove(fileModel);
    if (remove) {
      MediaDataCache.playFileListMap[fileModel.directory] = videoFileList;
      PlayListMMKVCache.getInstance().setString(fileModel.directory, fileModelListToJson(videoFileList));
    }
    return remove;
  }
}