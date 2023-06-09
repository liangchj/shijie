
import 'package:flutter/material.dart';

import '../player_progress_bar.dart';
import 'video_player_config.dart';

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

  // 设置
  // 播放速度： ['0.5x', '0.75x', '1.0x', '1.25x', '1.5x', '1.75x', '2.0x']
  double playSpeed = 1.0;

  // 视频章节列表
  var videoChapterList = <Map<String, dynamic>>[];
  var maxVideoNameLen = 0;
  var playVideoChapter = "";

  Widget? danmakuUI;
  bool showDanmaku = false;
  Function? showDanmakuSetting; // 显示弹幕设置方法
  Function? showDanmakuSourceSetting; // 显示设置弹幕源

  // 弹幕设置
  int danmakuAlphaRatio = VideoPlayerConfig.danmakuAlphaRatio; // 不透明度
  // 显示区域["1/4屏", "半屏", "3/4屏", "不重叠", "无限"]，选择下标，默认半屏（下标1）
  int danmakuDisplayAreaIndex = VideoPlayerConfig.danmakuDisplayAreaIndex; // 显示区域
  // 区间[20, 100]， 默认20
  int danmakuFontSizeRatio = VideoPlayerConfig.danmakuFontSizeRatio;
  // 弹幕播放速度["极慢", "较慢", "正常", "较快", "极快"], 选择许下标， 默认正常（下标2）
  int danmakuSpeedIndex = VideoPlayerConfig.danmakuSpeedIndex;

  // 弹幕屏蔽类型
  bool duplicateMergingEnabled =
      VideoPlayerConfig.duplicateMergingEnabled; // 是否合并重复
  bool fixedTopDanmakuVisibility = VideoPlayerConfig.fixedTopDanmakuVisibility; // 顶部是否显示
  bool fixedBottomDanmakuVisibility =
      VideoPlayerConfig.fixedBottomDanmakuVisibility; // 底部是否显示
  bool rollDanmakuVisibility = VideoPlayerConfig.rollDanmakuVisibility; // 滚动是否显示
  bool colorsDanmakuVisibility =
      VideoPlayerConfig.colorsDanmakuVisibility; // 彩色是否显示
  bool specialDanmakuVisibility =
      VideoPlayerConfig.specialDanmakuVisibility; // 特殊弹幕是否显示

  // 弹幕调整时间(秒)
  double danmakuAdjustTime = 0.0;

  // 开启屏蔽词
  bool openDanmakuShieldingWord = VideoPlayerConfig.openDanmakuShieldingWord;

  Function? setDanmakuSpeed; // 修改弹幕速度方法
  Function? setDanmakuScaleTextSize; // 修改弹幕字体大小方法
  Function? setDanmakuDisplayArea; // 修改弹幕显示区域方法
  Function? setDanmakuAlphaRatio; // 修改弹幕不透明度方法
  Function? setDuplicateMergingEnabled; // 修改弹幕重复方法
  Function? setFixedTopDanmakuVisibility; // 修改是否显示顶部弹幕方法
  Function? setRollDanmakuVisibility; // 修改是否显示滚动弹幕方法
  Function? setFixedBottomDanmakuVisibility; // 修改是否显示底部弹幕方法
  Function? setColorsDanmakuVisibility; // 修改是否显示彩色弹幕方法
  Function? danmakuSeekTo; // 弹幕跳转

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
