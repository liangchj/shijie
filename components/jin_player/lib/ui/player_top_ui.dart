import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/getx_update_id.dart';
import '../controller/player_controller.dart';
import '../data/ui_data.dart';
import 'play_speed_ui.dart';

/// 播放器顶部UI
class PlayerTopUI extends StatelessWidget {
  const PlayerTopUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.topBarUI,
        builder: (_) {
          return _.playerParams.fullScreenPlay
              ? AnimatedSlide(
                  offset: _.playerUIParams.showTopUI
                      ? const Offset(0, 0)
                      : const Offset(0, -1),
                  duration: UIData.uiShowAnimationDuration,
                  child: _buildTopUI(_),
                )
              : AnimatedCrossFade(
                  duration: UIData.uiShowAnimationDuration,
                  firstChild: _buildTopUI(_),
                  secondChild: Container(),
                  crossFadeState: _.playerUIParams.showTopUI
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                );
        });
  }

  _buildTopUI(PlayerGetxController playerGetxController) {
    return Container(
      // 背景渐变效果
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: UIData.gradientBackground)),
      child: Row(
        children: [
          const BackButton(
            color: Colors.white,
          ),
          const Expanded(
              child: Text(
                "标题",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              )),
          // 右边部分
          playerGetxController.playerParams.fullScreenPlay ? _buildHorizontalScreenTopRight(playerGetxController)
          : _buildVerticalScreenTopRight(playerGetxController),
        ],
      ),
    );
  }

  // 垂直屏幕显示内容
  _buildVerticalScreenTopRight(PlayerGetxController playerGetxController) {
    return // 最右边的按钮
      IconButton(
          padding: const EdgeInsets.only(left: 20),
          onPressed: () {
            print("顶部右边按钮");
            openPlayerSettingUI(playerGetxController);
          },
          icon: const Icon(
            Icons.more_horiz_rounded,
            color: Colors.white,
          ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 最右边的按钮
        IconButton(
            padding: const EdgeInsets.only(left: 20),
            onPressed: () {
              print("顶部右边按钮");
              openPlayerSettingUI(playerGetxController);
            },
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.white,
            ))
      ],
    );
  }

  // 横屏显示内容
  _buildHorizontalScreenTopRight(PlayerGetxController playerGetxController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 最右边的按钮
        IconButton(
            padding: const EdgeInsets.only(left: 20),
            onPressed: () {
              print("顶部右边按钮");
              openPlayerSettingUI(playerGetxController);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ))
      ],
    );
  }
  // 打开设置
  void openPlayerSettingUI(PlayerGetxController playerGetxController) {
    // 先隐藏所有的标签
    playerGetxController.hideAllUI();
    if (playerGetxController.playerParams.fullScreenPlay) {
      horizontalScreenSetting(playerGetxController);
    } else {
      verticalScreenSetting(playerGetxController);
    }

  }
  // 竖屏设置
  verticalScreenSetting(PlayerGetxController playerGetxController) {
    print("打开设置");
    openBottomSheet(SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Icon(Icons.favorite_border_rounded),
                Text("收藏")
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Icon(Icons.file_download_rounded),
                Text("缓存")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: InkWell(
              onTap: () {
                //关闭对话框
                bool open = Get.isBottomSheetOpen ?? false;
                if (open) {
                  Get.back();
                }
                openBottomSheet(
                    const PlaySpeedUI(isFullScreen: false)
                );
              },
              child: const Column(
                children: [
                  Icon(Icons.fast_forward_rounded),
                  Text("倍数播放")
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Icon(Icons.link_rounded),
                Text("复制链接")
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // 横屏设置
  horizontalScreenSetting(PlayerGetxController playerGetxController) {
    playerGetxController.showAndChangeSettingUI(null);
  }


  /// 打开底部窗口
  openBottomSheet(Widget widget) {
    Get.bottomSheet(
        Stack(
            children: [
              // SingleChildScrollView(child: widget,),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: widget,
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: 6,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        TextButton(onPressed: () {
                          //关闭对话框
                          bool open = Get.isBottomSheetOpen ?? false;
                          if (open) {
                            Get.back();
                          }
                        }, child: const Text("取消"))
                      ],
                    ),
                  ))
            ]
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10))));
  }
}
