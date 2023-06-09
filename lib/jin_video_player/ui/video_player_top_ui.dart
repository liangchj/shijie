import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_controller/video_player_getx_controller.dart';
import 'play_speed_ui.dart';
import 'video_player_ui.dart';

/// 播放器顶部UI
class VideoPlayerTopUI extends StatelessWidget {
  const VideoPlayerTopUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.topBarUI,
        builder: (_) {
          print("更新top:${_.videoPlayerParams.isFullScreen}");
          return _.videoPlayerParams.isFullScreen
              ? AnimatedSlide(
                  offset: _.videoPlayerParams.showTopUI
                      ? const Offset(0, 0)
                      : const Offset(0, -1),
                  duration: UIData.uiShowAnimationDuration,
                  child: _buildTopUI(_),
                )
              : AnimatedCrossFade(
                duration: UIData.uiShowAnimationDuration,
                firstChild: _buildTopUI(_),
                secondChild: Container(),
                crossFadeState: _.videoPlayerParams.showTopUI ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              );
                /*: AnimatedScale(duration: UIData.uiShowAnimationDuration,
                   alignment: Alignment.topLeft,
                   scale: _.videoPlayerParams.showTopUI ? 1 : 0,
                  child: _buildTopUI(_.videoPlayerParams)
                );*/

        });
  }

  Widget _buildTopUI(VideoPlayerGetxController _) {
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
          //右边部分
          IconButton(
              padding: const EdgeInsets.only(left: 20),
              onPressed: () {
                print("顶部右边按钮");
                openVideoPlayerSettingUI(_);
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  openVideoPlayerSettingUI(VideoPlayerGetxController _) {
    if (_.videoPlayerParams.isFullScreen) {

    } else {
      _.hideAllUI();
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
  }

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
