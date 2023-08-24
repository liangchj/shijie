
import 'package:jin_player/config/getx_update_id.dart';
import 'package:jin_player/control_method/abstract_method.dart';
import 'package:jin_player/controller/player_controller.dart';

class DanmakuControl {
  DanmakuControl(this.getxController);
  final PlayerGetxController getxController;

  void clearDanmakuUI() {
    print("清除弹幕");
    getxController.danmakuParams.danmakuUI = null;
    getxController.danmakuParams.danmakuPlay = false;
    getxController.update([GetxUpdateId.showDanmakuBtn]);
  }

  // 创建弹幕
  void createDanmakuWidget() {
    if (getxController.playerUIParams.showDanmaku && getxController.danmakuParams.danmakuUI == null) {
      getxController.danmakuParams.danmakuUI = getxController.danmakuFn?.call(DanmakuEnum.createDanmakuView,
          params: {"time": getxController.playerParams.positionDuration.inMilliseconds.toString(), "isStart": getxController.danmakuParams.danmakuPlay});

      getxController.update([GetxUpdateId.showDanmakuBtn]);
    }
  }

  /// 启动弹幕
  Future<void> startDanmaku() async {
    getxController.playerUIParams.showDanmaku = true;
    getxController.danmakuParams.danmakuPlay = true;
    if (getxController.danmakuParams.danmakuUI == null) {
      createDanmakuWidget();
      return;
    }
    if (getxController.danmakuParams.danmakuPlay) {
      await getxController.danmakuFn?.call(DanmakuEnum.startDanmaku,
          params: {"time": getxController.playerParams.positionDuration.inMilliseconds.toString()});
    } else {
      // 获取弹幕状态
      await getxController.danmakuFn?.call(DanmakuEnum.resumeDanmaku);
    }
  }

  /// 暂停弹幕
  void pauseDanmaKu() async {
    if (getxController.danmakuParams.danmakuUI != null) {
      await getxController.danmakuFn?.call(DanmakuEnum.pauseDanmaKu);
    }
    getxController.danmakuParams.danmakuPlay = false;
  }


  void resumeDanmaku() async {
    if (getxController.danmakuParams.danmakuUI != null) {
      await getxController.danmakuFn?.call(DanmakuEnum.resumeDanmaku);
    }
    getxController.danmakuParams.danmakuPlay = true;
  }

  Future<void> sendDanmaku(String danmakuText) async {
    getxController.danmakuFn?.call(DanmakuEnum.sendDanmaku, params: {"danmakuText": danmakuText});
  }

  /// 显示弹幕
  void setDanmaKuVisibility(bool visible) async {
    if (getxController.danmakuParams.danmakuUI != null) {
      getxController.danmakuParams.showDanmaku = visible;
      await getxController.danmakuFn?.call(DanmakuEnum.setDanmaKuVisibility, params: {"visible": visible});
      getxController.update([GetxUpdateId.showDanmakuBtn]);
    } else {
      createDanmakuWidget();
    }
  }

  /// 弹幕跳转
  Future<void> danmakuSeekTo(Duration duration) async {
    if (getxController.danmakuParams.danmakuUI != null) {
      var to = (duration.inMilliseconds + getxController.danmakuParams.danmakuAdjustTime * 1000).toInt().toString();
      await getxController.danmakuFn?.call(DanmakuEnum.danmakuSeekTo, params: {'time': to, "videoPlayStatus": getxController.playerParams.isPlaying});
    }
  }

  /// 设置弹幕透明的（百分比）
  Future<void> setDanmakuAlphaRatio(int ratio) async {
    if (getxController.danmakuParams.danmakuUI != null) {
      getxController.danmakuParams.danmakuAlphaRatio = ratio;
      await getxController.danmakuFn?.call(DanmakuEnum.setDanmakuAlphaRatio, params: {"danmakuAlphaRatio": ratio});
    }
  }

  /// 设置显示区域（区域下标）
  Future<void> setDanmakuDisplayArea(int index)  async {
    if (getxController.danmakuParams.danmakuUI != null) {
      getxController.danmakuParams.danmakuDisplayAreaIndex = index;
      await getxController.danmakuFn?.call(DanmakuEnum.setDanmakuDisplayArea, params: {"danmakuDisplayAreaIndex": index});
    }
  }

  /// 设置弹幕字体大小
  Future<void> setDanmakuScaleTextSize(int size)  async {
    if (getxController.danmakuParams.danmakuUI != null) {
      getxController.danmakuParams.danmakuFontSizeRatio = size;
      await getxController.danmakuFn?.call(DanmakuEnum.setDanmakuScaleTextSize, params: {"danmakuFontSizeRatio": size});
    }
  }

  /// 设置弹幕滚动速度
  Future<void> setDanmakuSpeed({int? index})   async {
    if (getxController.danmakuParams.danmakuUI != null) {
      if (index != null) {
        getxController.danmakuParams.danmakuSpeedIndex = index;
      }
      await getxController.danmakuFn?.call(DanmakuEnum.setDanmakuSpeed, params: {"danmakuSpeedIndex": getxController.danmakuParams.danmakuSpeedIndex, "playSpeed": getxController.playerParams.playSpeed});
    }
  }

  /// 设置是否启用合并重复弹幕
  Future<void> setDuplicateMergingEnabled(bool flag) async {
    if (getxController.danmakuParams.danmakuUI != null) {
      await getxController.danmakuFn?.call(DanmakuEnum.setDuplicateMergingEnabled, params: {"flag": flag});
    }
  }

  /// 设置是否显示顶部固定弹幕
  Future<void> setFixedTopDanmakuVisibility(bool visible) async {
    if (getxController.danmakuParams.danmakuUI != null) {
      await getxController.danmakuFn?.call(DanmakuEnum.setFixedTopDanmakuVisibility, params: {"visible": visible});
    }
  }

  /// 设置是否显示滚动弹幕
  Future<void> setFixedBottomDanmakuVisibility(bool visible) async {
    if (getxController.danmakuParams.danmakuUI != null) {
      await getxController.danmakuFn?.call(DanmakuEnum.setFixedBottomDanmakuVisibility, params: {"visible": visible});
    }
  }

  /// 设置是否显示滚动弹幕
  Future<void> setRollDanmakuVisibility(bool visible) async {
    if (getxController.danmakuParams.danmakuUI != null) {
      await getxController.danmakuFn?.call(DanmakuEnum.setRollDanmakuVisibility, params: {"visible": visible});
    }
  }

  /// 设置是否显示特殊弹幕
  Future<void> setSpecialDanmakuVisibility(bool visible) async {
    if (getxController.danmakuParams.danmakuUI != null) {
      await getxController.danmakuFn?.call(DanmakuEnum.setSpecialDanmakuVisibility, params: {"visible": visible});
    }
  }

  /// 是否显示彩色弹幕
  Future<void> setColorsDanmakuVisibility(bool visible) async {
    if (getxController.danmakuParams.danmakuUI != null) {
      await getxController.danmakuFn?.call(DanmakuEnum.setColorsDanmakuVisibility, params: {"visible": visible});
    }
  }


}