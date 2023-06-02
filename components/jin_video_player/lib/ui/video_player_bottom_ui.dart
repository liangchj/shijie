import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jin_video_player/getx_controller/video_player_getx_controller.dart';
import 'package:jin_video_player/player_progress_bar.dart';
import 'package:jin_video_player/ui/video_player_ui.dart';
import 'package:jin_video_player/utils/format_utils.dart';

/// 播放器底部UI
class VideoPlayerBottomUI extends StatefulWidget {
  const VideoPlayerBottomUI({Key? key, this.hideTimer, required this.startHideTimer}) : super(key: key);
  final Timer? hideTimer;
  final Function startHideTimer;

  @override
  State<VideoPlayerBottomUI> createState() => _VideoPlayerBottomUIState();
}

class _VideoPlayerBottomUIState extends State<VideoPlayerBottomUI> {
  Timer? get _hideTimer => widget.hideTimer;
  Function get _startHideTimer => widget.startHideTimer;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.bottomBarUI,
        builder: (_) {
          print("更新bottom");
          return _.videoPlayerParams.isFullScreen ? _buildHorizontalScreenBottomUI(_) : _buildVerticalScreenBottomUI(_);
        });
  }
  /// 竖屏底部UI
  Widget _buildVerticalScreenBottomUI(VideoPlayerGetxController _) {
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
              // 全屏按钮
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.fullscreen_rounded,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
      secondChild: Container(),
      crossFadeState: _.videoPlayerParams.showBottomUI ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
  /// 横屏底部UI
  Widget _buildHorizontalScreenBottomUI(_) {
    return AnimatedSlide(
        offset: _.videoPlayerParams.showBottomUI
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
                      if (_.videoPlayerParams.videoChapterList.isNotEmpty)
                        // 下一个视频
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              color: Colors.white,
                            )),
                      Expanded(child: Container()),
                      if (_.videoPlayerParams.videoChapterList.isNotEmpty)
                        // 选集
                        TextButton(
                          onPressed: () {
                            _hideTimer?.cancel();
                            _.hideAllUI();
                            _.changeShowVideoChapterListState(true);
                          },
                          child: const Text("选集", style: TextStyle(color: Colors.white)),
                        ),

                      // 倍数
                      TextButton(
                        onPressed: () {
                          _hideTimer?.cancel();
                          _.hideAllUI();
                          _.changeShowPlaySpeedSettingState(true);
                        },
                        child: const Text("倍数", style: TextStyle(color: Colors.white)),
                      ),

                      // 视频清晰度
                      TextButton(
                        onPressed: () {
                          _hideTimer?.cancel();
                        },
                        child: const Text("高清", style: TextStyle(color: Colors.white)),
                      ),
                      // if (_.videoPlayerParams.canChangeFullScreenState)
                        IconButton(
                            onPressed: () {},
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
    return GetBuilder<VideoPlayerGetxController>(
      id: UpdateId.playPauseBtn,
      builder: (_) {
        print("更新播放按钮");
        var isFinished = _.videoPlayerParams.isFinished;
        var isPlaying = _.videoPlayerParams.isPlaying;
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
      child: GetBuilder<VideoPlayerGetxController>(
          id: UpdateId.positionDuration,
          builder: (_) => Text(durationToMinuteAndSecond(
              _.videoPlayerParams.positionDuration))),
    );
  }

  /// 总时长
  Widget _buildTotalDuration({EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(
          horizontal: 15),
      child: GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.duration,
        builder: (_) => Text(
            durationToMinuteAndSecond(
                _.videoPlayerParams.duration)),
      ),
    );
  }

  /// 进度条
  Widget _buildProgressBar() {
    return Expanded(
      child: GetBuilder<VideoPlayerGetxController>(
          id: UpdateId.playProgress,
          builder: (_) {
            if (!_.videoPlayerParams.showBottomUI) {
              return Container();
            }
            print("播放进度：${_.videoPlayerParams.positionDuration}");
            return AbsorbPointer(
              absorbing: !_.videoPlayerParams.isInitialized,
              child: PlayerProgressBar(
                progress: _.videoPlayerParams.positionDuration,
                totalDuration: _.videoPlayerParams.duration,
                bufferedDurationRange: _.videoPlayerParams.bufferedDurationRange,
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
                  _hideTimer?.cancel();
                  _.videoPlayerParams.isDragging = true;
                },
                onChangeEnd: (details) {
                  print("进度条改变结束");
                  if (_.videoPlayerParams.isPlaying) {
                    _.pause();
                    _.videoPlayerParams.beforeSeekIsPlaying = true;
                  } else {
                    _.videoPlayerParams.beforeSeekIsPlaying = false;
                  }
                  _.videoPlayerParams.isDragging = false;
                },
                onChanged: (details) {
                  print("进度条改变事件");
                },
                onSeek: (details) async {
                  await _
                      .seekTo(details.currentDuration)
                      .then((value) async {
                    if (_.videoPlayerParams.beforeSeekIsPlaying) {
                      await _.play();
                    }
                  });
                  _startHideTimer();
                },
              ),
            );
          }),
    );
  }

}
