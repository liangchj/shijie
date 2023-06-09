
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


  static bool showDanmaku = true; // 显示弹幕UI

  // 弹幕设置
  static int danmakuAlphaRatio = 100; // 不透明度
  // 显示区域["1/4屏", "半屏", "3/4屏", "不重叠", "无限"]，选择下标，默认半屏（下标1）
  static int danmakuDisplayAreaIndex = 1; // 显示区域
  // 区间[20, 100]， 默认20
  static int danmakuFontSizeRatio = 80;
  // 弹幕播放速度["极慢", "较慢", "正常", "较快", "极快"], 选择许下标， 默认正常（下标2）
  static int danmakuSpeedIndex = 2;
  // static List<double> danmakuSpeedList = [1.5, 1.25, 1.0, 0.75, 0.5]; // 不知为何速度系数是反着来的的

  // 弹幕屏蔽类型
  static bool duplicateMergingEnabled = false; // 是否合并重复
  static bool fixedTopDanmakuVisibility = true; // 顶部是否显示
  static bool fixedBottomDanmakuVisibility = true; // 底部是否显示
  static bool rollDanmakuVisibility = true; // 滚动是否显示
  static bool colorsDanmakuVisibility = true; // 彩色是否显示
  static bool specialDanmakuVisibility = true; // 特殊弹幕是否显示

  static List<String> danmakuSpeedNameList = ["极慢", "较慢", "正常", "较快", "极快"];
  static List<String> danmakuAreaNameList = ["1/4屏", "半屏", "3/4屏", "不重叠", "无限"];

  // 开启屏蔽词
  static bool openDanmakuShieldingWord = false;
}