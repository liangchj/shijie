
class VideoPlayerConfig {
  static double aspectRatio = 16.0 / 9.0; // 播放器比例
  static bool autoPlay = false; // 自动播放
  static bool looping = false; // 循环播放

  // 全屏播放
  static bool fullScreenPlay = false;
  static bool isFullScreen = false;

  // 播放速度
  static double videoPlaySpeed = 1.0;

  static List<double> playSpeedList = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
}