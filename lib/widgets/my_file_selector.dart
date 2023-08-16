import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jin_player/utils/my_icons_utils.dart';
import 'package:shijie/getx_controller/my_file_selector_controller.dart';
import 'package:shijie/utils/file_directory_utils.dart';



class MyFileSelector extends StatelessWidget {
  MyFileSelector({Key? key, required this.directory, this.fileFormat, this.onConfirm, this.onCancel, this.onTapFile}) : super(key: key);
  final Directory directory;
  final FileFormat? fileFormat;
  final Function? onConfirm;
  final Function? onCancel;
  final Function(File)? onTapFile;


  final MyFileSelectorController fileSelectorController = Get.put(MyFileSelectorController());

  void _init() {
    fileSelectorController.getFileAndDirByPath(directory.path, fileFormat: fileFormat);
    fileSelectorController.createCurrentDirectoryNav(directory, fileFormat: fileFormat);
  }

  @override
  Widget build(BuildContext context) {
    _init();
    ScrollController scrollController = ScrollController();

    return Column(
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Obx(() {
            if (fileSelectorController.currentDirectoryNavLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Row(
              children: [
                fileSelectorController.currentDirectoryNavList[fileSelectorController.currentDirectoryNavList.length-1],
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: fileSelectorController.currentDirectoryNavList.getRange(0, fileSelectorController.currentDirectoryNavList.length-1).toList().reversed.map((e) => e).toList(),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        Expanded(child:
          Obx(() {
            if (fileSelectorController.loading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemExtent: 50,
                itemCount: fileSelectorController.fileList.length,
                itemBuilder: (context, index) {
                  File file = fileSelectorController.fileList[index];
                  var isFile = FileSystemEntity.isFileSync(file.path);
                  return InkWell(
                    onTap: () {
                      if (isFile) {
                        onTapFile?.call(file);
                      } else {
                        print("fileFormat: fileFormat");
                        fileSelectorController.createCurrentDirectoryNav(Directory(file.path), firstEntry: true, fileFormat: fileFormat);
                        fileSelectorController.getFileAndDirByPath(file.path, fileFormat: fileFormat);
                      }
                    },
                    child: ListTile(
                      horizontalTitleGap: 0,
                      // contentPadding: const EdgeInsets.only(left: 16, right: 0),
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          isFile ? Icons.file_copy_rounded :
                          MyIconsUtils.folderFullBackground,
                          size: 40,
                          color: Colors.black26,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Text(
                          file.path.split("/").last,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                });
          })
        )
      ],
    );
  }
}
