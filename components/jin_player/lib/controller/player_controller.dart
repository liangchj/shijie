
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:volume_controller/volume_controller.dart';

import '../config/danmaku_params.dart';
import '../config/getx_update_id.dart';
import '../config/player_params.dart';
import '../config/player_ui_params.dart';
import '../config/video_info_params.dart';
import '../control_method/abstract_method.dart';
import '../control_method/abstract_player_method.dart';
import '../data/ui_data.dart';
import '../jin_player_view.dart';
import '../ui/brightness_ui.dart';
import '../ui/drag_play_progress_ui.dart';
import '../ui/volume_ui.dart';
import 'danmaku_control.dart';

class PlayerGetxController extends GetxController {
  late IVideoPlayerMethod videoPlayerMethod;
  late PlayerParams playerParams;
  late PlayerUIParams playerUIParams;
  late VideoInfoParams videoInfoParams;
  late DanmakuParams danmakuParams;
  late DanmakuControl danmakuControl;

  Function(DanmakuEnum danmakuEnum, {dynamic params})? danmakuFn;

  Timer? _hideTimer;

  bool rotateScreenIng = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("ui控制器初始化");
    playerParams = PlayerParams();
    playerUIParams = PlayerUIParams();
    videoInfoParams = VideoInfoParams();
    danmakuParams = DanmakuParams();
    VolumeController().showSystemUI = false;
    VolumeController().getVolume().then((value) => playerParams.volume = (value * 100).floor());

    VolumeController().listener((volume) => listenerSystemVolume);

    ScreenBrightness().current.then((value) => playerParams.brightness = (value * 100).floor());

