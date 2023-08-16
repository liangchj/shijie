
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/utils/file_directory_utils.dart';

class MyFileSelectorController extends GetxController {

  var loading = true.obs;
  var currentDirectoryNavLoading = true.obs;
  var fileList = <File>[].obs;
  // 当前目录导航栏列表
  var currentDirectoryNavList = <Widget>[].obs;


  /// 获取指定目录下所有的文件和目录
  Future<void> getFileAndDirByPath(String path, {FileFormat? fileFormat}) async {
    try {
      loading(true);
      fileList.clear();
      var fileAndDirList = await FileDirectoryUtils.getFileAndDirByPath(path, fileFormat: fileFormat);
      if (fileAndDirList.isNotEmpty) {
        fileList.addAll(fileAndDirList);
      }
    } finally {
      loading(false);
    }
  }
  /// 生成当前目录导航栏
  void createCurrentDirectoryNav(Directory directory, {bool firstEntry = true, FileFormat? fileFormat}) {
    if (firstEntry) {
      currentDirectoryNavList.clear();
    }
    try {
      currentDirectoryNavLoading(true);
      late String name;
      if (directory.path == "/storage/emulated/0") {
        name = "根目录";
      } else {
        name = directory.path.split('/').last;
      }
      if (currentDirectoryNavList.isEmpty) {
        currentDirectoryNavList.add(Row(children: [Text(name)],));
      } else {
        currentDirectoryNavList.add(Row(
          children: [
            InkWell(child: Text(name, maxLines: 1, style: const TextStyle(color: Colors.blue),), onTap: () {
              createCurrentDirectoryNav(Directory(directory.path), firstEntry: true, fileFormat: fileFormat);
              // 获取当前目录下所有文件夹和文件
              getFileAndDirByPath(directory.path, fileFormat: fileFormat);
            },),
            const Icon(Icons.chevron_right_rounded),
          ],
        ));
      }
      if (directory.path != "/storage/emulated/0") {
        createCurrentDirectoryNav(directory.parent, firstEntry: false, fileFormat: fileFormat);
      }
    } finally {
      currentDirectoryNavLoading(false);
    }
  }

}