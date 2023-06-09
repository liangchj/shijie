
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/jin_video_player/utils/my_icons_utils.dart';

import '../config/video_player_config.dart';
import '../getx_controller/video_player_getx_controller.dart';
import 'video_player_ui.dart';
/// 弹幕设置UI
class DanmakuSettingUI extends StatelessWidget {
  const DanmakuSettingUI({Key? key, required this.isFullScreen}) : super(key: key);
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return isFullScreen ? _buildHorizontalDanmakuSettingUI(context) : _buildVerticalDanmakuSettingUI();
  }

  _buildHorizontalDanmakuSettingUI(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black38.withOpacity(0.6),
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 弹幕设置
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BuildTextWidget(
                        text: "弹幕设置",
                        style: TextStyle(
                            color: Colors.white54, fontSize: 18),
                        edgeInsets: EdgeInsets.only(
                            left: 5, top: 10, right: 5, bottom: 10)),
                  ),
                  Column(
                    children: [
                      // 弹幕不透明度设置
                      _danmakuOpacitySetting(context),
                      // 弹幕显示区域设置
                      _danmakuDisplayAreaSetting(context),
                      // 弹幕字号设置
                      _danmakuFontSizeSetting(context),
                      // 弹幕速度设置
                      _danmakuSpeedSetting(context)
                    ],
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              // 屏蔽类型
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BuildTextWidget(
                        text: "屏蔽类型",
                        style: TextStyle(
                            color: Colors.white54, fontSize: 18),
                        edgeInsets: EdgeInsets.only(
                            left: 5, top: 10, right: 5, bottom: 10)),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 16.0, // 主轴(水平)方向间距
                        runSpacing: 16.0, // 纵轴（垂直）方向间距
                        verticalDirection: VerticalDirection.down,
                        alignment: WrapAlignment.spaceBetween, //
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          GetBuilder<VideoPlayerGetxController>(
                              id: UpdateId.duplicateMergingEnabled,
                              builder: (_) => GestureDetector(
                                onTapDown: (details) {
                                  _.videoPlayerParams
                                      .duplicateMergingEnabled =
                                  !_.videoPlayerParams
                                      .duplicateMergingEnabled;
                                  _.update([UpdateId.duplicateMergingEnabled]);
                                  _.videoPlayerParams.setDuplicateMergingEnabled?.call();
                                },
                                child: Column(
                                  children: [
                                    _.videoPlayerParams
                                        .duplicateMergingEnabled
                                        ? const Icon(
                                        MyIconsUtils
                                            .repeatDanmakuOpen,
                                        color: Colors.white)
                                        : const Icon(
                                        MyIconsUtils
                                            .repeatDanmakuClose,
                                        color: Colors.redAccent),
                                    const BuildTextWidget(
                                      text: "重复",
                                    ),
                                  ],
                                ),
                              )),
                          GetBuilder<VideoPlayerGetxController>(
                              id: UpdateId.fixedTopDanmakuVisibility,
                              builder: (_) => GestureDetector(
                                onTapDown: (details) {
                                  _.videoPlayerParams.fixedTopDanmakuVisibility =
                                  !_.videoPlayerParams
                                      .fixedTopDanmakuVisibility;
                                  _.update([UpdateId.fixedTopDanmakuVisibility]);
                                  _.videoPlayerParams.setFixedTopDanmakuVisibility?.call();
                                },
                                child: Column(
                                  children: [
                                    _.videoPlayerParams.fixedTopDanmakuVisibility
                                        ? const Icon(
                                        MyIconsUtils
                                            .topDanmakuOpen,
                                        color: Colors.white)
                                        : const Icon(
                                        MyIconsUtils
                                            .topDanmakuClose,
                                        color: Colors.redAccent),
                                    const BuildTextWidget(
                                      text: "顶部",
                                    ),
                                  ],
                                ),
                              )),
                          GetBuilder<VideoPlayerGetxController>(
                              id: UpdateId.rollDanmakuVisibility,
                              builder: (_) => GestureDetector(
                                onTapDown: (details) {
                                  _.videoPlayerParams.rollDanmakuVisibility =
                                  !_.videoPlayerParams
                                      .rollDanmakuVisibility;
                                  _.update([UpdateId.rollDanmakuVisibility]);
                                  _.videoPlayerParams.setRollDanmakuVisibility?.call();
                                },
                                child: Column(
                                  children: [
                                    _.videoPlayerParams.rollDanmakuVisibility
                                        ? const Icon(
                                        MyIconsUtils
                                            .rollDanmakuOpen,
                                        color: Colors.white)
                                        : const Icon(
                                        MyIconsUtils
                                            .rollDanmakuClose,
                                        color: Colors.redAccent),
                                    const BuildTextWidget(
                                      text: "滚动",
                                    ),
                                  ],
                                ),
                              )),
                          GetBuilder<VideoPlayerGetxController>(
                              id: UpdateId.fixedBottomDanmakuVisibility,
                              builder: (_) => GestureDetector(
                                onTapDown: (details) {
                                  _.videoPlayerParams
                                      .fixedBottomDanmakuVisibility =
                                  !_.videoPlayerParams
                                      .fixedBottomDanmakuVisibility;
                                  _.update([UpdateId.fixedBottomDanmakuVisibility]);
                                  _.videoPlayerParams.setFixedBottomDanmakuVisibility?.call();
                                },
                                child: Column(
                                  children: [
                                    _.videoPlayerParams
                                        .fixedBottomDanmakuVisibility
                                        ? const Icon(
                                        MyIconsUtils
                                            .bottomDanmakuOpen,
                                        color: Colors.white)
                                        : const Icon(
                                        MyIconsUtils
                                            .bottomDanmakuClose,
                                        color: Colors.redAccent),
                                    const BuildTextWidget(
                                      text: "底部",
                                    ),
                                  ],
                                ),
                              )),
                          GetBuilder<VideoPlayerGetxController>(
                              id: UpdateId.colorsDanmakuVisibility,
                              builder: (_) => GestureDetector(
                                onTapDown: (details) {
                                  _.videoPlayerParams
                                      .colorsDanmakuVisibility =
                                  !_.videoPlayerParams
                                      .colorsDanmakuVisibility;
                                  _.update([UpdateId.colorsDanmakuVisibility]);
                                  _.videoPlayerParams.setColorsDanmakuVisibility?.call();
                                },
                                child: Column(
                                  children: [
                                    _.videoPlayerParams
                                        .colorsDanmakuVisibility
                                        ? const Icon(
                                        MyIconsUtils
                                            .colorDanmakuOpen,
                                        color: Colors.white)
                                        : const Icon(
                                        MyIconsUtils
                                            .colorDanmakuClose,
                                        color: Colors.redAccent),
                                    const BuildTextWidget(
                                      text: "彩色",
                                    ),
                                  ],
                                ),
                              )),
                        ]),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),

              /// 时间调整
              GetBuilder<VideoPlayerGetxController>(
                  id: UpdateId.danmakuAdjustTime,
                  builder: (_) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: BuildTextWidget(
                              text: "时间调整(秒)",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 18),
                              edgeInsets: EdgeInsets.only(
                                  left: 5, top: 10, right: 5, bottom: 10)),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _.videoPlayerParams.danmakuAdjustTime =
                                          _.videoPlayerParams.danmakuAdjustTime - 0.5;
                                      _.update([UpdateId.danmakuAdjustTime]);
                                      _.videoPlayerParams.danmakuSeekTo?.call();
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle_rounded,
                                      color: Colors.white,
                                    )),
                                BuildTextWidget(
                                    text:
                                    "${_.videoPlayerParams.danmakuAdjustTime}"),
                                IconButton(
                                    onPressed: () {
                                      _.videoPlayerParams.danmakuAdjustTime =
                                          _.videoPlayerParams.danmakuAdjustTime + 0.5;
                                      _.update([UpdateId.danmakuAdjustTime]);
                                      _.videoPlayerParams.danmakuSeekTo?.call();
                                    },
                                    icon: const Icon(Icons.add_circle_rounded,
                                        color: Colors.white)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  _.videoPlayerParams.danmakuSeekTo?.call(),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.white.withOpacity(0.5))),
                              child: const Text("同步弹幕时间"),
                            )),
                      ],
                    );

                  }),

              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),

              /// 弹幕屏蔽词
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: BuildTextWidget(
                            text: "弹幕屏蔽词",
                            style: TextStyle(
                                color: Colors.white54, fontSize: 18),
                            edgeInsets: EdgeInsets.only(
                                left: 5, top: 10, right: 5, bottom: 10)),
                      ),
                      GetBuilder<VideoPlayerGetxController>(
                          id: UpdateId.openDanmakuShieldingWord,
                          builder: (_) => Switch(
                            value: _.videoPlayerParams
                                .openDanmakuShieldingWord, //当前状态
                            onChanged: (value) {
                              _.videoPlayerParams.openDanmakuShieldingWord =
                              !_.videoPlayerParams.openDanmakuShieldingWord;
                              _.update([UpdateId.openDanmakuShieldingWord]);
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20)),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0.5))),
                        child: const Text("弹幕屏蔽管理"),
                      )),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),

              /// 弹幕列表
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BuildTextWidget(
                        text: "弹幕列表",
                        style: TextStyle(
                            color: Colors.white54, fontSize: 20),
                        edgeInsets: EdgeInsets.only(
                            left: 5, top: 10, right: 5, bottom: 10)),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20))),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0.5))),
                        child: const Text("查看弹幕列表"),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildVerticalDanmakuSettingUI() {}



  /// 弹幕不透明度设置
  Widget _danmakuOpacitySetting(BuildContext context) {
    return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.danmakuAlphaSetting,
        builder: (_) {
          return Row(
            children: [
              /// 左边文字说明
              const Padding(
                padding:
                EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
                child: Text(
                  "不透明度",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              /// 中间进度指示器
              Expanded(
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        trackShape: const MySliderTrackShape(),
                        activeTrackColor: Colors.redAccent,
                        inactiveTrackColor: Colors.white60,
                        inactiveTickMarkColor: Colors.white,
                        tickMarkShape:
                        const RoundSliderTickMarkShape(tickMarkRadius: 2.5),
                        thumbColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(
                          //可继承SliderComponentShape自定义形状
                          disabledThumbRadius: 4, //禁用时滑块大小
                          enabledThumbRadius: 4, //滑块大小
                        ),
                        overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 8)),
                    child: Slider(
                      value: _.videoPlayerParams.danmakuAlphaRatio.toDouble(),
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        _.videoPlayerParams.danmakuAlphaRatio = value.toInt();
                        _.update([UpdateId.danmakuAlphaSetting]);
                        _.videoPlayerParams.setDanmakuAlphaRatio?.call();
                      },
                    )),
              ),

              /// 右边进度提示
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 16 * 2.5, // 默认显示两个字+%
                ),
                child: Text(
                  "${_.videoPlayerParams.danmakuAlphaRatio}%",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  /// 弹幕显示区域设置
  Widget _danmakuDisplayAreaSetting(BuildContext context) {
    return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.displayAreaSetting,
        builder: (_) {
          return Row(
            children: [
              /// 左边文字说明
              const Padding(
                padding:
                EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
                child: Text(
                  "显示区域",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              /// 中间进度指示器
              Expanded(
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        trackShape: const MySliderTrackShape(),
                        activeTrackColor: Colors.redAccent,
                        inactiveTrackColor: Colors.white60,
                        inactiveTickMarkColor: Colors.white,
                        tickMarkShape:
                        const RoundSliderTickMarkShape(tickMarkRadius: 2.5),
                        thumbColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(
                          //可继承SliderComponentShape自定义形状
                          disabledThumbRadius: 4, //禁用时滑块大小
                          enabledThumbRadius: 4, //滑块大小
                        ),
                        overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 8)),
                    child: Slider(
                      value: _.videoPlayerParams.danmakuDisplayAreaIndex.toDouble(),
                      min: 0,
                      max: 4,
                      divisions: 4,
                      onChanged: (value) {
                        _.videoPlayerParams.danmakuDisplayAreaIndex = value.toInt();
                        _.update([UpdateId.displayAreaSetting]);
                        _.videoPlayerParams.setDanmakuDisplayArea?.call();
                      },
                    )),
              ),

              /// 右边进度提示
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 16 * 2.5, // 默认显示两个字+%
                ),
                child: Text(
                  VideoPlayerConfig.danmakuAreaNameList[_.videoPlayerParams.danmakuDisplayAreaIndex],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  /// 弹幕字号设置
  Widget _danmakuFontSizeSetting(BuildContext context) {
    return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.danmakuFontSizeSetting,
        builder: (_) {
          return Row(
            children: [
              /// 左边文字说明
              const Padding(
                padding:
                EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
                child: Text(
                  "弹幕字号",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              /// 中间进度指示器
              Expanded(
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        trackShape: const MySliderTrackShape(),
                        activeTrackColor: Colors.redAccent,
                        inactiveTrackColor: Colors.white60,
                        inactiveTickMarkColor: Colors.white,
                        tickMarkShape:
                        const RoundSliderTickMarkShape(tickMarkRadius: 2.5),
                        thumbColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(
                          //可继承SliderComponentShape自定义形状
                          disabledThumbRadius: 4, //禁用时滑块大小
                          enabledThumbRadius: 4, //滑块大小
                        ),
                        overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 8)),
                    child: Slider(
                      value: _.videoPlayerParams.danmakuFontSizeRatio.toDouble(),
                      min: 20,
                      max: 200,
                      onChanged: (value) {
                        _.videoPlayerParams.danmakuFontSizeRatio = value.toInt();
                        _.update([UpdateId.danmakuFontSizeSetting]);
                        _.videoPlayerParams.setDanmakuScaleTextSize?.call();
                      },
                    )),
              ),

              /// 右边进度提示
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 16 * 2.5, // 默认显示两个字+%
                ),
                child: Text(
                  "${_.videoPlayerParams.danmakuFontSizeRatio}%",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  /// 弹幕速度设置
  Widget _danmakuSpeedSetting(BuildContext context) {
    var speedList = ["极慢", "较慢", "正常", "较快", "极快"];
    return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.danmakuSpeedSetting,
        builder: (_) {
          return Row(
            children: [
              /// 左边文字说明
              const Padding(
                padding:
                EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
                child: Text(
                  "弹幕速度",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              /// 中间进度指示器
              Expanded(
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        trackShape: const MySliderTrackShape(),
                        activeTrackColor: Colors.redAccent,
                        inactiveTrackColor: Colors.white60,
                        inactiveTickMarkColor: Colors.white,
                        tickMarkShape:
                        const RoundSliderTickMarkShape(tickMarkRadius: 2.5),
                        thumbColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(
                          //可继承SliderComponentShape自定义形状
                          disabledThumbRadius: 4, //禁用时滑块大小
                          enabledThumbRadius: 4, //滑块大小
                        ),
                        overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 8)),
                    child: Slider(
                      value: _.videoPlayerParams.danmakuSpeedIndex.toDouble(),
                      min: 0,
                      max: 4,
                      divisions: 4,
                      onChanged: (value) {
                        _.videoPlayerParams.danmakuSpeedIndex = value.toInt();
                        _.update([UpdateId.danmakuSpeedSetting]);
                        _.videoPlayerParams.setDanmakuSpeed?.call();
                      },
                    )),
              ),

              /// 右边进度提示
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 16 * 2.5, // 默认显示两个字+%
                ),
                child: Text(
                  VideoPlayerConfig.danmakuSpeedNameList[_.videoPlayerParams.danmakuSpeedIndex],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