    danmakuControl = DanmakuControl(this);
  }

  /// 监听系统音量
  void listenerSystemVolume(double volume) {
    int v = (volume * 100).floor();
    if (v != playerParams.volume) {
      playerParams.volume = v;
      videoPlayerMethod.setVolume(volume);
    }
  }



  @override
  void dispose() {
    VolumeController().removeListener();
    _hideTimer?.cancel();
    print("player ui 控制器销毁");
    // TODO: implement dispose
    super.dispose();
  }

  /// 设置视频信息
  void setVideoInfo({required String videoUrl,
    String? cover,
    bool? autoPlay,
    bool? looping,
    bool? onlyFullScreen,
    double? aspectRatio,
    Function(DanmakuEnum danmakuEnum, {dynamic params})? danmakuFn
  }) {
    videoInfoParams.videoUrl = videoUrl;
    if (cover != null) {
      videoInfoParams.cover = cover;
    }
    if (autoPlay != null) {
      playerParams.autoPlay = autoPlay;
    }
    if (looping != null) {
      playerParams.looping = looping;
    }
    if (aspectRatio != null) {
      playerParams.aspectRatio = aspectRatio;
    }
    if (onlyFullScreen != null) {
      playerParams.onlyFullScreen = onlyFullScreen;
      if (onlyFullScreen) {
        playerParams.fullScreenPlay = true;
      }
    } else {
      playerParams.onlyFullScreen = playerParams.fullScreenPlay;
    }

    if (danmakuFn != null) {
      this.danmakuFn = danmakuFn;
    }

    danmakuControl.clearDanmakuUI();
    // danmakuParams.danmakuUrl = DanmakuMMKVCache.getInstance().getString(CacheConstant.cachePrev + videoUrl) ?? "";
  }
  @override
  void onClose() {
    super.onClose();
    if (videoPlayerMethod != null) {
      try {
        videoPlayerMethod.onDisposePlayer();
      } catch (e) {
        rethrow;
      }
    }
  }

  /// 播放器初始化
  void initPlayer(IVideoPlayerMethod method) {
    videoPlayerMethod = method;
    videoPlayerMethod.onInitPlayer().then((value) {
      if (playerParams.autoPlay) {
        // play();
      }
    });
  }

  /// 销毁播放器
  Future<void> disposePlayer() async {
    await videoPlayerMethod.onDisposePlayer();
  }

  /// 修改播放地址
  void changeVideoUrl(String newVideoUrl)  {
    if (videoInfoParams.videoUrl == newVideoUrl) {
      return;
    }
    videoInfoParams.videoUrl = newVideoUrl;
    videoPlayerMethod.changeVideoUrl(autoPlay: true);
  }

  /// 更新视频状态
  void updateVideoState(VideoPlayerInfo value) {
    playerParams.hasError = false;
    playerParams.errorMsg = null;
    playerParams.isInitialized = value.isInitialized; // 记录初始化状态
    videoInfoParams.duration = value.duration; // 记录视频时长
    playerParams.positionDuration = value.positionDuration; // 记录当前播放位置
    playerParams.isPlaying = value.isPlaying; // 记录当前是否播放
    playerParams.bufferedDurationRange.clear();
    playerParams.bufferedDurationRange.addAll(value.bufferedDurationRange);
    playerParams.isFinished = value.isFinished;
    update([GetxUpdateId.videoHasError,
      GetxUpdateId.playProgress,
      GetxUpdateId.positionDuration,
      GetxUpdateId.duration, value.isFinished ? GetxUpdateId.playPauseBtn : ""]);
  }
  // 加载视频失败
  void loadError(String? errorMsg) {
    playerParams.isInitialized = false;
    playerParams.isPlaying = false;
    playerParams.isSeeking = false;
    playerParams.isBuffering = false;
    playerParams.isFinished = false;

    playerParams.hasError = true;
    playerParams.errorMsg = errorMsg;
    playerUIParams.centerUI = Center(
      child: Text(errorMsg ?? "加载失败", style: const TextStyle(color: Colors.white),),
    );
    playerUIParams.showCenterUI = true;
    update([GetxUpdateId.centerUI]);
  }

  /// 初始化
  Future<void> initialize() async {
    videoPlayerMethod.initialize().then((value) {
      playerParams.isInitialized = true;
    });
  }

  /// 播放
  Future<void> play() async {
    /*videoPlayerMethod.play().then((value) {
      playerParams.isPlaying = true;
      danmakuControl.startDanmaku();
      update([GetxUpdateId.playPauseBtn]);
    });*/
    danmakuControl.startDanmaku();
  }

  /// 暂停
  Future<void> pause() async {
    videoPlayerMethod.pause().then((value) {
      playerParams.isPlaying = false;
      update([GetxUpdateId.playPauseBtn]);
    });
  }

  /// 视频跳转
  Future<void> seekTo(Duration position) async {
    videoPlayerMethod.seekTo(position).then((value) {

    });
  }

  /// 暂停或播放
  Future<void> playOrPause() async {
    if (playerParams.isFinished) {
      await seekTo(Duration.zero);
    }
    if (playerParams.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  /// 清除定时器
  void cancelHideTimer() {
    _hideTimer?.cancel();
  }

  /// 开始计时UI显示时间
  void startHideTimer() {
    _hideTimer = Timer(UIData.uiShowDuration, () {
      changeShowTopAndBottomUIState(false);
    });
  }

  /// 重新计算显示/隐藏UI计时器
  void cancelAndRestartTimer() {
    print("重新计算显示/隐藏UI计时器");
    cancelHideTimer();
    startHideTimer();
    changeShowTopAndBottomUIState(true);
  }

  /// 点击背景
  void toggleBackground() {
    print("点击背景");
    if (haveUIShow()) {
      hideAllUI();
    } else {
      cancelAndRestartTimer();
    }
  }

  /// 改变顶部和底部UI显示状态
  void changeShowTopAndBottomUIState(bool flag) {
    bool haveChange = playerUIParams.showTopUI != flag && playerUIParams.showBottomUI != flag;
    playerUIParams.showTopUI = flag;
    playerUIParams.showBottomUI = flag;
    if (haveChange) {
      update([GetxUpdateId.topBarUI, GetxUpdateId.bottomBarUI]);
    }
  }

  /// 是否有UI显示
  bool haveUIShow() {
    return playerUIParams.showTopUI ||
        playerUIParams.showCenterUI  ||
        playerUIParams.showBottomUI ||
        playerUIParams.showSettingUI
    ;
  }

  /// 隐藏所有UI
  void hideAllUI() {
    List<String> updateIds = [];
    if (playerUIParams.showTopUI) {
      playerUIParams.showTopUI = false;
      updateIds.add(GetxUpdateId.topBarUI);
    }
    if (playerUIParams.showCenterUI) {
      playerUIParams.showCenterUI = false;
      updateIds.add(GetxUpdateId.centerUI);
    }
    if (playerUIParams.showBottomUI) {
      playerUIParams.showBottomUI = false;
      updateIds.add(GetxUpdateId.bottomBarUI);
    }
    if (playerUIParams.showSettingUI) {
      playerUIParams.showSettingUI = false;
      updateIds.add(GetxUpdateId.settingUI);
    }
    if (updateIds.isNotEmpty) {
      update(updateIds);
    }
  }

  /// 显示和修改设置UI内容
  void showAndChangeSettingUI(Widget? ui) {
    /// 清除UI显示定时器
    cancelHideTimer();
    // 隐藏其他UI
    hideAllUI();
    playerUIParams.settingUI = ui;
    playerUIParams.showSettingUI = true;
    update([GetxUpdateId.settingUI]);
  }

  /// 开始拖动播放进度条
  void playProgressOnHorizontalDragStart() {
    if (!playerParams.isInitialized || playerParams.hasError) {
      return;
    }
    playerUIParams.centerUI = null;
    playerParams.isDragging = true;
    playerParams.draggingSecond = 0;
    playerParams.draggingSurplusSecond = 0.0; // 前一次滑动剩余值
    playerParams.dragProgressPositionDuration = playerParams.positionDuration;
    cancelHideTimer();

    update([GetxUpdateId.centerUI]);
  }

  /// 拖动播放进度条中
  void playProgressOnHorizontalDragUpdate(BuildContext context, Offset delta) {
    if (!playerParams.isInitialized || playerParams.hasError) {
      return;
    }
    double width = Get.size.width;
    double dragSecond = (delta.dx / width) * 100  + playerParams.draggingSurplusSecond;
    int dragValue = dragSecond.floor();
    playerParams.draggingSurplusSecond = dragSecond - dragValue; // 此次滑动剩余值
    playerParams.draggingSecond += dragValue;
    playerUIParams.centerUI = const DragPlayProgressUI();
    playerUIParams.showCenterUI = true;
    update([GetxUpdateId.centerUI]);
  }

  /// 拖动播放进度结束
  void playProgressOnHorizontalDragEnd() {
    if (!playerParams.isInitialized || playerParams.hasError) {
      return;
    }
    playerParams.isDragging = false;
    playerParams.draggingSurplusSecond = 0.0;
    var second = playerParams.dragProgressPositionDuration.inSeconds + playerParams.draggingSecond;
    seekTo(Duration(seconds: second > 0 ? second : 0));
    cancelAndRestartTimer();
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      playerUIParams.showCenterUI = false;
      playerUIParams.centerUI = null;
      playerParams.draggingSecond = 0;
      playerParams.dragProgressPositionDuration = Duration.zero;
      update([GetxUpdateId.centerUI]);
    });
  }

  /// 垂直滑动开始
  void volumeOrBrightnessOnVerticalDragStart(DragStartDetails details) {
    playerParams.brightnessDragging = false;
    playerParams.volumeDragging = false;
    double width = Get.size.width;
    if (details.globalPosition.dx > (width / 2)) {
      //BVUtils.volume.then((value) => playerParams.volume =  (value * 100).floor());
      VolumeController().getVolume().then((value) => playerParams.volume = (value * 100).floor());
      playerParams.volumeDragging = true;
    } else {
      // BVUtils.brightness.then((value) => playerParams.brightness =  (value * 100).floor());
      ScreenBrightness().current.then((value) => playerParams.brightness = (value * 100).floor());
      playerParams.brightnessDragging = true;
    }
    playerParams.verticalDragSurplus = 0.0; // 前一次滑动剩余值
    playerUIParams.showCenterVolumeAndBrightnessUI = false;
    playerUIParams.centerVolumeAndBrightnessUI = null;
    update([GetxUpdateId.centerVolumeAndBrightnessUI]);
  }
  /// 垂直滑动中
  void volumeOrBrightnessOnVerticalDragUpdate(BuildContext context, DragUpdateDetails details) {
    double height = Get.size.height;
    // 使用百分率
    // 当前拖动值
    double currentDragVal = (details.delta.dy / height) * 100;
    double totalDragValue = currentDragVal + playerParams.verticalDragSurplus;
    int dragValue = totalDragValue.floor();
    playerParams.verticalDragSurplus = totalDragValue - dragValue; // 此次滑动剩余值
    if (playerParams.volumeDragging) {
      // 设置音量
      playerParams.volume = (playerParams.volume - dragValue).clamp(0, 100);
      // BVUtils.setVolume(playerParams.volume / 100.0);
      VolumeController().setVolume(playerParams.volume / 100.0);
      playerUIParams.centerVolumeAndBrightnessUI = const VolumeUI();
    } else if (playerParams.brightnessDragging) {
      // 设置亮度
      playerParams.brightness = (playerParams.brightness - dragValue).clamp(0, 100);
      // BVUtils.setBrightness(playerParams.brightness / 100.0);
      ScreenBrightness().setScreenBrightness(playerParams.brightness / 100.0);
      playerUIParams.centerVolumeAndBrightnessUI = const BrightnessUI();
    }
    playerUIParams.showCenterVolumeAndBrightnessUI = true;
    update([GetxUpdateId.centerVolumeAndBrightnessUI]);
  }
  /// 垂直滑动结束
  void volumeOrBrightnessOnVerticalDragEnd() {
    playerParams.brightnessDragging = false;
    playerParams.volumeDragging = false;
    playerParams.verticalDragSurplus = 0.0;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      playerUIParams.showCenterVolumeAndBrightnessUI = false;
      playerUIParams.centerVolumeAndBrightnessUI = null;
      update([GetxUpdateId.centerVolumeAndBrightnessUI]);
    });
  }


  Future<void> entryOrExitFullScreen() async {
    if (playerParams.fullScreenPlay) {
      rotateScreenIng = true;
      cancelHideTimer();
      hideAllUI();

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]).then((value) {
        playerParams.fullScreenPlay = true;
        update([GetxUpdateId.videoPlayer, GetxUpdateId.showDanmakuBtn]);
        Get.to(const HorizontalScreenVideoPlayerView());
      });


    } else {
      rotateScreenIng = true;
      cancelHideTimer();
      hideAllUI();

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then((value) {
        playerParams.fullScreenPlay = false;
            update([GetxUpdateId.videoPlayer, GetxUpdateId.showDanmakuBtn]);
        Get.back();
      });

    }
  }
}
