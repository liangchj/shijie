

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/video_player_params.dart';
import '../getx_controller/video_player_getx_controller.dart';
import 'video_player_bottom_ui.dart';
import 'video_player_top_ui.dart';


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
          // 弹幕UI
          _videoPlayerParams.danmakuUI ?? Container(),
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
      // Positioned(top: 0, right: 0, bottom: 0, child: PlaySpeedUI()),
      // 视频章节列表
      /*Positioned(
          top: 0, right: 0, bottom: 0, child: VideoChapterListUI()),*/
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

/// 清除已划过进度高度变高问题
class MySliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  const MySliderTrackShape();

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required Offset thumbCenter,
        Offset? secondaryOffset,
        bool isDiscrete = false,
        bool isEnabled = false,
      }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);

    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr) ? trackRect.top : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl) ? trackRect.top : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
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
