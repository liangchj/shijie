
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/cache/mmkv_cache.dart';
import 'package:shijie/constant/cache_constant.dart';
import 'package:shijie/cache/media_data_constant.dart';
import 'package:shijie/getx_controller/video_file_controller.dart';
import 'package:shijie/model/barrage_subtitle_model.dart';
import 'package:shijie/model/file_model.dart';


class SearchBarrageSubtitleController extends GetxController {

  var loading = true.obs;
  var searching = true.obs;
  var barrageList = <BarrageSubtitleModel>[].obs;
  var subtitleList = <BarrageSubtitleModel>[].obs;
  var videoFileModel = FileModel(path: "", fullName: "", name: "", directory: "").obs;
  var barrageMap = <String, List<BarrageSubtitleModel>>{}.obs;
  var subtitleMap = <String, List<BarrageSubtitleModel>>{}.obs;
  var clickVideoNameIndex = 0.obs; // 搜索名称下标
  var clickVideoName = ''.obs;

  var currentDirectoryList = <Widget>[].obs;

  void updateVideoFileModel(FileModel fileModel) {
    videoFileModel(FileModel(path: fileModel.path, fullName: fileModel.fullName, name: fileModel.name, directory: fileModel.directory, fileSourceType: fileModel.fileSourceType, barragePath: fileModel.barragePath, subtitlePath: fileModel.subtitlePath));
  }

  /// 获取弹幕列表
  void getBarrageList(String keyword) {
    try {
      loading(true);
      clickVideoNameIndex.value = 0;
      clickVideoName.value = '';
      barrageMap.clear();
      barrageMap["测试1"] = [BarrageSubtitleModel(path: "xxx", name: "测试11", source: "xxx"),BarrageSubtitleModel(path: "xxx", name: "测试12", source: "xxx")];
      barrageMap["测试2测试2测试2测试2测试2测试2测试2测试2测试2测试2测试2测试2测试2测试2"] = [BarrageSubtitleModel(path: "xxx", name: "测试21", source: "xxx"),BarrageSubtitleModel(path: "xxx", name: "测试22", source: "xxx")];
      barrageMap["测试3"] = [BarrageSubtitleModel(path: "xxx", name: "测试31", source: "xxx"),BarrageSubtitleModel(path: "xxx", name: "测试32", source: "xxx")];
    } finally {
      loading(false);
    }
  }

  /// 获取字幕列表
  void getSubtitleList(String keyword) {
    try {
      loading(true);
    } finally {
      loading(false);
    }
  }

  /// 点击列表中的视频名称
  void handleClickVideoName(String videoName) {
    try {
      loading(true);
      if (clickVideoName.value != videoName) {
        barrageList.clear();
      }
      if (barrageMap.containsKey(videoName)) {
        barrageList = barrageMap[videoName]!.obs;
      }
    } finally {
      loading(false);
    }
  }

  /// 点击列表中的视频名称下标
  void handleClickVideoNameIndex(int index) {
    try {
      loading(true);
      if (clickVideoNameIndex.value != index) {
        barrageList.clear();
        clickVideoNameIndex.value = index;
      }
      var videoNames = barrageMap.keys.toList();
      barrageList = barrageMap[videoNames[index]]!.obs;
    } finally {
      loading(false);
    }
  }

  /// 绑定弹幕
  void bindBarrage(String barragePath, FileModel fileModel) {
    // 修改记录弹幕文件路径
    fileModel.barragePath = barragePath;
    // 将弹幕文件路径写入存储
    DanmakuMMKVCache.getInstance().setString(CacheConstant.cachePrev + fileModel.path, barragePath);
    Get.find<VideoFileController>().videoFileList.refresh();
    MediaDataCache.playFileListMap[fileModel.directory] = Get.find<VideoFileController>().videoFileList;
    updateVideoFileModel(fileModel);
  }

  /// 移除绑定弹幕
  void unbindBarrage(FileModel fileModel) {
    // 修改记录弹幕文件路径
    fileModel.barragePath = null;
    // 将弹幕文件路径写入存储
    DanmakuMMKVCache.getInstance().removeKey(CacheConstant.cachePrev + fileModel.path);
    Get.find<VideoFileController>().videoFileList.refresh();
    MediaDataCache.playFileListMap[fileModel.directory] = Get.find<VideoFileController>().videoFileList;
    updateVideoFileModel(fileModel);
  }

}