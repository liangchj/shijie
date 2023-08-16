import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/getx_controller/play_directory_controller.dart';
import 'package:shijie/getx_controller/video_file_controller.dart';
import 'package:shijie/model/directory_model.dart';
import 'package:shijie/model/file_model.dart';
import 'package:shijie/route/app_routes.dart';
import 'package:shijie/widgets/directory_item_widget.dart';
import 'package:shijie/widgets/file_item_widget.dart';

/// 视频文件widget
class VideoFileItemWidget extends StatelessWidget {
  const VideoFileItemWidget({Key? key, required this.fileModel, this.onTap}) : super(key: key);
  final FileModel fileModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return FileItemWidget(
      fileModel: fileModel,
      trailingWidget: _buildRightOperateIcon(fileModel, context),
      onTap: () {
        print("点击视频");
        // Get.to(ChewieVideoPlayerPage(videoUrl: fileModel.path));
        // Get.to(PlayerPage(videoUrl: fileModel.path));
        // Get.to(PlayerView(videoUrl: fileModel.path, name: fileModel.name, videoChapterList: Get.find<VideoFileController>().videoFileList,));
      },
    );
  }

  /// 视频右边操作图标
  IconButton _buildRightOperateIcon(FileModel fileModel, BuildContext context) {
    return IconButton(
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        onPressed: () {
          Get.bottomSheet(
              _buildOperateListWidget(context, fileModel: fileModel),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10))));
        },
        icon: const Icon(Icons.more_vert_rounded));
  }

  /// 视频操作弹窗
  Widget _buildOperateListWidget(BuildContext context,
      {required FileModel fileModel}) {

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 0),
              child: Text(
                fileModel.name,
                textAlign: TextAlign.left,
              ),
            ),
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              shrinkWrap: true,
              children: _createOperateList(fileModel),
            )
          ],
        ),
      ),
    );
  }

  /// 生成操作列表
  List<Widget> _createOperateList(FileModel fileModel) {
    // name 重命名 字幕 弹幕 添加到播放列表 删除
    final ButtonStyle buttonStyle = ButtonStyle(
        alignment: Alignment.centerLeft,
        foregroundColor: MaterialStateProperty.all(Colors.black87));
    Widget renameWidget = TextButton.icon(
      style: buttonStyle,
      icon: const Icon(Icons.edit_rounded),
      label: const Text("重命名"),
      onPressed: () => _renameFile(fileModel),
    );
    Widget subtitlesWidget = TextButton.icon(
      style: buttonStyle,
      icon: const Icon(Icons.subtitles_rounded),
      label: const Text("搜索字幕"),
      onPressed: () {
        //关闭对话框
        bool open = Get.isBottomSheetOpen ?? false;
        if (open) {
          Get.back();
        }
        // Fluttertoast.showToast(
        //     msg: "功能暂未实现",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.black.withOpacity(0.7),
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
        // Get.toNamed(AppRoutes.searchBarrageSubtitle);
      },
    );
    Widget danmakuWidget = TextButton.icon(
      style: buttonStyle,
      icon: const Icon(Icons.subject_rounded),
      label: const Text("绑定弹幕"),
      onPressed: () {
        Map<String, dynamic> params = {
          "fileModel": fileModel,
        };
        //关闭对话框
        bool open = Get.isBottomSheetOpen ?? false;
        if (open) {
          Get.back();
        }
        Get.toNamed(AppRoutes.searchBarrageSubtitle, arguments: params);
      },
    );
    Widget addToPlayDirectoryWidget = TextButton.icon(
      style: buttonStyle,
      icon: const Icon(Icons.playlist_play_rounded),
      label: const Text("添加到播放列表"),
      onPressed: () => _addToPlayList(fileModel),
    );
    Widget playWidget = TextButton.icon(
      style: buttonStyle,
      icon: const Icon(Icons.play_circle_fill_rounded),
      label: const Text("播放"),
      onPressed: () {
        //关闭对话框
        bool open = Get.isBottomSheetOpen ?? false;
        if (open) {
          Get.back();
        }
        /*Fluttertoast.showToast(
            msg: "点击播放",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black.withOpacity(0.7),
            textColor: Colors.white,
            fontSize: 16.0
        );*/
      },
    );
    if (fileModel.fileSourceType == FileSourceType.playListFile) {
      return [
        playWidget,
        subtitlesWidget,
        danmakuWidget,
        TextButton.icon(
          style: buttonStyle,
          icon: const Icon(Icons.delete_rounded),
          label: const Text("移除"),
          onPressed: () async {
            //关闭对话框
            bool open = Get.isBottomSheetOpen ?? false;
            if (open) {
              Get.back();
            }
            Get.defaultDialog(
                title: "移除视频",
                radius: 6,
                content: Text("您确定想要从播放列表中移除“${fileModel.name}”？"),
                actions: [
                  TextButton(
                    child: const Text("取消"),
                    onPressed: () {
                      bool open = Get.isDialogOpen ?? false;
                      if(open) {
                        Get.back();
                      }
                    },
                  ),
                  TextButton(
                    child: const Text("移除"),
                    onPressed: () {
                      var remove = Get.find<VideoFileController>().removeVideoFromPlayDirectory(fileModel);
                      if (remove) {
                        Get.find<PlayDirectoryListController>().removeVideoFromPlayDirectory(fileModel.directory);
                      }
                      /*Fluttertoast.showToast(
                          msg: "移除成功",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black.withOpacity(0.7),
                          textColor: Colors.white,
                          fontSize: 16.0
                      );*/
                      bool open = Get.isDialogOpen ?? false;
                      if(open) {
                        Get.back();
                      }
                    }, //关闭对话框
                  ),

                ]
            );
          },
        ),
      ];
    }
    return [
      renameWidget,
      subtitlesWidget,
      danmakuWidget,
      addToPlayDirectoryWidget,
      TextButton.icon(
        style: buttonStyle,
        icon: const Icon(Icons.delete_rounded),
        label: const Text("删除"),
        onPressed: () async {
          //关闭对话框
          bool open = Get.isBottomSheetOpen ?? false;
          if (open) {
            Get.back();
          }
          /*Fluttertoast.showToast(
              msg: "点击删除",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black.withOpacity(0.7),
              textColor: Colors.white,
              fontSize: 16.0
          );*/
        },
      ),
    ];
  }


  /// 重命名
  void _renameFile(FileModel fileModel) {
    String oldName = fileModel.name;
    String suffix = fileModel.path.contains(".") ? fileModel.path.split(".").last : "";
    //关闭对话框
    bool open = Get.isBottomSheetOpen ?? false;
    if (open) {
      Get.back();
    }
    //定义一个controller
    TextEditingController nameController =
        TextEditingController.fromValue(TextEditingValue(
      text: oldName,
    ));
    /*bool? flag = await AlertDialogUtils.modalConfirmAlertDialog(
                      buildContext: context,
                      title: "重命名",
                      content: TextField(
                        controller: nameController, //设置cont
                        inputFormatters: const [
                          //FilteringTextInputFormatter.deny(RegExp(r"^[a-zA-Z]:[\\]((?! )(?![^\\/]*\s+[\\/])[w -]+[\\/])*(?! )(?![^.]*\s+\.)[w -]+$")),
                        ], // roller
                      ),
                      cancelText: "取消",
                      confirmText: "确定",
                    );
                    if (flag == null) {
                      print("取消，${nameController.text}");
                    } else {
                      var newName = nameController.text;
                      print("确认变更，${nameController.text}");
                      if (newName != oldName) {
                        File file = videoInfo.file;
                        File renameSync = file.renameSync(
                            "${videoInfo.dir}${Platform.pathSeparator}$newName");
                        print(
                            "重命名成功,$renameSync,${renameSync.path},${FileSystemEntity.isFileSync(renameSync.path)}");
                        setState(() {
                          _videoFileList.fillRange(index, index + 1,
                              VideoFileDirModel(path: renameSync.path));
                          _videoFileList
                              .sort((VideoFileDirModel a, VideoFileDirModel b) {
                            return a.getFullName
                                .toLowerCase()
                                .compareTo(b.getFullName.toLowerCase());
                          });
                        });
                      }
                    }
                  },*/

    Get.defaultDialog(
        title: "重命名为",
        radius: 6,
        content: TextField(
          controller: nameController, //设置cont
          inputFormatters: const [], // roller
        ),
        actions: [
          TextButton(
            child: const Text("取消"),
            onPressed: () {
              bool open = Get.isDialogOpen ?? false;
              if (open) {
                Get.back();
              }
            },
          ),
          TextButton(
            child: const Text("确定"),
            onPressed: () {
              var newName = nameController.text;
              print("确认变更，${nameController.text}");
              if (newName != oldName) {
                File file = fileModel.file;
                try {
                  File renameSync = file.renameSync(
                      "${fileModel.dir}${Platform.pathSeparator}$newName${suffix
                          .isEmpty ? '' : '.$suffix'}");
                  print(
                      "重命名成功,$renameSync,${renameSync.path},${FileSystemEntity
                          .isFileSync(renameSync.path)}");
                  FileModel? newFileModel;
                  if (renameSync.existsSync()) {
                    String path = renameSync.path;
                    String fullName =
                    path.contains("/") ? path
                        .split("/")
                        .last : path;
                    String name = fullName.contains(".")
                        ? fullName.substring(0, fullName.lastIndexOf("."))
                        : fullName;
                    fileModel.fullName = fullName;
                    fileModel.name = name;
                    // Get.find<VideoFileController>().videoFileList.refresh();
                    Get.find<VideoFileController>().reorder();
                  }
                } on Exception {
                  /*Fluttertoast.showToast(
                      msg: "修改失败，请确认原文件是否存在",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black.withOpacity(0.7),
                      textColor: Colors.white,
                      fontSize: 16.0
                  );*/
                }
                bool open = Get.isDialogOpen ?? false;
                if (open) {
                  Get.back();
                }
              }
            }, //关闭对话框
          ),
        ]);
  }

  /// 添加到播放列表
  _addToPlayList(FileModel fileModel) {
    //关闭对话框
    bool open = Get.isBottomSheetOpen ?? false;
    if (open) {
      Get.back();
    }
    Get.bottomSheet(
        Container(
          height: Get.height * 0.6,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  "将视频添加至播放列表",
                  textAlign: TextAlign.left,
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    //Get.back();
                    Get.bottomSheet(_buildNewPlayDirectory(),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(10),
                            topEnd: Radius.circular(10))));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      Text("创建新播放列表"),
                    ],
                  )),
              Expanded(
                child: _buildPlayDirectoryList(fileModel),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10), topEnd: Radius.circular(10))));
  }

  /// 构建播放目录列表
  Widget _buildPlayDirectoryList(FileModel fileModel) {
    var playDirectoryController = Get.find<PlayDirectoryListController>();
    var videoFileController = Get.find<VideoFileController>();
    var videoDirectoryList = playDirectoryController.videoDirectoryList;
    return Scrollbar(
        child: ListView.builder(
            itemExtent: 66,
            itemCount: videoDirectoryList.length,
            itemBuilder: (context, index) {
              var fileDirectoryModel = videoDirectoryList[index];
              return DirectoryItemWidget(
                directoryModel: fileDirectoryModel,
                onTap: () {
                  String toastText = playDirectoryController.addVideoToPlayDirectory(fileDirectoryModel, fileModel);
                  //关闭对话框
                  bool open = Get.isBottomSheetOpen ?? false;
                  if (open) {
                    Get.back();
                  }
                  // 视频已经存在于“”列表中
                  // 一个视频已添加到“”列表
                  if (toastText.isNotEmpty) {
                    /*Fluttertoast.showToast(
                        msg: toastText,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.7),
                        textColor: Colors.white,
                        fontSize: 16.0
                    );*/
                  }
                },
                contentPadding: const EdgeInsets.only(left: 0, right: 0),
              );
            }));
  }


  /// 创建新的播放列表
  Widget _buildNewPlayDirectory() {
    var playDirectoryController = Get.find<PlayDirectoryListController>();
    //关闭对话框
    bool open = Get.isBottomSheetOpen ?? false;
    if(open) {
      Get.back();
    }
    //定义一个controller
    TextEditingController newPlayListController =
    TextEditingController.fromValue(TextEditingValue(
      /// 设置光标在最后
      selection: TextSelection.fromPosition(const TextPosition(
          affinity: TextAffinity.downstream,
          offset: 0)),
    ));
    playDirectoryController.createNewPlayDirectoryName.value = ""; // 清除新增播放目录名称
    playDirectoryController.createNewPlayDirectoryErrorText.value = ""; // 清除新增播放目录验证信息
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.playlist_play_rounded),
                Text("创建新的播放列表")
              ],
            ),
            Row(
              children: [
                Obx(() => Expanded(child: TextField(
                  controller: newPlayListController,
                  autofocus: true,
                  maxLines: 1,
                  scrollPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    playDirectoryController.createNewPlayDirectoryName.value = value; // 新增播放目录名称
                    if (value.isEmpty) { // 新增播放目录名称为空时清除验证信息
                      playDirectoryController.createNewPlayDirectoryErrorText.value = "";
                    }
                  },
                  decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      //获得焦点下划线设为蓝色
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Get.theme.backgroundColor),
                      ),
                      border: const OutlineInputBorder(
                      ),
                      // 新增播放目录名称验证信息
                      errorText: playDirectoryController.createNewPlayDirectoryErrorText.value.isEmpty ? null : playDirectoryController.createNewPlayDirectoryErrorText.value
                  ),
                ),
                ),),

                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                Obx(() =>  Padding(
                  // 新增播放目录名称验证不通过时显示错误信息导致输入框上移，因此按钮也同步上移
                  padding: playDirectoryController.createNewPlayDirectoryErrorText.value.isEmpty ? EdgeInsets.zero : const EdgeInsets.only(bottom: 22.0),
                  child: ElevatedButton(
                    // 新增播放目录名称为空时不可点击创建按钮
                      onPressed: playDirectoryController.createNewPlayDirectoryName.value.isEmpty ? null : (){
                        String text = newPlayListController.text.trim();
                        if (text.isNotEmpty) {
                          var fileDirectoryModel = DirectoryModel(path: text,name: text, fileNumber: 0);
                          var msg = playDirectoryController.addVideoPlayDirectory(fileDirectoryModel);
                          String toastText = playDirectoryController.addVideoToPlayDirectory(fileDirectoryModel, fileModel);
                          if (msg == null || msg.isEmpty) {
                            //关闭对话框
                            bool open = Get.isBottomSheetOpen ?? false;
                            if(open) {
                              Get.back();
                            }
                          }
                          // 视频已经存在于“”列表中
                          // 一个视频已添加到“”列表
                          if (toastText.isNotEmpty) {
                            /*Fluttertoast.showToast(
                                msg: toastText,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black.withOpacity(0.7),
                                textColor: Colors.white,
                                fontSize: 16.0
                            );*/
                          }
                        }
                      }, style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 36)
                  ),
                      child: const Text("创建")),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
