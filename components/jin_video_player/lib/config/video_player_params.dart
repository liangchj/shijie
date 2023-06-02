
import 'package:flutter/material.dart';
import 'package:jin_video_player/config/video_player_config.dart';
import 'package:jin_video_player/player_progress_bar.dart';

enum VideoPlayerType { fijkplayer, flutterPlayer }

enum SourceType { net, asset }

/// 播放器参数
class VideoPlayerParams {
  // 播放器
  Widget? videoPlayerView;
  String videoUrl = ""; // 视频播放路径
  String? cover; // 视频封面
  String? danmakuUrl; // 弹幕地址
  String? subtitlePath; // 字幕地址
  bool looping = VideoPlayerConfig.looping; // 循环播放
  bool autoPlay = VideoPlayerConfig.autoPlay;
  double aspectRatio = VideoPlayerConfig.aspectRatio; // 播放器比例

  // 全屏播放
  bool fullScreenPlay = VideoPlayerConfig.fullScreenPlay;

  // 视频信息
  bool hasError = false; // 有错误信息
  Widget? errorWidget; // 错误显示图标

  Duration duration = Duration.zero; // 总时长
  Duration positionDuration = Duration.zero; // 当前播放时长
  List<BufferedDurationRange> bufferedDurationRange = []; // 缓冲区间列表

  bool isInitialized = false; // 视频已初始化
  bool isPlaying = false; // 视频播放中
  bool beforeSeekIsPlaying = false; // 拖动进度时播放状态
  bool isBuffering = false; // 缓冲中
  bool isSeeking = false; // 进度跳转中
  bool isDragging = false; // 拖动中
  bool isFinished = false; // 播放结束
  bool isFullScreen = false; // 是否全屏

  // UI 部分
  bool showTopUI = false; // 显示顶部UI
  bool showCenterUI = false; // 显示顶部UI
  bool showBottomUI = false; // 显示底部UI
  bool showPlaySpeedSetting = false; // 显示播放速度设置
  bool showVideoChapterList = false; // 显示视频章节列表

  // 设置
  // 播放速度： ['0.5x', '0.75x', '1.0x', '1.25x', '1.5x', '1.75x', '2.0x']
  double playSpeed = 1.0;

  // 视频章节列表
  var videoChapterList = <Map<String, dynamic>>[];
  var maxVideoNameLen = 0;
  var playVideoChapter = "";

}


/// 播放器方法
abstract class IVideoPlayerMethod {
  /// 播放器初始化
  Future<void> onInitPlayer();

  /// 销毁播放器
  Future<void> onDisposePlayer();

  /// 更新状态信息
  void updateState();

  void changeVideoUrl({bool autoPlay = false});

  Future<void> initialize();
  Future<void> play();
  Future<void> pause();
  Future<void> entryFullScreen();
  Future<void> exitFullScreen();
  Future<void> seekTo(Duration position);
  Future<void> setPlaybackSpeed(double speed);
}

class VideoPlayerInfo {
  const VideoPlayerInfo(
      {required this.isInitialized,
        required this.isPlaying,
        required this.duration,
        required this.positionDuration,
        required this.bufferedDurationRange,
        required this.isFinished});
  final bool isInitialized;
  final bool isPlaying;
  final Duration duration;
  final Duration positionDuration;
  final List<BufferedDurationRange> bufferedDurationRange;
  final bool isFinished;
}
