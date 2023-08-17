
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/getx_update_id.dart';
import '../controller/player_controller.dart';
import '../data/ui_data.dart';
import '../utils/format_utils.dart';
import '../utils/my_icons_utils.dart';
import 'danmaku_setting_ui.dart';
import 'danmaku_source_setting_ui.dart';
import 'play_speed_ui.dart';
import 'player_progress_bar.dart';
import 'video_chapter_list_ui.dart';
/// 播放器底部UI
class PlayerBottomUI extends StatefulWidget {
  const PlayerBottomUI({Key? key}) : super(key: key);

  @override
  State<PlayerBottomUI> createState() => _PlayerBottomUIState();
}

class _PlayerBottomUIState extends State<PlayerBottomUI> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.bottomBarUI,
        builder: (_) {
          print("更新bottom");
          return _.playerParams.fullScreenPlay ? _buildHorizontalScreenBottomUI(_) : _buildVerticalScreenBottomUI(_);
        });
  }

  /// 竖屏底部UI
  Widget _buildVerticalScreenBottomUI(PlayerGetxController _) {
    return AnimatedCrossFade(
      duration: UIData.uiShowAnimationDuration,
      firstChild: Container(
        padding: const EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
          // 渐变颜色（上下至上）
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: UIData.gradientBackground)),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 播放/暂停按钮
              _buildPlayPause(),
              // 下一个视频按钮
              IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    color: Colors.white,
                  )),
              // 播放时长
              _buildPlayPositionDuration(),
              // 进度条
              _buildProgressBar(),
              // 总时长
              _buildTotalDuration(),
              if (!_.playerParams.onlyFullScreen)
                // 全屏按钮
                IconButton(
                    onPressed: () {
                      _.playerParams.fullScreenPlay = true;
                      _.entryOrExitFullScreen();
                    },
                    icon: const Icon(
                      Icons.fullscreen_rounded,
                      color: Colors.white,
                    )),
            ],
          ),
        ),
      ),
      secondChild: Container(),
      crossFadeState: _.playerUIParams.showBottomUI ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
  /// 横屏底部UI
  Widget _buildHorizontalScreenBottomUI(PlayerGetxController _) {
    return AnimatedSlide(
        offset: _.playerUIParams.showBottomUI
            ? const Offset(0, 0)
            : const Offset(0, 1),
        duration: UIData.uiShowAnimationDuration,
        child: Container(
          padding: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            // 渐变颜色（上下至上）
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: UIData.gradientBackground)),
          child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 播放时长
                      _buildPlayPositionDuration(),
                      // 进度条
                      _buildProgressBar(),
                      // 总时长
                      _buildTotalDuration(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPlayPause(),
                      if (_.videoInfoParams.videoChapterList.isNotEmpty)
                      // 下一个视频
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              color: Colors.white,
                            )),
                      // 弹幕开关
                      GetBuilder<PlayerGetxController>(
                          id: GetxUpdateId.showDanmakuBtn,
                          builder: (_) => IconButton(
                              onPressed: () {
                                _.danmakuParams.showDanmaku = !_.danmakuParams.showDanmaku;
                                _.update([GetxUpdateId.showDanmakuBtn]);
                              },
                              icon: _.danmakuParams.showDanmaku
                                  ? const Icon(
                                  MyIconsUtils.danmakuOpen,
                                  color: Colors.redAccent)
                                  : const Icon(
                                  MyIconsUtils.danmakuClose,
                                  color: Colors.white))),
                      // 弹幕源
                      TextButton(
                        onPressed: () => _.showAndChangeSettingUI(const DanmakuSourceSettingUI(isFullScreen: true,)),
                        child: const Text(
                          "A",
                        ),
                      ),
                      // 弹幕设置
                      IconButton(
                          onPressed: () => _.showAndChangeSettingUI(const DanmakuSettingUI(isFullScreen: true,)),
                          icon: const Icon(
                            MyIconsUtils.danmakuSetting,
                            color: Colors.white,
                          )),
                      Expanded(child: Container()),
                      if (_.videoInfoParams.videoChapterList.isNotEmpty)
                      // 选集
                        TextButton(
                          onPressed: () => _.showAndChangeSettingUI(const VideoChapterListUI()),
                          child: const Text("选集", style: TextStyle(color: Colors.white)),
                        ),

                      // 倍数
                      TextButton(
                        onPressed: () => _.showAndChangeSettingUI(const PlaySpeedUI(isFullScreen: true,)),
                        child: const Text("倍数", style: TextStyle(color: Colors.white)),
                      ),

                      // 视频清晰度
                      TextButton(
                        onPressed: () {
                          _.cancelHideTimer();
                        },
                        child: const Text("高清", style: TextStyle(color: Colors.white)),
                      ),
                      if (!_.playerParams.onlyFullScreen)
                        IconButton(
                            onPressed: () {
                              _.playerParams.fullScreenPlay = false;
                              _.entryOrExitFullScreen();
                            },
                            icon: const Icon(
                              Icons.fullscreen_exit_rounded,
                              color: Colors.white,
                            )),
                    ],
                  )
                ],
              )),

        ));
  }

  /// 播放、暂停按钮
  Widget _buildPlayPause({double? size}) {
    return GetBuilder<PlayerGetxController>(
      id: GetxUpdateId.playPauseBtn,
      builder: (_) {
        print("更新播放按钮");
        var isFinished = _.playerParams.isFinished;
        var isPlaying = _.playerParams.isPlaying;
        return IconButton(
          onPressed: () => _.playOrPause(),
          icon: Icon(
            isFinished
                ? Icons.replay_rounded
                : (isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
            size: size,
            color: Colors.white,
          ),
        );
      },
    );
  }

  /// 播放时长位置
  Widget _buildPlayPositionDuration({EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(
          horizontal: 15),
      child: GetBuilder<PlayerGetxController>(
          id: GetxUpdateId.positionDuration,
          builder: (_) => Text(durationToMinuteAndSecond(
              _.playerParams.positionDuration))),
    );
  }

  /// 总时长
  Widget _buildTotalDuration({EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(
          horizontal: 15),
      child: GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.duration,
        builder: (_) => Text(
            durationToMinuteAndSecond(
                _.videoInfoParams.duration)),
      ),
    );
  }

  /// 进度条
  Widget _buildProgressBar() {
    return Expanded(
      child: GetBuilder<PlayerGetxController>(
          id: GetxUpdateId.playProgress,
          builder: (_) {
            if (!_.playerUIParams.showBottomUI) {
              return Container();
            }
            print("播放进度：${_.playerParams.positionDuration}");
            return AbsorbPointer(
              absorbing: !_.playerParams.isInitialized,
              child: PlayerProgressBar(
                progress: _.playerParams.positionDuration,
                totalDuration: _.videoInfoParams.duration,
                bufferedDurationRange: _.playerParams.bufferedDurationRange,
                barHeight: 4.0,
                thumbShape: ProgressBarThumbShape(
                    thumbColor: Colors.redAccent,
                    thumbRadius: 8.0,
                    thumbInnerColor: Colors.white,
                    thumbInnerRadius: 3.0),
                thumbOverlayColor: Colors.redAccent.withOpacity(0.24),
                thumbOverlayShape: ProgressBarThumbOverlayShape(
                    thumbOverlayColor: Colors.redAccent.withOpacity(0.5),
                    thumbOverlayRadius: 16.0),
                onChangeStart: (details) {
                  print("进度条改变开始");
                  _.cancelAndRestartTimer();
                  _.playerParams.isDragging = true;
                },
                onChangeEnd: (details) {
                  print("进度条改变结束");
                  if (_.playerParams.isPlaying) {
                    _.pause();
                    _.playerParams.beforeSeekIsPlaying = true;
                  } else {
                    _.playerParams.beforeSeekIsPlaying = false;
                  }
                  _.playerParams.isDragging = false;
                },
                onChanged: (details) {
                  print("进度条改变事件");
                },
                onSeek: (details) async {
                  await _
                      .seekTo(details.currentDuration)
                      .then((value) async {
                    if (_.playerParams.beforeSeekIsPlaying) {
                      await _.play();
                    }
                  });
                  _.startHideTimer();
                },
              ),
            );
          }),
    );
  }
}
