
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/getx_controller/play_directory_controller.dart';
import 'package:shijie/model/directory_model.dart';
import 'package:shijie/route/app_routes.dart';
import 'package:shijie/widgets/directory_item_widget.dart';


/// 播放目录列表
class PlayDirectoryListPage extends GetView<PlayDirectoryListController> {
  const PlayDirectoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("视频播放列表"),
        actions: [
          IconButton(
              onPressed: () => {}, icon: const Icon(Icons.search_rounded)),
          IconButton(
              onPressed: () => {}, icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                  onPressed: () {
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
            ),
            Expanded(
              child: Obx(() {
                if (controller.loading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var videoDirectoryList = controller.videoDirectoryList;
                  return videoDirectoryList.isEmpty
                      ? const Center(
                    child: Text("没有视频"),
                  )
                      : _buildPlayDirectoryList(videoDirectoryList);
                }
              }),
            )
          ],
        ),
      ),
    );
  }
  /// 构建目录
  Widget _buildPlayDirectoryList(List<DirectoryModel> videoDirectoryList) {
    return Scrollbar(
        child: ListView.builder(
            itemExtent: 66,
            itemCount: videoDirectoryList.length,
            itemBuilder: (context, index) {
              var fileDirectoryModel = videoDirectoryList[index];
              return DirectoryItemWidget(directoryModel: fileDirectoryModel, onTap: () {
                Map<String, dynamic> params = {"path": fileDirectoryModel.name, "title": "播放列表",
                  "directorySourceType": DirectorySourceType.playDirectory, "dirName": fileDirectoryModel.name};
                Get.toNamed(AppRoutes.videoFileList, arguments: params);
              },
                trailingWidget: IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    onPressed: () {
                      Get.bottomSheet(_buildOperateListWidget(context, playDirectoryModel: fileDirectoryModel), backgroundColor: Colors.white, shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(10), topEnd: Radius.circular(10))));
                    },
                    icon: const Icon(Icons.more_vert_rounded)),
                contentPadding: const EdgeInsets.only(left: 16, right: 0),
              );
            }));
  }

  /// 创建新的播放列表
  Widget _buildNewPlayDirectory() {
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
    controller.createNewPlayDirectoryName.value = ""; // 清除新增播放目录名称
    controller.createNewPlayDirectoryErrorText.value = ""; // 清除新增播放目录验证信息
    ValueKey createBtn = ValueKey("createNewPlayDirectoryBtn_${DateTime.now().millisecondsSinceEpoch}");
    ValueKey notCreateBtn = ValueKey("notCreateNewPlayDirectoryBtn_${DateTime.now().millisecondsSinceEpoch}");
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
                    controller.createNewPlayDirectoryName.value = value; // 新增播放目录名称
                    if (value.isEmpty) { // 新增播放目录名称为空时清除验证信息
                      controller.createNewPlayDirectoryErrorText.value = "";
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
                      errorText: controller.createNewPlayDirectoryErrorText.value.isEmpty ? null : controller.createNewPlayDirectoryErrorText.value
                  ),
                ),
                ),),

                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                Obx(() =>  Padding(
                  // 新增播放目录名称验证不通过时显示错误信息导致输入框上移，因此按钮也同步上移
                  padding: controller.createNewPlayDirectoryErrorText.value.isEmpty ? EdgeInsets.zero : const EdgeInsets.only(bottom: 22.0),
                  child: ElevatedButton(
                    // 新增播放目录名称为空时不可点击创建按钮
                      onPressed: controller.createNewPlayDirectoryName.value.isEmpty ? null : (){
                        String text = newPlayListController.text.trim();
                        if (text.isNotEmpty) {
                          var msg = controller.addVideoPlayDirectory(DirectoryModel(path: text,name: text, fileNumber: 0));
                          if (msg == null || msg.isEmpty) {
                            //关闭对话框
                            bool open = Get.isBottomSheetOpen ?? false;
                            if(open) {
                              Get.back();
                            }
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
  /// 创建右边操作栏
  Widget _buildOperateListWidget(BuildContext context, {required DirectoryModel playDirectoryModel}) {
    // name 重命名 字幕 弹幕 添加到播放列表 删除
    final ButtonStyle buttonStyle = ButtonStyle(
        alignment: Alignment.centerLeft,
        foregroundColor: MaterialStateProperty.all(Colors.black87));
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          shrinkWrap: true,
          children: <Widget>[
            TextButton.icon(
              style: buttonStyle,
              icon: const Icon(Icons.edit_rounded),
              label: const Text("重命名"),
              onPressed: () => _renamePlayDirectoryFile(playDirectoryModel),
            ),
            TextButton.icon(
              style: buttonStyle,
              icon: const Icon(Icons.delete_rounded),
              label: const Text("删除"),
              onPressed: () async {
                bool open = Get.isDialogOpen ?? false;
                if(open) {
                  Get.back();
                }
                //关闭对话框
                open = Get.isBottomSheetOpen ?? false;
                if(open) {
                  Get.back();
                }
                Get.defaultDialog(
                  title: "删除",
                  content: const Text("您确定想要删除此播放列表吗？"),
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
                        child: const Text("删除"),
                        onPressed: () {
                            controller.removeVideoPlayDirectory(playDirectoryModel);
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
          ],
        ),
      ),
    );
  }

  /// 重命名
  _renamePlayDirectoryFile(DirectoryModel playDirectoryModel) {
    //关闭对话框
    bool open = Get.isBottomSheetOpen ?? false;
    if(open) {
      Get.back();
    }
    String oldName = playDirectoryModel.name;
    //定义一个controller
    TextEditingController nameController =
    TextEditingController.fromValue(TextEditingValue(
      text: oldName,
    ));
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
              if(open) {
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
                playDirectoryModel.name = newName;
                controller.reorder();
                bool open = Get.isDialogOpen ?? false;
                if(open) {
                  Get.back();
                }
              }
            }, //关闭对话框
          ),

        ]
    );
  }




}