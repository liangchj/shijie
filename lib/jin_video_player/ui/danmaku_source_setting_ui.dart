
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_controller/video_player_getx_controller.dart';
import 'video_player_ui.dart';

class DanmakuSourceSettingUI extends StatelessWidget {
  const DanmakuSourceSettingUI({Key? key, required this.isFullScreen}) : super(key: key);
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return isFullScreen ? _buildHorizontalDanmakuSourceSettingUI(context) : _buildVerticalDanmakuSourceSettingUI();
  }

  _buildHorizontalDanmakuSourceSettingUI(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double boxWidth = width * 0.45;
    return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.danmakuSourceSetting,
        builder: (_) {
          return Container(
            width: boxWidth > 300 ? boxWidth : 300,
            height: double.infinity,
            color: Colors.black38.withOpacity(0.6),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BuildTextWidget(
                      text: "弹幕源",
                      style: TextStyle(color: Colors.white54, fontSize: 20),
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
                                borderRadius: BorderRadius.circular(20))),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white.withOpacity(0.5))),
                    child: const Text("添加本地弹幕"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white.withOpacity(0.5))),
                    child: const Text("添加网络弹幕"),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BuildTextWidget(
                      text: "当前绑定弹幕",
                      style: TextStyle(color: Colors.white54, fontSize: 20),
                      edgeInsets: EdgeInsets.only(
                          left: 5, top: 10, right: 5, bottom: 10)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: BuildTextWidget(
                      text: _.videoPlayerParams.danmakuUrl ?? "",
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  _buildVerticalDanmakuSourceSettingUI() {}
}
