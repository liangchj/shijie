import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jin_player/controller/player_controller.dart';

import '../config/default_player_params.dart';
import '../config/getx_update_id.dart';

/// 播放速度设置
class PlaySpeedUI extends StatelessWidget {
  const PlaySpeedUI({Key? key, required this.isFullScreen}) : super(key: key);
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    print("创建倍数UI");
    if (isFullScreen) {
      double width = MediaQuery.of(context).size.width;
      double boxWidth = width * 0.45;
      return _buildHorizontalScreenPlaySpeedUI(boxWidth);
    }
    return _buildVerticalScreenPlaySpeedUI();
  }

  _buildVerticalScreenPlaySpeedUI() {
    return SingleChildScrollView(
      child: GetBuilder<PlayerGetxController>(
          id: GetxUpdateId.playSpeedSetting,
          builder: (_) {
            return Column(
              children: DefaultPlayerParams.playSpeedList.map((e) {
                Color fontColor = e == _.playerParams.playSpeed
                    ? Colors.redAccent
                    : Colors.black;
                return ListTile(
                    onTap: () {
                      _.playerParams.playSpeed = e;
                      _.update([GetxUpdateId.playSpeed, GetxUpdateId.playSpeedSetting]);
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
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.playSpeedSetting,
        builder: (_) {
          return Container(
            height: double.infinity,
            color: Colors.black38.withOpacity(0.6),
            padding: const EdgeInsets.all(10.0),
            child: GetBuilder<PlayerGetxController>(
                id: GetxUpdateId.playSpeed,
                builder: (_) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: DefaultPlayerParams.playSpeedList.map((e) {
                      Color fontSize = e == _.playerParams.playSpeed
                          ? Colors.redAccent
                          : Colors.white;
                      return TextButton(
                          onPressed: () {
                            _.playerParams.playSpeed = e;
                            _.update([GetxUpdateId.playSpeed]);
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
