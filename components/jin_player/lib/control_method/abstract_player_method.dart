
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

  Future<void> setVolume(double volume);


}

abstract class IDanmakuMethod {
  Function setDanmakuSpeed(); // 修改弹幕速度方法
  Function setDanmakuScaleTextSize(); // 修改弹幕字体大小方法
  Function setDanmakuDisplayArea(); // 修改弹幕显示区域方法
  Function setDanmakuAlphaRatio(); // 修改弹幕不透明度方法
  Function setDuplicateMergingEnabled(); // 修改弹幕重复方法
  Function setFixedTopDanmakuVisibility(); // 修改是否显示顶部弹幕方法
  Function setRollDanmakuVisibility(); // 修改是否显示滚动弹幕方法
  Function setFixedBottomDanmakuVisibility(); // 修改是否显示底部弹幕方法
  Function setColorsDanmakuVisibility(); // 修改是否显示彩色弹幕方法
  Function danmakuSeekTo(); // 弹幕跳转
}