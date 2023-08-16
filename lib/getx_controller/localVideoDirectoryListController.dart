
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shijie/cache/media_data_constant.dart';
import 'package:shijie/model/directory_model.dart';
import 'package:shijie/utils/media_store_utils.dart';

/// 本地视频目录列表controller
class LocalVideoDirectoryListController extends GetxController {
  var loading = true.obs;
  var localVideoDirectoryList = <DirectoryModel>[].obs;

  @override
  void onInit() {
    Logger().d("getLocalVideoDirectoryList() oninit");
    getLocalVideoDirectoryList(false);
    super.onInit();
  }

  /// 获取本地视频资源列表
  /// [flag] 是否强制刷新，true：舍弃已读取的，重新进行读取；false：获取缓存的
  void getLocalVideoDirectoryList(bool flag) async {
    try {
      loading(true);
      if (!flag && MediaDataCache.loadedLocalVideoDirectoryList) {
        localVideoDirectoryList.clear();
        localVideoDirectoryList.addAll(MediaDataCache.localVideoDirectoryList);
      } else {
        Logger().d("重新获取资源列表");
        var mediaStoreVideoDirList = await MediaStoreUtils.getMediaStoreVideoDirList();
        if (mediaStoreVideoDirList.isNotEmpty) {
          localVideoDirectoryList.assignAll(mediaStoreVideoDirList);
          localVideoDirectoryList.sort((DirectoryModel a, DirectoryModel b) {
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });
        }
        MediaDataCache.localVideoDirectoryList = localVideoDirectoryList;
        MediaDataCache.loadedLocalVideoDirectoryList = true;
      }

    } finally {
      loading(false);
    }
  }
}