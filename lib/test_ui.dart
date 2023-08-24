
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jin_bili_danmaku/jin_bili_danmaku_view.dart';
import 'package:jin_player/control_method/abstract_method.dart';
import 'package:jin_player/jin_player_view.dart';
import 'package:jin_player/jin_video_player_view.dart';
import 'package:jin_player/ui/player_ui.dart';
import 'package:jin_player/jin_player_view.dart';

class TestUI extends StatefulWidget {
  const TestUI({Key? key}) : super(key: key);

  @override
  State<TestUI> createState() => _TestUIState();
}

class _TestUIState extends State<TestUI> {
  String videoUrl = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  @override
  void initState() {

    // TODO: implement initState
    super.initState();

  }
  var platform = const MethodChannel('JIN_DANMAKU_NATIVE_VIEW');
  CustomViewController? _controller;

  void _onCustomAndroidViewCreated(CustomViewController controller) {
    _controller = controller;
    _controller?.customDataStream.listen((data) {
      //接收到来自Android端的数据
      print('来自Android的数据：$data');
    });
  }
  final Key danmakuKey = const Key("bili_danmaku_key");
  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: Container(
        color: Colors.cyan,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: const AspectRatio(aspectRatio: 16/9,
          child: PlayerUI(),
        ),
      ),
    );*/
    return Scaffold(
      body: Container(
          color: Colors.cyan,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          /*child: JinVideoPlayerView(children: [
            Container(key: JinVideoPlayerView.playerKey, width: 100, height: 15, color: Colors.blue,),
            Text("文字")
          ],)),*/
          // child: JinPlayerView(videoUrl: videoUrl, autoPlay: false, onlyFullScreen: false,)),
          child: JinPlayerView(videoUrl: videoUrl, autoPlay: false, onlyFullScreen: false, danmakuFn: (danmakuEnum,
              {params}) {
            if (danmakuEnum == DanmakuEnum.createDanmakuView) {
              return JinBiliDanmakuView(key: danmakuKey, danmakuUrl: "/storage/emulated/0/DCIM/1.xml", onViewCreated: _onCustomAndroidViewCreated, extendParams: params);
            }
          },)),
          // child: JinPlayerView(videoUrl: videoUrl, autoPlay: false, onlyFullScreen: false, danmakuUI: JinBiliDanmakuView(danmakuUrl: "/storage/emulated/0/DCIM/1.xml", onViewCreated: _onCustomAndroidViewCreated,),)),
    );
  }
}
