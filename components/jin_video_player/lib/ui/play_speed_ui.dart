import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jin_video_player/config/video_player_config.dart';
import 'package:jin_video_player/getx_controller/video_player_getx_controller.dart';
import 'package:jin_video_player/ui/video_player_ui.dart';

/// 播放速度设置
class PlaySpeedUI extends StatelessWidget {
  const PlaySpeedUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double boxWidth = width * 0.45;
    /*return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.playSpeedSetting,
        builder: (_) {
          var showPlaySpeedSetting = _.videoPlayerParams.showPlaySpeedSetting;
          return AnimatedSlide(
            offset:
            showPlaySpeedSetting ? const Offset(0, 0) : const Offset(1, 0),
            duration: UIData.uiShowAnimationDuration,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: boxWidth, minWidth: 100),
              child: GestureDetector(
                onTap: () {}, // 用于阻止事件冒泡
                child: Container(
                  height: double.infinity,
                  color: Colors.black38.withOpacity(0.6),
                  padding: const EdgeInsets.all(10.0),
                  child: GetBuilder<VideoPlayerGetxController>(
                      id: UpdateId.playSpeed,
                      builder: (_) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: VideoPlayerConfig.playSpeedList
                              .map((e) {
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
                ),
              ),
            ),
          );
        });*/
    return GetBuilder<VideoPlayerGetxController>(
        id: UpdateId.playSpeedSetting,
        builder: (_) {
          return _.videoPlayerParams.isFullScreen ? _buildHorizontalScreenPlaySpeedUI(_, boxWidth) : _buildVerticalScreenPlaySpeedUI(_);
        });
  }
  _buildVerticalScreenPlaySpeedUI(VideoPlayerGetxController _) {
    return SingleChildScrollView(
      child: Column(
        children: VideoPlayerConfig.playSpeedList
            .map((e) {
          Color fontColor = e == _.videoPlayerParams.playSpeed
              ? Colors.redAccent
              : Colors.black;
          return ListTile(
            onTap: () {
              _.videoPlayerParams.playSpeed = e;
              _.update([UpdateId.playSpeed, UpdateId.playSpeedSetting]);
            },
            textColor: fontColor,
            title: Text("${e}x"), trailing: Icon(Icons.add));
        }).toList(),
      ),
    );
  }

  _buildHorizontalScreenPlaySpeedUI(VideoPlayerGetxController _, double boxWidth) {
    var showPlaySpeedSetting = _.videoPlayerParams.showPlaySpeedSetting;
    return AnimatedSlide(
      offset:
      showPlaySpeedSetting ? const Offset(0, 0) : const Offset(1, 0),
      duration: UIData.uiShowAnimationDuration,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: boxWidth, minWidth: 100),
        child: GestureDetector(
          onTap: () {}, // 用于阻止事件冒泡
          child: Container(
            height: double.infinity,
            color: Colors.black38.withOpacity(0.6),
            padding: const EdgeInsets.all(10.0),
            child: GetBuilder<VideoPlayerGetxController>(
                id: UpdateId.playSpeed,
                builder: (_) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: VideoPlayerConfig.playSpeedList
                        .map((e) {
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
          ),
        ),
      ),
    );
  }
}
