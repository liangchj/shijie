
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/player_controller.dart';
import '../utils/format_utils.dart';
/// 拖动播放进度UI
class DragPlayProgressUI extends StatefulWidget {
  const DragPlayProgressUI({Key? key}) : super(key: key);

  @override
  State<DragPlayProgressUI> createState() => _DragPlayProgressUIState();
}

class _DragPlayProgressUIState extends State<DragPlayProgressUI> {
  final PlayerGetxController _playerGetxController = Get.find<PlayerGetxController>();
  @override
  Widget build(BuildContext context) {
    var second = _playerGetxController.playerParams.dragProgressPositionDuration.inSeconds + _playerGetxController.playerParams.draggingSecond;
    return UnconstrainedBox(
      child: Container(
        width: 100,
        height: 70,
        // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          //设置四周圆角 角度
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${durationToMinuteAndSecond(Duration(seconds: second > 0 ? second : 0))}/${durationToMinuteAndSecond(
                _playerGetxController.videoInfoParams.duration)}", style: const TextStyle(color: Colors.white),),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Text("${_playerGetxController.playerParams.draggingSecond}秒", style: const TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
