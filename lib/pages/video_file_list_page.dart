import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/getx_controller/video_file_controller.dart';
import 'package:shijie/model/directory_model.dart';
import 'package:shijie/model/file_model.dart';
import 'package:shijie/widgets/video_file_item_widget.dart';

/// 文件列表
class VideoFileListPage extends GetView<VideoFileController> {
  const VideoFileListPage({Key? key}) : super(key: key);

  Widget _defaultHeaderWidget(String dirName) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: Get.width,
        // 标题名称与列表的padding
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.2), //边框颜色
            width: 1, //边框宽度
          ), // 边色与边宽度
          color: Colors.white, // 底色
          boxShadow: [
            BoxShadow(
              blurRadius: 10, //阴影范围
              spreadRadius: 0.1, //阴影浓度
              color: Colors.grey.withOpacity(0.2), //阴影颜色
            ),
          ],
        ),
        child: Text(
          dirName,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("创建UI UI 视频列表");
    print("创建UI build VideoFileListPage");
    Map<String, dynamic> params = Get.arguments;
    String title = params['title'] ?? "";
    String path = params['path'] ?? "";
    String dirName = params['dirName'] ?? "";
    var sourceType = params['directorySourceType'];
    DirectorySourceType directorySourceType = sourceType == null ? DirectorySourceType.localDirectory : sourceType as DirectorySourceType;
    Widget headerWidget = _defaultHeaderWidget(dirName);
    EdgeInsetsGeometry listViewPadding = const EdgeInsets.only(bottom: 10);

    controller.getVideoFileList(path, directorySourceType);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          headerWidget,
          Expanded(
            child: Obx(() {
              if (controller.loading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return controller.videoFileList.isEmpty
                    ? const Center(
                        child: Text("没有视频"),
                      )
                    : ListView.builder(
                        padding: listViewPadding,
                        itemExtent: 78,
                        itemCount: controller.videoFileList.length,
                        itemBuilder: (context, index) {
                          FileModel fileModel = controller.videoFileList[index];
                          return VideoFileItemWidget(fileModel: fileModel);
                        });
              }
            }),
          ),
        ],
      ),
    );
  }
}
