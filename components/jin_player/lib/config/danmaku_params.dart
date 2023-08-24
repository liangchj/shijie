
import 'package:flutter/material.dart';

import '../control_method/abstract_method.dart';
import 'default_player_params.dart';

class DanmakuParams {
  GlobalKey danmakuKey = GlobalKey();
  String? danmakuUrl; // 弹幕地址
  Widget? danmakuUI;
  bool showDanmaku = false;
  bool danmakuPlay = false;
  Function? showDanmakuSetting; // 显示弹幕设置方法
  Function? showDanmakuSourceSetting; // 显示设置弹幕源

  // 弹幕设置
  int danmakuAlphaRatio = DefaultDanmakuParams.danmakuAlphaRatio; // 不透明度
  // 显示区域["1/4屏", "半屏", "3/4屏", "不重叠", "无限"]，选择下标，默认半屏（下标1）
  int danmakuDisplayAreaIndex = DefaultDanmakuParams.danmakuDisplayAreaIndex; // 显示区域
  // DanmakuViewType 为bili弹幕库时使用
  List<double> danmakuDisplayAreaList = DefaultDanmakuParams.danmakuDisplayAreaList;
  // 区间[20, 100]， 默认20
  int danmakuFontSizeRatio = DefaultDanmakuParams.danmakuFontSizeRatio;
  // 弹幕播放速度["极慢", "较慢", "正常", "较快", "极快"], 选择许下标， 默认正常（下标2）
  int danmakuSpeedIndex = DefaultDanmakuParams.danmakuSpeedIndex;

  // 弹幕屏蔽类型
  bool duplicateMergingEnabled =
      DefaultDanmakuParams.duplicateMergingEnabled; // 是否合并重复
  bool fixedTopDanmakuVisibility = DefaultDanmakuParams.fixedTopDanmakuVisibility; // 顶部是否显示
  bool fixedBottomDanmakuVisibility =
      DefaultDanmakuParams.fixedBottomDanmakuVisibility; // 底部是否显示
  bool rollDanmakuVisibility = DefaultDanmakuParams.rollDanmakuVisibility; // 滚动是否显示
  bool colorsDanmakuVisibility =
      DefaultDanmakuParams.colorsDanmakuVisibility; // 彩色是否显示
  bool specialDanmakuVisibility =
      DefaultDanmakuParams.specialDanmakuVisibility; // 特殊弹幕是否显示

  // 弹幕调整时间(秒)
  double danmakuAdjustTime = 0.0;

  // 开启屏蔽词
  bool openDanmakuShieldingWord = DefaultDanmakuParams.openDanmakuShieldingWord;

  IDanmakuMethod? danmakuMethod;
}

