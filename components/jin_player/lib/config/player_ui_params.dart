
import 'package:flutter/cupertino.dart';


class PlayerUIParams {

  // UI 部分
  bool showTopUI = false; // 显示顶部UI
  bool showCenterUI = false; // 显示中间UI
  bool showCenterLoadingUI = false; // 显示中间加载UI
  bool showCenterVolumeAndBrightnessUI = false; // 显示中间亮度和音量UI
  bool showBottomUI = false; // 显示底部UI
  bool showDanmaku = false; // 显示弹幕UI
  bool showSettingUI = false; // 显示设置UI


  Widget? centerUI;
  Widget? centerLoadingUI;
  Widget? centerVolumeAndBrightnessUI;
  Widget? settingUI;
}