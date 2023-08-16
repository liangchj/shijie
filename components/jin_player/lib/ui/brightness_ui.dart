
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/player_controller.dart';
/// 两点UI
class BrightnessUI extends StatefulWidget {
  const BrightnessUI({Key? key}) : super(key: key);

  @override
  State<BrightnessUI> createState() => _BrightnessUIState();
}

class _BrightnessUIState extends State<BrightnessUI> {
  final PlayerGetxController _playerGetxController = Get.find<PlayerGetxController>();
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: 80,
        height: 70,
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          //设置四周圆角 角度
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.brightness_6_rounded, color: Colors.white,),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Text("${_playerGetxController.playerParams.brightness}%", style: const TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
