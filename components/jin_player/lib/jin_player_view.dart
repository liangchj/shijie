import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jin_player/controller/player_controller.dart';

import 'config/default_player_params.dart';
import 'control_method/abstract_player_method.dart';
import 'player/video_player_method.dart';
import 'ui/player_ui.dart';

class JinPlayerView extends StatefulWidget {
  const JinPlayerView(
      {Key? key,
      required this.videoUrl,
      this.coverUrl,
      this.autoPlay,
      this.looping,
      this.aspectRatio,
      this.fullScreenPlay,
      this.onlyFullScreen,
      this.videoPlayerType,
      this.danmakuUI})
      : super(key: key);
  final String videoUrl;
  final String? coverUrl;
  final bool? autoPlay;
  final bool? looping;
  final double? aspectRatio;
  final bool? fullScreenPlay;
  final bool? onlyFullScreen;
  final VideoPlayerType? videoPlayerType;
  final Widget? danmakuUI;

  @override
  State<JinPlayerView> createState() => _JinPlayerViewState();
}

class _JinPlayerViewState extends State<JinPlayerView> {
  late PlayerGetxController _playerGetxController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playerGetxController = Get.put(PlayerGetxController());
    _playerGetxController.danmakuParams.danmakuUI = widget.danmakuUI;
    _playerGetxController.setVideoInfo(
        videoUrl: widget.videoUrl,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        fullScreenPlay: widget.fullScreenPlay,
        onlyFullScreen: widget.onlyFullScreen,
        aspectRatio: widget.aspectRatio);
    IVideoPlayerMethod videoPlayerMethod = VideoPlayerMethod(_playerGetxController);
    _playerGetxController.initPlayer(videoPlayerMethod);


  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("屏幕方向：竖屏");
    return Stack(
        children: [
          Container(
            color: Colors.grey,
            child: _playerGetxController.playerParams.fullScreenPlay ? const HorizontalScreenVideoPlayerView() : Hero(
              tag: "videoPlayer",
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _playerGetxController.playerParams.aspectRatio,
                    child: _playerGetxController.playerParams.playerView,
                  ),
                  const Positioned.fill(child: PlayerUI())
                ],
              ),
            ),
          ),
        ]
    );
  }
}


/// 全屏播放
class HorizontalScreenVideoPlayerView extends StatefulWidget {
  const HorizontalScreenVideoPlayerView({Key? key}) : super(key: key);

  @override
  State<HorizontalScreenVideoPlayerView> createState() => _HorizontalScreenVideoPlayerViewState();
}

class _HorizontalScreenVideoPlayerViewState extends State<HorizontalScreenVideoPlayerView> {
  final PlayerGetxController _playerGetxController = Get.find<PlayerGetxController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    });
  }


  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    print("屏幕方向：横屏");
    return WillPopScope(
      onWillPop: () async {
        if (!_playerGetxController.playerParams.onlyFullScreen) {
          _playerGetxController.playerParams.fullScreenPlay = false;
        }
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        if (MediaQuery.of(context).orientation != Orientation.portrait) {
          return Future(() => false);
        }
        return Future(() => true);
      },
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Container(
                    color: Colors.grey,
                    child: Hero(
                      tag: "videoPlayer",
                      child: AspectRatio(
                        aspectRatio: orientation == Orientation.landscape ? _playerGetxController.playerParams.aspectRatio : 1 / _playerGetxController.playerParams.aspectRatio,
                      ),
                    ),
                  ),
                ),
                // ui
                _playerGetxController.playerParams.fullScreenPlay && orientation == Orientation.landscape ? const Positioned.fill(child: PlayerUI()) : Container()
              ],
            ),
          );
        },

      ),
    );
  }
}


class FullScreenPlayPage extends StatefulWidget {
  const FullScreenPlayPage({Key? key}) : super(key: key);

  @override
  State<FullScreenPlayPage> createState() => _FullScreenPlayPageState();
}

class _FullScreenPlayPageState extends State<FullScreenPlayPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
