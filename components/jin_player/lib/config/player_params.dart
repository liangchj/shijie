
import 'package:flutter/material.dart';

import '../control_method/abstract_method.dart';
import '../ui/player_progress_bar.dart';
import 'default_player_params.dart';

class PlayerParams {
  Widget? playerView;
  // 全屏播放
  bool fullScreenPlay = DefaultPlayerParams.fullScreenPlay;
  // 只有全屏播放，为true时，fullScreenPlay无效
  bool onlyFullScreen = true;


  bool looping = DefaultPlayerParams.looping; // 循环播放
  bool autoPlay = DefaultPlayerParams.autoPlay;
  double aspectRatio = DefaultPlayerParams.aspectRatio; // 播放器比例
  // 设置
  // 播放速度： ['0.5x', '0.75x', '1.0x', '1.25x', '1.5x', '1.75x', '2.0x']
  double playSpeed = 1.0;

  Duration dragProgressPositionDuration = Duration.zero; // 拖动进度时的播放位置
  int draggingSecond = 0; // 播放进度拖动秒数
  double draggingSurplusSecond = 0.0; // 前一次拖动剩余值（每次更新只获取整数部分更新，剩下的留给后面更新）

  double verticalDragSurplus = 0.0; // 纵向滑动剩余值（每次更新只获取整数部分更新，剩下的留给后面更新）

  int volume = 0; // 当前音量值（使用百分比）
  int brightness = 0; // 当前音量值（使用百分比）
  bool volumeDragging = false; // 音量拖动中
  bool brightnessDragging = false; // 亮度拖动中

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

  // 视频信息
  bool hasError = false; // 有错误信息
  String? errorMsg;


  IPlayerMethod? iPlayerMethod;
}