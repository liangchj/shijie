
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/default_player_params.dart';
import '../config/getx_update_id.dart';
import '../controller/player_controller.dart';
import '../utils/my_icons_utils.dart';
import 'player_ui.dart';
/// 弹幕设置UI
class DanmakuSettingUI extends StatelessWidget {
  const DanmakuSettingUI({Key? key, required this.isFullScreen}) : super(key: key);
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return isFullScreen ? _buildHorizontalDanmakuSettingUI(context) : _buildVerticalDanmakuSettingUI();
  }

  _buildHorizontalDanmakuSettingUI(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double boxWidth = width * 0.45;
    return Container(
      width: boxWidth > 300 ? boxWidth : 300,
      height: double.infinity,
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
                        GetBuilder<PlayerGetxController>(
                            id: GetxUpdateId.duplicateMergingEnabled,
                            builder: (_) => GestureDetector(
                              onTapDown: (details) {
                                _.danmakuParams
                                    .duplicateMergingEnabled =
                                !_.danmakuParams
                                    .duplicateMergingEnabled;
                                _.update([GetxUpdateId.duplicateMergingEnabled]);
                                // _.danmakuParams.setDuplicateMergingEnabled?.call();
                                _.danmakuParams.danmakuMethod?.setDuplicateMergingEnabled();
                              },
                              child: Column(
                                children: [
                                  _.danmakuParams
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
                        GetBuilder<PlayerGetxController>(
                            id: GetxUpdateId.fixedTopDanmakuVisibility,
                            builder: (_) => GestureDetector(
                              onTapDown: (details) {
                                _.danmakuParams.fixedTopDanmakuVisibility =
                                !_.danmakuParams
                                    .fixedTopDanmakuVisibility;
                                _.update([GetxUpdateId.fixedTopDanmakuVisibility]);
                                // _.danmakuParams.setFixedTopDanmakuVisibility?.call();
                                _.danmakuParams.danmakuMethod?.setFixedTopDanmakuVisibility();
                              },
                              child: Column(
                                children: [
                                  _.danmakuParams.fixedTopDanmakuVisibility
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
                        GetBuilder<PlayerGetxController>(
                            id: GetxUpdateId.rollDanmakuVisibility,
                            builder: (_) => GestureDetector(
                              onTapDown: (details) {
                                _.danmakuParams.rollDanmakuVisibility =
                                !_.danmakuParams
                                    .rollDanmakuVisibility;
                                _.update([GetxUpdateId.rollDanmakuVisibility]);
                                // _.danmakuParams.setRollDanmakuVisibility?.call();
                                _.danmakuParams.danmakuMethod?.setRollDanmakuVisibility();
                              },
                              child: Column(
                                children: [
                                  _.danmakuParams.rollDanmakuVisibility
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
                        GetBuilder<PlayerGetxController>(
                            id: GetxUpdateId.fixedBottomDanmakuVisibility,
                            builder: (_) => GestureDetector(
                              onTapDown: (details) {
                                _.danmakuParams
                                    .fixedBottomDanmakuVisibility =
                                !_.danmakuParams
                                    .fixedBottomDanmakuVisibility;
                                _.update([GetxUpdateId.fixedBottomDanmakuVisibility]);
                                // _.danmakuParams.setFixedBottomDanmakuVisibility?.call();
                                _.danmakuParams.danmakuMethod?.setFixedBottomDanmakuVisibility();
                              },
                              child: Column(
                                children: [
                                  _.danmakuParams
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
                        GetBuilder<PlayerGetxController>(
                            id: GetxUpdateId.colorsDanmakuVisibility,
                            builder: (_) => GestureDetector(
                              onTapDown: (details) {
                                _.danmakuParams
                                    .colorsDanmakuVisibility =
                                !_.danmakuParams
                                    .colorsDanmakuVisibility;
                                _.update([GetxUpdateId.colorsDanmakuVisibility]);
                                // _.danmakuParams.setColorsDanmakuVisibility?.call();
                                _.danmakuParams.danmakuMethod?.setColorsDanmakuVisibility();
                              },
                              child: Column(
                                children: [
                                  _.danmakuParams
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
            GetBuilder<PlayerGetxController>(
                id: GetxUpdateId.danmakuAdjustTime,
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
                                    _.danmakuParams.danmakuAdjustTime =
                                        _.danmakuParams.danmakuAdjustTime - 0.5;
                                    _.update([GetxUpdateId.danmakuAdjustTime]);
                                    // _.danmakuParams.danmakuSeekTo?.call();
                                    _.danmakuParams.danmakuMethod?.danmakuSeekTo();
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle_rounded,
                                    color: Colors.white,
                                  )),
                              BuildTextWidget(
                                  text:
                                  "${_.danmakuParams.danmakuAdjustTime}"),
                              IconButton(
                                  onPressed: () {
                                    _.danmakuParams.danmakuAdjustTime =
                                        _.danmakuParams.danmakuAdjustTime + 0.5;
                                    _.update([GetxUpdateId.danmakuAdjustTime]);
                                    // _.danmakuParams.danmakuSeekTo?.call();
                                    _.danmakuParams.danmakuMethod?.danmakuSeekTo();
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
                            onPressed: () => _.danmakuParams.danmakuMethod?.danmakuSeekTo(),
                            // _.danmakuParams.danmakuSeekTo?.call(),

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
                    GetBuilder<PlayerGetxController>(
                        id: GetxUpdateId.openDanmakuShieldingWord,
                        builder: (_) => Switch(
                          value: _.danmakuParams
                              .openDanmakuShieldingWord, //当前状态
                          onChanged: (value) {
                            _.danmakuParams.openDanmakuShieldingWord =
                            !_.danmakuParams.openDanmakuShieldingWord;
                            _.update([GetxUpdateId.openDanmakuShieldingWord]);
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
    );
  }

  _buildVerticalDanmakuSettingUI() {}



  /// 弹幕不透明度设置
  Widget _danmakuOpacitySetting(BuildContext context) {
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.danmakuAlphaSetting,
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
                      value: _.danmakuParams.danmakuAlphaRatio.toDouble(),
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        _.danmakuParams.danmakuAlphaRatio = value.toInt();
                        _.update([GetxUpdateId.danmakuAlphaSetting]);
                        // _.danmakuParams.setDanmakuAlphaRatio?.call();
                        _.danmakuParams.danmakuMethod?.setDanmakuAlphaRatio();
                      },
                    )),
              ),

              /// 右边进度提示
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 16 * 2.5, // 默认显示两个字+%
                ),
                child: Text(
                  "${_.danmakuParams.danmakuAlphaRatio}%",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  /// 弹幕显示区域设置
  Widget _danmakuDisplayAreaSetting(BuildContext context) {
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.displayAreaSetting,
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
                      value: _.danmakuParams.danmakuDisplayAreaIndex.toDouble(),
                      min: 0,
                      max: 4,
                      divisions: 4,
                      onChanged: (value) {
                        _.danmakuParams.danmakuDisplayAreaIndex = value.toInt();
                        _.update([GetxUpdateId.displayAreaSetting]);
                        // _.danmakuParams.setDanmakuDisplayArea?.call();
                        _.danmakuParams.danmakuMethod?.setDanmakuDisplayArea();
                      },
                    )),
              ),

              /// 右边进度提示
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 16 * 2.5, // 默认显示两个字+%
                ),
                child: Text(
                  DefaultDanmakuParams.danmakuAreaNameList[_.danmakuParams.danmakuDisplayAreaIndex],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  /// 弹幕字号设置
  Widget _danmakuFontSizeSetting(BuildContext context) {
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.danmakuFontSizeSetting,
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
                      value: _.danmakuParams.danmakuFontSizeRatio.toDouble(),
                      min: 20,
                      max: 200,
                      onChanged: (value) {
                        _.danmakuParams.danmakuFontSizeRatio = value.toInt();
                        _.update([GetxUpdateId.danmakuFontSizeSetting]);
                        // _.danmakuParams.setDanmakuScaleTextSize?.call();
                        _.danmakuParams.danmakuMethod?.setDanmakuScaleTextSize();
                      },
                    )),
              ),

              /// 右边进度提示
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 16 * 2.5, // 默认显示两个字+%
                ),
                child: Text(
                  "${_.danmakuParams.danmakuFontSizeRatio}%",
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
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.danmakuSpeedSetting,
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
                      value: _.danmakuParams.danmakuSpeedIndex.toDouble(),
                      min: 0,
                      max: 4,
                      divisions: 4,
                      onChanged: (value) {
                        _.danmakuParams.danmakuSpeedIndex = value.toInt();
                        _.update([GetxUpdateId.danmakuSpeedSetting]);
                        // _.danmakuParams.setDanmakuSpeed?.call();
                        _.danmakuParams.danmakuMethod?.setDanmakuSpeed();
                      },
                    )),
              ),

              /// 右边进度提示
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 16 * 2.5, // 默认显示两个字+%
                ),
                child: Text(
                  DefaultDanmakuParams.danmakuSpeedNameList[_.danmakuParams.danmakuSpeedIndex],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
