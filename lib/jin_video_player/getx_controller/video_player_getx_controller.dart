
import 'package:get/get.dart';

import '../config/video_player_params.dart';
abstract class UpdateId {
  static String playerView = "playerView";
  static String videoHasError = "videoHasError";
  static String playProgress = "playProgress";
  static String positionDuration = "positionDuration";
  static String duration = "duration";
  static String playPauseBtn = "playPauseBtn";
  static String haveUIShow = "haveUIShow";
  static String topBarUI = "topBarUI";
  static String centerUI = "centerUI";
  static String bottomBarUI = "bottomBarUI";
  static String playSpeedSetting = "playSpeedSetting";
  static String videoChapterList = "videoChapterList";
  static String playSpeed = "playSpeed";
  static String videoChapterNormalLayout = "videoChapterNormalLayout";
  static String videoChapterGridViewLayout = "videoChapterGridViewLayout";
  static String showDanmakuBtn = "showDanmakuBtn";
  static String danmakuSetting = "danmakuSetting";
  static String danmakuSpeedSetting = "danmakuSpeedSetting";
  static String danmakuFontSizeSetting = "danmakuFontSizeSetting";
  static String displayAreaSetting = "displayAreaSetting";
  static String danmakuAlphaSetting = "danmakuAlphaSetting";
  static String duplicateMergingEnabled = "duplicateMergingEnabled";
  static String fixedTopDanmakuVisibility = "fixedTopDanmakuVisibility";
  static String rollDanmakuVisibility = "rollDanmakuVisibility";
  static String fixedBottomDanmakuVisibility = "fixedBottomDanmakuVisibility";
  static String colorsDanmakuVisibility = "colorsDanmakuVisibility";
  static String danmakuAdjustTime = "danmakuAdjustTime";
  static String openDanmakuShieldingWord = "openDanmakuShieldingWord";
  static String danmakuSourceSetting = "danmakuSourceSetting";

}

class VideoPlayerGetxController extends GetxController {
  late VideoPlayerParams videoPlayerParams;
  late IVideoPlayerMethod videoPlayerMethod;

  /// 是否可以改变全屏状态（默认进去全屏播放时不能修改 进入/退出全屏）
  bool canChangeFullScreenState = true;

  @override
  void onInit() {
    super.onInit();
    videoPlayerParams = VideoPlayerParams();
    videoPlayerParams.isFullScreen = true;
  }

