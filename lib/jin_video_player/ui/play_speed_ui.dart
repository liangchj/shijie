import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/video_player_config.dart';
import '../getx_controller/video_player_getx_controller.dart';
import 'video_player_ui.dart';

/// 播放速度设置
class PlaySpeedUI extends StatelessWidget {
  const PlaySpeedUI({Key? key, required this.isFullScreen}) : super(key: key);
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    if (isFullScreen) {
      double width = MediaQuery.of(context).size.width;
      double boxWidth = width * 0.45;
      return _buildHorizontalScreenPlaySpeedUI(boxWidth);
    }
    return _buildVerticalScreenPlaySpeedUI();
  }

  _buildVerticalScreenPlaySpeedUI() {
    return SingleChildScrollView(
      child: GetBuilder<VideoPlayerGetxController>(
          id: UpdateId.playSpeedSetting,
          builder: (_) {
            return Column(
              children: VideoPlayerConfig.playSpeedList.map((e) {
                Color fontColor = e == _.videoPlayerParams.playSpeed
                    ? Colors.redAccent
                    : Colors.black;
                return ListTile(
                    onTap: () {
                      _.videoPlayerParams.playSpeed = e;
                      _.update([UpdateId.playSpeed, UpdateId.playSpeedSetting]);
                    },
                    textColor: fontColor,
                    title: Text("${e}x"),
                    trailing: Icon(Icons.add));
              }).toList(),
            );
          }),
    );
  }

  _buildHorizontalScreenPlaySpeedUI(double boxWidth) {
    return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.playSpeedSetting,
        builder: (_) {
          return Container(
            height: double.infinity,
            color: Colors.black38.withOpacity(0.6),
            padding: const EdgeInsets.all(10.0),
            child: GetBuilder<VideoPlayerGetxController>(
                id: UpdateId.playSpeed,
                builder: (_) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: VideoPlayerConfig.playSpeedList.map((e) {
                      Color fontSize = e == _.videoPlayerParams.playSpeed
                          ? Colors.redAccent
                          : Colors.white;
                      return TextButton(
                          onPressed: () {
                            _.videoPlayerParams.playSpeed = e;
                            _.update([UpdateId.playSpeed]);
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 60))),
                          child: Text(
                            "${e}x",
                            style: TextStyle(color: fontSize),
                            textAlign: TextAlign.center,
                          ));
                    }).toList())),
          );
        });
  }
}
