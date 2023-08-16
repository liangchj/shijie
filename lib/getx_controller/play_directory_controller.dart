
import 'package:get/get.dart';
import 'package:shijie/cache/mmkv_cache.dart';
import 'package:shijie/constant/cache_constant.dart';
import 'package:shijie/cache/media_data_constant.dart';
import 'package:shijie/model/directory_model.dart';
import 'package:shijie/model/file_model.dart';


/// 播放目录列表Controller
class PlayDirectoryListController extends GetxController {
  var loading = true.obs;
  var videoDirectoryList = <DirectoryModel>[].obs;
  var createNewPlayDirectoryName = ''.obs;
  var createNewPlayDirectoryErrorText = ''.obs;

  @override
  void onInit() {
    print("PlayDirectoryListController init");
    getVideoPlayDirectoryList();
    // PlayerConfig.getPlayerSettingFromCache();
    // DanmakuConfig.getDanmakuSettingFromCache();
    super.onInit();
  }


  /// 获取播放目录列表
  void getVideoPlayDirectoryList() async {
    try {
      loading(true);
      if (MediaDataCache.loadedPlayDirectoryList) {
        videoDirectoryList.clear();
        videoDirectoryList.addAll(MediaDataCache.playDirectoryList);
      } else {
        /// 从存储中获取播放目录列表
        String? playDirectoryListJson = PlayListMMKVCache.getInstance().getString(CacheConstant.playDirectoryList);
        if (playDirectoryListJson != null && playDirectoryListJson.isNotEmpty) {
          /// 转换为list
          videoDirectoryList.assignAll(directoryModelListFromJson(playDirectoryListJson));
          videoDirectoryList.sort((DirectoryModel a, DirectoryModel b) {
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });
        }
      }
    } finally {
      loading(false);
    }
  }

  /// 新增播放目录
  String? addVideoPlayDirectory(DirectoryModel playDirectoryModel) {
    String? msg;
    for (var item in videoDirectoryList) {
      if (item.name == playDirectoryModel.name) {
        msg = "播放目录已存在";
        createNewPlayDirectoryErrorText.value = msg;
        break;
      }
    }
    if (msg == null || msg.isEmpty) {
      /// 添加到列表
      videoDirectoryList.add(playDirectoryModel);
      /// 重新排序
      reorder();
      /// 刷新
      // videoDirectoryList.refresh();
      saveVideoPlayDirectoryToStorage();
    }
    return msg;
  }
  /// 删除播放目录
  void removeVideoPlayDirectory(DirectoryModel playDirectoryModel) {
    bool isChange = false;
    for (var item in videoDirectoryList) {
      if (item.name == playDirectoryModel.name) {
        videoDirectoryList.remove(item);
        isChange = true;
        break;
      }
    }
    if (isChange) {
      saveVideoPlayDirectoryToStorage();
    }
  }
  /// 移除视频
  void removeVideoFromPlayDirectory(String directory) {
    print("directory:$directory");
    for(DirectoryModel directoryModel in videoDirectoryList) {
      print("directoryModel.name: ${directoryModel.name}");
      if (CacheConstant.cachePrev + directoryModel.name == directory) {
        directoryModel.fileNumber -= 1;
        break;
      }
    }
    videoDirectoryList.refresh();
    MediaDataCache.playDirectoryList = videoDirectoryList;
    saveVideoPlayDirectoryToStorage();
  }
  /// 排序
  void reorder() {
    /// 重新排序
    videoDirectoryList.sort((DirectoryModel a, DirectoryModel b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    videoDirectoryList.refresh();
  }

  /// 转换为字符串存入内存
  void saveVideoPlayDirectoryToStorage() {
    /// 转换为字符串存入内存
    PlayListMMKVCache.getInstance().setString(CacheConstant.playDirectoryList, directoryModelListToJson(videoDirectoryList));
  }

  /// 添加视频到播放目录
  String addVideoToPlayDirectory(DirectoryModel playDirectoryModel, FileModel fileModel) {
    String msg = "";
    String dirName = playDirectoryModel.name;
    List<FileModel> videoFileList = [];
    if (MediaDataCache.playFileListMap.containsKey(CacheConstant.cachePrev + dirName)) {
      videoFileList = MediaDataCache.playFileListMap[CacheConstant.cachePrev + dirName] ?? [];
    } else {
      // 从存储中获取播放文件列表（path相当于key）
      String? playFileListJson = PlayListMMKVCache.getInstance().getString(CacheConstant.cachePrev + dirName);
      if (playFileListJson != null && playFileListJson.isNotEmpty) {
        /// 转换为list
        videoFileList.assignAll(fileModelListFromJson(playFileListJson));
      }
    }
    if (videoFileList.isNotEmpty) {
      bool exists = false;
      for (FileModel element in videoFileList) {
        if (element.name == fileModel.name) {
          exists = true;
          break;
        }
      }
      if (exists) {
        msg = "视频已经存在于“$dirName”列表中";
      } else {
        msg = handleAddAndSaveToPlayDirectory(playDirectoryModel, dirName, videoFileList, fileModel);
      }
    } else {
      msg = handleAddAndSaveToPlayDirectory(playDirectoryModel, dirName, videoFileList, fileModel);
    }
    return msg;
  }
  /// 执行添加到播放列表和存入存储中
  String handleAddAndSaveToPlayDirectory(DirectoryModel playDirectoryModel, String dirName, List<FileModel> videoFileList, FileModel fileModel) {
    String msg = "";
    videoFileList.add(fileModel);
    videoFileList.sort((FileModel a, FileModel b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    playDirectoryModel.fileNumber = videoFileList.length;
    MediaDataCache.playFileListMap[CacheConstant.cachePrev + dirName] = videoFileList;
    msg = "视频已添加到“$dirName”列表";
    PlayListMMKVCache.getInstance().setString(CacheConstant.cachePrev + dirName, fileModelListToJson(videoFileList));
    saveVideoPlayDirectoryToStorage();
    return msg;
  }


}