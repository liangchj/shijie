
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jin_player/utils/my_icons_utils.dart';
import 'package:shijie/getx_controller/search_barrage_subtitle_controller.dart';
import 'package:shijie/model/file_model.dart';
import 'package:shijie/utils/file_directory_utils.dart';
import 'package:shijie/widgets/my_file_selector.dart';


class SearchBarrageSubtitlePage extends GetView<SearchBarrageSubtitleController> {
  const SearchBarrageSubtitlePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    FileModel fileModel = arguments['fileModel'];
    print("arguments:$arguments, fileModel:$fileModel, ${fileModel.directory}");
    controller.updateVideoFileModel(fileModel);

    //定义一个controller
    TextEditingController searchController =
    TextEditingController.fromValue(const TextEditingValue());
    // FileModel fileModel = arguments["fileModel"];
    return Scaffold(
        resizeToAvoidBottomInset: false, // 键盘显示不上移内容区域
      // backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(child: TextField(
              controller: searchController,
              // autofocus: true,
              maxLines: 1,
              scrollPadding: EdgeInsets.zero,
              onChanged: (value) {

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
              ),
            )),
            TextButton(onPressed: () {
              // fileModel.barragePath = "xxx";
              // Get.find<VideoFileController>().videoFileList.refresh();
              controller.getBarrageList("d");
            }, child: const Text("搜素"))
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              horizontalTitleGap: 0,
              // contentPadding: const EdgeInsets.only(left: 16, right: 0),
              leading: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  MyIconsUtils.folderFullBackground,
                  size: 40,
                  color: Colors.black26,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Text(
                  fileModel.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Obx(() {
                List<Widget> videoTrailingList = [];
                if (controller.videoFileModel.value.barragePath != null && controller.videoFileModel.value.barragePath!.isNotEmpty) {
                  videoTrailingList.add(InkWell(
                    onTap: () {
                      //关闭对话框
                      bool open = Get.isBottomSheetOpen ?? false;
                      if (open) {
                        Get.back();
                      }
                      Get.defaultDialog(
                          title: "移除弹幕",
                          radius: 6,
                          content: const Text("您确定想要移除绑定的弹幕？"),
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
                                controller.unbindBarrage(fileModel);
                                bool open = Get.isDialogOpen ?? false;
                                if(open) {
                                  Get.back();
                                }
                              }, //关闭对话框
                            ),

                          ]
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, //边框颜色
                          width: 1, //边框宽度
                        ), // 边色与边宽度
                        color: Colors.white, // 底
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text("弹·移除", style: TextStyle(fontSize: 12, color: Colors.blue)),
                    ),
                  ));
                }
                if (controller.videoFileModel.value.subtitlePath != null && controller.videoFileModel.value.subtitlePath!.isNotEmpty) {
                  videoTrailingList.add(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.amberAccent, //边框颜色
                        width: 1, //边框宽度
                      ), // 边色与边宽度
                      color: Colors.white, // 底
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Text("字·移除", style: TextStyle(fontSize: 12, color: Colors.amberAccent)),
                  ));
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: videoTrailingList.map((e) => e).toList(),
                );
              }),
            ),
            const Divider(),
            Expanded(child: Obx((){
              if (controller.loading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var videoNames = controller.barrageMap.keys.toList();
              var activeColor = Colors.white;
              var inactiveColor = Colors.black12;
              return Row(
                children: [
                  Container(
                    color: inactiveColor,
                    width: Get.width * 0.35,
                    child: ListView.builder(
                        itemCount: videoNames.length,
                        // itemExtent: 60.0, //强制高度为60.0
                        itemBuilder: (BuildContext context, int index) {
                          var videoName = videoNames[index];
                          return Container(
                            color: index == controller.clickVideoNameIndex.value ? activeColor : null,
                            child: ListTile(
                              onTap: () {
                                // controller.handleClickVideoName(videoName);
                                controller.handleClickVideoNameIndex(index);
                              },
                              // contentPadding: EdgeInsets.symmetric(horizontal: 6),
                              title: Text(videoName),
                            ),
                          );
                        }
                    ),
                  ),
                  Expanded(child: ListView.builder(
                      itemCount: controller.barrageList.length,
                      itemExtent: 60.0, //强制高度为60.0
                      itemBuilder: (BuildContext context, int index) {
                        var barrage = controller.barrageList[index];
                        return ListTile(
                            onTap: () {
                              //关闭对话框
                              bool open = Get.isBottomSheetOpen ?? false;
                              if (open) {
                                Get.back();
                              }
                              open = Get.isDialogOpen ?? false;
                              if (open) {
                                Get.back();
                              }
                              Get.bottomSheet(
                                  _selectNetBarrage(),
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.only(
                                          topStart: Radius.circular(10),
                                          topEnd: Radius.circular(10))));
                            },
                            title: Text(barrage.name)
                        );
                      }
                  ))
                ],
              );
            }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //关闭对话框
          bool open = Get.isBottomSheetOpen ?? false;
          if (open) {
            Get.back();
          }
          open = Get.isDialogOpen ?? false;
          if (open) {
            Get.back();
          }
          Get.bottomSheet(
              _selectLocalBarrage(fileModel, Directory(fileModel.directory)),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10))));
          /*getExternalStorageDirectory().then((value) => Get.bottomSheet(
              _selectLocalBarrage(fileModel, value),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10)))));*/
          /*Get.bottomSheet(
              _selectLocalBarrage(fileModel),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10))));*/
          // _selectLocalBarrage(fileModel);
        },
        tooltip: 'getVideo',
        child: const Icon(Icons.phone_android_rounded),
      ),
    );
  }

  /// 选择网络弹幕
  _selectNetBarrage() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding:
            EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 0),
            child: Center(
              child: Text(
                "下载弹幕",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const Padding(
            padding:
            EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 0),
            child: Row(
              children: [
                Text(
                  "路径：",
                ),
                Text("xxxxxxxxxxxxx")
              ],
            ),
          ),
          const Padding(
            padding:
            EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 6),
            child: Text(
              "选择弹幕源",
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              shrinkWrap: true,
              children: const [
                ListTile(title: Text("1"),),
                ListTile(title: Text("11rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("11rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("11rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("11rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("11rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("11rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("11rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("11rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("11rwtwetaqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1tre"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1trt"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1"),),
                ListTile(title: Text("1tt"),),
                ListTile(title: Text("1t4"),),
                ListTile(title: Text("1t"),),
                ListTile(title: Text("1e"),),
                ListTile(title: Text("rer"),),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 选择本地弹幕
  _selectLocalBarrage(FileModel fileModel, externalStorageDirectory) {
    return Container(
      height: Get.height*0.7,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding:
            EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 0),
            child: Center(
              child: Text(
                "选择本地弹幕文件",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(child: MyFileSelector(
            directory: externalStorageDirectory,
            // fileFormat: FileFormat.xml,
            fileFormat: FileFormat.danmaku,
            onTapFile: (file) {
              controller.bindBarrage(file.path, fileModel);
              //关闭对话框
              bool open = Get.isBottomSheetOpen ?? false;
              if (open) {
                Get.back();
              }
            },
          )),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            20))),
              ),
              child: const Text("取消"),
              onPressed: () {
                //关闭对话框
                bool open = Get.isBottomSheetOpen ?? false;
                if (open) {
                  Get.back();
                }
              },
            ),
          )
        ],
      ),
    );

  }


}