  /// 设置视频信息
  void setVideoInfo({required String videoUrl,
    String? cover,
    bool? autoPlay,
    bool? looping,
    bool? fullScreenPlay,
    double? aspectRatio,
  }) {
    videoPlayerParams.videoUrl = videoUrl;
    if (cover != null) {
      videoPlayerParams.cover = cover;
    }
    if (autoPlay != null) {
      videoPlayerParams.autoPlay = autoPlay;
    }
    if (looping != null) {
      videoPlayerParams.looping = looping;
    }
    if (aspectRatio != null) {
      videoPlayerParams.aspectRatio = aspectRatio;
    }
    if (fullScreenPlay != null) {
      videoPlayerParams.fullScreenPlay = fullScreenPlay;
    }
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
      if (videoPlayerParams.autoPlay) {
        play();
      }
    });
  }

  /// 销毁播放器
  Future<void> disposePlayer() async {
    await videoPlayerMethod.onDisposePlayer();
  }

  /// 修改播放地址
  void changeVideoUrl(String newVideoUrl)  {
    if (videoPlayerParams.videoUrl == newVideoUrl) {
      return;
    }
    videoPlayerParams.videoUrl = newVideoUrl;
    videoPlayerMethod.changeVideoUrl(autoPlay: true);
  }

  /// 更新视频状态
  void updateVideoState(VideoPlayerInfo value) {
    videoPlayerParams.hasError = false;
    videoPlayerParams.errorWidget = null;
    videoPlayerParams.isInitialized = value.isInitialized; // 记录初始化状态
    videoPlayerParams.duration = value.duration; // 记录视频时长
    videoPlayerParams.positionDuration = value.positionDuration; // 记录当前播放位置
    videoPlayerParams.isPlaying = value.isPlaying; // 记录当前是否播放
    videoPlayerParams.bufferedDurationRange.clear();
    videoPlayerParams.bufferedDurationRange.addAll(value.bufferedDurationRange);
    videoPlayerParams.isFinished = value.isFinished;
    update([UpdateId.videoHasError,
        UpdateId.playProgress,
        UpdateId.positionDuration,
        UpdateId.duration, value.isFinished ? UpdateId.playPauseBtn : ""]);
  }

  /// 初始化
  Future<void> initialize() async {
    videoPlayerMethod.initialize().then((value) {
      videoPlayerParams.isInitialized = true;
    });
  }

  /// 播放
  Future<void> play() async {
    videoPlayerMethod.play().then((value) {
      videoPlayerParams.isPlaying = true;
      update([UpdateId.playPauseBtn]);
    });

  }

  /// 暂停
  Future<void> pause() async {
    videoPlayerMethod.pause().then((value) {
      videoPlayerParams.isPlaying = false;
      update([UpdateId.playPauseBtn]);
    });
  }

  /// 视频跳转
  Future<void> seekTo(Duration position) async {
    videoPlayerMethod.seekTo(position).then((value) {

    });
  }

  /// 暂停或播放
  Future<void> playOrPause() async {
    if (videoPlayerParams.isFinished) {
      await seekTo(Duration.zero);
    }
    if (videoPlayerParams.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  /// 改变顶部和底部UI显示状态
  void changeShowTopAndBottomUIState(bool flag) {
    bool haveChange = videoPlayerParams.showTopUI != flag && videoPlayerParams.showBottomUI != flag;
    videoPlayerParams.showTopUI = flag;
    videoPlayerParams.showBottomUI = flag;
    if (haveChange) {
      update([UpdateId.haveUIShow, UpdateId.topBarUI, UpdateId.bottomBarUI]);
    }
  }

  /// 改变顶部UI显示状态
  void changeShowTopUIState(bool flag) {
    bool haveChange = videoPlayerParams.showTopUI != flag;
    videoPlayerParams.showTopUI = flag;
    if (haveChange) {
      update([UpdateId.haveUIShow, UpdateId.topBarUI]);
    }
  }
  /// 改变中间UI显示状态
  void changeShowCenterUIState(bool flag) {
    bool haveChange = videoPlayerParams.showCenterUI != flag;
    videoPlayerParams.showCenterUI = flag;
    if (haveChange) {
      update([UpdateId.haveUIShow, UpdateId.centerUI]);
    }
  }
  /// 改变底部UI显示状态
  void changeShowBottomUIState(bool flag) {
    bool haveChange = videoPlayerParams.showBottomUI != flag;
    videoPlayerParams.showBottomUI = flag;
    if (haveChange) {
      update([UpdateId.haveUIShow, UpdateId.bottomBarUI]);
    }
  }

  /// 是否有UI显示
  bool haveUIShow() {
    return videoPlayerParams.showTopUI ||
        videoPlayerParams.showCenterUI  ||
        videoPlayerParams.showBottomUI;
  }

  /// 隐藏所有UI
  void hideAllUI() {
    List<String> updateIds = [UpdateId.haveUIShow];
    if (videoPlayerParams.showTopUI) {
      updateIds.add(UpdateId.topBarUI);
    }
    if (videoPlayerParams.showCenterUI) {
      updateIds.add(UpdateId.centerUI);
    }
    if (videoPlayerParams.showBottomUI) {
      updateIds.add(UpdateId.bottomBarUI);
    }

    videoPlayerParams.showTopUI = false;
    videoPlayerParams.showCenterUI = false;
    videoPlayerParams.showBottomUI = false;
    update(updateIds);
  }

}