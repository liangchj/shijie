
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jin_player/ui/player_top_ui.dart';

import '../config/getx_update_id.dart';
import '../controller/player_controller.dart';
import '../data/ui_data.dart';
import 'player_bottom_ui.dart';

class PlayerUI extends StatefulWidget {
  const PlayerUI({Key? key}) : super(key: key);

  @override
  State<PlayerUI> createState() => _PlayerUIState();
}

class _PlayerUIState extends State<PlayerUI> {
  final PlayerGetxController _playerGetxController = Get.find<PlayerGetxController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!_playerGetxController.rotateScreenIng) {
      _playerGetxController.cancelAndRestartTimer();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _playerGetxController.toggleBackground(),
        onHorizontalDragStart: (DragStartDetails details) {
          print(
              "滑动屏幕 开始拖动 横向: $details, ${details.globalPosition}, ${details.localPosition}, ${context.size}");
          _playerGetxController.playProgressOnHorizontalDragStart();
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          print(
              "滑动屏幕 拖动中 横向: $details, ${details.globalPosition}, ${details.localPosition}, ${details.delta}");
          _playerGetxController.playProgressOnHorizontalDragUpdate(
              context, details.delta);
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          print("滑动屏幕 拖动结束 横向: $details");
          _playerGetxController.playProgressOnHorizontalDragEnd();
        },
        onVerticalDragStart: (DragStartDetails details) {
          print(
              "滑动屏幕 开始拖动 纵向: $details, ${details.globalPosition}, ${details.localPosition}");
          _playerGetxController
              .volumeOrBrightnessOnVerticalDragStart(details);
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          print(
              "滑动屏幕 拖动中 纵向: $details, ${details.globalPosition}, ${details.localPosition}, ${details.delta}");
          _playerGetxController.volumeOrBrightnessOnVerticalDragUpdate(
              context, details);
        },
        onVerticalDragEnd: (DragEndDetails details) {
          print("滑动屏幕 拖动结束 纵向: $details");
          _playerGetxController.volumeOrBrightnessOnVerticalDragEnd();
        },
        child: _playerGetxController.playerParams.fullScreenPlay ? const HorizontalScreenUI() : const VerticalScreenUI(),
      ),
    );
  }
}

class VerticalScreenUI extends StatefulWidget {
  const VerticalScreenUI({Key? key}) : super(key: key);

  @override
  State<VerticalScreenUI> createState() => _VerticalScreenUIState();
}

class _VerticalScreenUIState extends State<VerticalScreenUI> {
  final PlayerGetxController _playerGetxController = Get.find<PlayerGetxController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 弹幕
        // 顶部
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: GestureDetector(
              onTap: () {
                _playerGetxController.cancelAndRestartTimer();
              },
              child: const PlayerTopUI()
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
                  if (_playerGetxController.playerUIParams.showBottomUI) {
                    _playerGetxController.cancelAndRestartTimer();
                  }
                },
                child: const PlayerBottomUI())
        ),

        // 中间加载缓冲
        Center(child: GetBuilder<PlayerGetxController>(
          id: GetxUpdateId.centerLoadingUI,
          builder: (_) => Opacity(
            opacity: _.playerUIParams.showCenterLoadingUI ? 1 : 0,
            child: Container(
              child: _playerGetxController.playerUIParams.centerLoadingUI,),
          ),
        ),),

        // 中间UI（拖动播放进度、加载视频失败信息、暂停/播放按钮等）
        Center(child: GetBuilder<PlayerGetxController>(
          id: GetxUpdateId.centerUI,
          builder: (_) => Opacity(
            opacity: _.playerUIParams.showCenterUI ? 1 : 0,
            child: Container(
              child: _playerGetxController.playerUIParams.centerUI,),
          ),
        ),),

        // 中间亮度和音量UI 最高层级
        Center(child: GetBuilder<PlayerGetxController>(
          id: GetxUpdateId.centerVolumeAndBrightnessUI,
          builder: (_) => Opacity(
            opacity: _.playerUIParams.showCenterVolumeAndBrightnessUI ? 1 : 0,
            child: Container(
              child: _playerGetxController.playerUIParams.centerVolumeAndBrightnessUI,),
          ),
        ),),

      ],
    );
  }
}


class HorizontalScreenUI extends StatefulWidget {
  const HorizontalScreenUI({Key? key}) : super(key: key);

  @override
  State<HorizontalScreenUI> createState() => _HorizontalScreenUIState();
}

class _HorizontalScreenUIState extends State<HorizontalScreenUI> {
  final PlayerGetxController _playerGetxController = Get.find<PlayerGetxController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 弹幕
        // 顶部
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: GestureDetector(
              onTap: () {
                print("点击了顶部UI");
                if (_playerGetxController.playerUIParams.showTopUI) {
                  _playerGetxController.cancelAndRestartTimer();
                }
              },
              child: const PlayerTopUI()
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
                  if (_playerGetxController.playerUIParams.showBottomUI) {
                    _playerGetxController.cancelAndRestartTimer();
                  }
                },
                child: const PlayerBottomUI()),
        ),
        // 中间UI
        Center(child: GetBuilder<PlayerGetxController>(
          id: GetxUpdateId.centerUI,
          builder: (_) => Opacity(
            opacity: _.playerUIParams.showCenterUI ? 1 : 0,
            child: Container(
              child: _playerGetxController.playerUIParams.centerUI,),
          ),
        ),),


        // 设置UI
        Positioned(top: 0, right: 0, bottom: 0, child: GetBuilder<PlayerGetxController>(
          id: GetxUpdateId.settingUI,
          builder: (_) => AnimatedSlide(
            offset: _.playerUIParams.showSettingUI
                ? const Offset(0, 0)
                : const Offset(1, 0),
            duration: UIData.uiShowAnimationDuration,
            child: Container(
              child: _playerGetxController.playerUIParams.settingUI,),
          ),
        ))
      ],
    );
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