
import 'dart:io';

import 'package:jin_player/config/getx_update_id.dart';
import 'package:jin_player/control_method/abstract_method.dart';
import 'package:jin_player/controller/player_controller.dart';

class DanmakuControl {
  DanmakuControl(this.getxController);
  final PlayerGetxController getxController;

  void clearDanmakuUI() {
    getxController.danmakuParams.danmakuUI = null;
    getxController.update([GetxUpdateId.showDanmakuBtn]);
  }

  // 创建弹幕
  void createDanmakuWidget() {
    /*if (getxController.danmakuParams.danmakuUrl == null|| getxController.danmakuParams.danmakuUrl!.trim().isEmpty) {
      getxController.danmakuParams.danmakuUI = null;
      getxController.update([GetxUpdateId.showDanmakuBtn]);
      return;
    }
    var file = File(getxController.danmakuParams.danmakuUrl!.trim());
    if (!file.existsSync()) {
      getxController.danmakuParams.danmakuUI = null;
      getxController.update([GetxUpdateId.showDanmakuBtn]);
      return;
    }*/
    if (getxController.playerUIParams.showDanmaku && getxController.danmakuParams.danmakuUI == null) {
      getxController.danmakuParams.danmakuUI = getxController.danmakuFn?.call(DanmakuEnum.createDanmakuView);
      getxController.update([GetxUpdateId.showDanmakuBtn]);
    }
  }

  /// 启动弹幕
  Future<void> startDanmaku() async {
    if (getxController.danmakuParams.danmakuUI == null) {
      getxController.playerUIParams.showDanmaku = true;
      createDanmakuWidget();
      return;
    }
    // 获取弹幕状态
    await getxController.danmakuFn?.call(true ? DanmakuEnum.resumeDanmaku : DanmakuEnum.startDanmaku);
  }
}