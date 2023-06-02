

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jin_video_player/config/video_player_params.dart';
import 'package:jin_video_player/getx_controller/video_player_getx_controller.dart';
import 'package:jin_video_player/ui/play_speed_ui.dart';
import 'package:jin_video_player/ui/video_chapter_list_ui.dart';
import 'package:jin_video_player/ui/video_player_bottom_ui.dart';
import 'package:jin_video_player/ui/video_player_top_ui.dart';

class VideoPlayerUI extends StatefulWidget {
  const VideoPlayerUI({Key? key}) : super(key: key);

  @override
  State<VideoPlayerUI> createState() => _VideoPlayerUIState();
}

class _VideoPlayerUIState extends State<VideoPlayerUI> {
  final VideoPlayerGetxController _videoPlayerController = Get.find<VideoPlayerGetxController>();
  late VideoPlayerParams _videoPlayerParams;
  Timer? _hideTimer;

  @override
  void initState() {
    _videoPlayerParams = _videoPlayerController.videoPlayerParams;
    super.initState();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  /// 开始计时UI显示时间
  void _startHideTimer() {
    _hideTimer = Timer(UIData.uiShowDuration, () {
      _videoPlayerController.changeShowTopAndBottomUIState(false);
    });
  }

  /// 重新计算显示/隐藏UI计时器
  void _cancelAndRestartTimer() {
    print("重新计算显示/隐藏UI计时器");
    _hideTimer?.cancel();
    _startHideTimer();
    _videoPlayerController.changeShowTopAndBottomUIState(true);
  }

  /// 点击背景
  void _toggleBackground() {
    print("点击背景");
    if (_videoPlayerController.haveUIShow()) {
      _videoPlayerController.hideAllUI();
    } else {
      _cancelAndRestartTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ()=>_toggleBackground(),
      onHorizontalDragEnd: (d) {
        print("onHorizontalDragEnd");
      },
      child: Stack(
        children: [
          // 顶部
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: GestureDetector(
                onTap: () {
                  print("点击了顶部UI");
                  if (_videoPlayerParams.showTopUI) {
                    _cancelAndRestartTimer();
                  }
                },
              child: const VideoPlayerTopUI()
            ),
          ),

          // 底部
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
                onTap: () {
                  print("点击了底部UI");
                  if (_videoPlayerParams.showBottomUI) {
                    _cancelAndRestartTimer();
                  }
                },
                child: VideoPlayerBottomUI(hideTimer: _hideTimer, startHideTimer: _startHideTimer))
          ),
          if (_videoPlayerParams.isFullScreen)
            ..._fullScreenUIList()
        ],
      ),
    );
  }

  List<Widget> _fullScreenUIList() {
    return [
      // 播放速度
      Positioned(top: 0, right: 0, bottom: 0, child: PlaySpeedUI()),
      // 视频章节列表
      Positioned(
          top: 0, right: 0, bottom: 0, child: VideoChapterListUI()),
    ];
  }
}


/// 文本框Widget
class BuildTextWidget extends StatelessWidget {
  const BuildTextWidget(
      {Key? key, required this.text, this.style, this.edgeInsets})
      : super(key: key);
  final String text;
  final TextStyle? style;
  final EdgeInsets? edgeInsets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsets ?? const EdgeInsets.only(left: 5, right: 5),
      child: Text(text, style: style ?? const TextStyle(color: Colors.white)),
    );
  }
}


/// UI需要的数据
class UIData {
  static List<Color> gradientBackground = [
    Colors.black54,
    Colors.black45,
    Colors.black38,
    Colors.black26,
    Colors.black12,
    Colors.transparent
  ];
  static Duration uiShowAnimationDuration = const Duration(milliseconds: 300);
  static Duration uiHideAnimationDuration = const Duration(milliseconds: 300);
  static Duration iconChangeDuration = const Duration(milliseconds: 75);
  static Duration uiShowDuration = const Duration(seconds: 5);
}
