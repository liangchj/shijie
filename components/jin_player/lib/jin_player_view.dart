import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jin_player/controller/player_controller.dart';

import 'config/default_player_params.dart';
import 'config/getx_update_id.dart';
import 'control_method/abstract_method.dart';
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
      this.onlyFullScreen,
      this.videoPlayerType,
      this.danmakuFn, })
      : super(key: key);
  final String videoUrl;
  final String? coverUrl;
  final bool? autoPlay;
  final bool? looping;
  final double? aspectRatio;
  final bool? onlyFullScreen;
  final VideoPlayerType? videoPlayerType;
  final Function(DanmakuEnum danmakuEnum, {dynamic params})? danmakuFn;

  @override
  State<JinPlayerView> createState() => _JinPlayerViewState();
}

class _JinPlayerViewState extends State<JinPlayerView> with AutomaticKeepAliveClientMixin {
  late PlayerGetxController _playerGetxController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playerGetxController = Get.put(PlayerGetxController());
    _playerGetxController.setVideoInfo(
        videoUrl: widget.videoUrl,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        onlyFullScreen: widget.onlyFullScreen,
        danmakuFn: widget.danmakuFn,
        aspectRatio: widget.aspectRatio);
    IVideoPlayerMethod videoPlayerMethod =
        VideoPlayerMethod(_playerGetxController);
    _playerGetxController.initPlayer(videoPlayerMethod);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(tag: "playerView", child: _playerGetxController.playerParams.onlyFullScreen ?
    const HorizontalScreenVideoPlayerView()
    : const VerticalScreenVideoPlayerView());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class VerticalScreenVideoPlayerView extends StatefulWidget {
  const VerticalScreenVideoPlayerView({Key? key}) : super(key: key);

  @override
  State<VerticalScreenVideoPlayerView> createState() => _VerticalScreenVideoPlayerViewState();
}

class _VerticalScreenVideoPlayerViewState extends State<VerticalScreenVideoPlayerView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.videoPlayer,
        builder: (playerGetxController) {
          return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                Size size = MediaQuery.of(context).size;
                if (orientation != Orientation.portrait || size.width > size.height) {
                  playerGetxController.rotateScreenIng = true;
                  return Container();
                }
                playerGetxController.rotateScreenIng = false;
                Future.delayed(const Duration(microseconds: 60)).then((value) => playerGetxController.cancelAndRestartTimer());
                return AspectRatio(
                  aspectRatio: playerGetxController
                      .playerParams.aspectRatio,
                  child: Container(
                    color: Colors.grey,
                    child: Stack(
                      children: [
                        Center(child: playerGetxController.playerParams.playerView?? Container()),
                        GetBuilder<PlayerGetxController>(
                            id: GetxUpdateId.showDanmakuBtn,
                            builder: (_) {
                              return FractionallySizedBox(
                                key: _.danmakuParams.danmakuKey,
                                widthFactor: 1.0,
                                heightFactor: _.danmakuParams.danmakuDisplayAreaList[_.danmakuParams.danmakuDisplayAreaIndex],
                                child: _.danmakuParams.danmakuUI,
                              );
                            }),
                        if (orientation == Orientation.portrait && !playerGetxController.playerParams.fullScreenPlay && !playerGetxController.rotateScreenIng)
                          const Positioned.fill(child: PlayerUI()),

                      ],
                    ),
                  ),
                );
              }
          );
        });
  }
}


class HorizontalScreenVideoPlayerView extends StatefulWidget {
  const HorizontalScreenVideoPlayerView({Key? key}) : super(key: key);

  @override
  State<HorizontalScreenVideoPlayerView> createState() => _HorizontalScreenVideoPlayerViewState();
}

class _HorizontalScreenVideoPlayerViewState extends State<HorizontalScreenVideoPlayerView> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.videoPlayer,
        builder: (playerGetxController) {
          return WillPopScope(
            onWillPop: () async {
              playerGetxController.cancelHideTimer();
              playerGetxController.hideAllUI();
              await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
              await SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
              playerGetxController.playerParams.fullScreenPlay = false;
              playerGetxController.update([GetxUpdateId.videoPlayer]);
              return Future.value(true);
            },
            child: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                Size size = MediaQuery.of(context).size;
                if (orientation != Orientation.landscape || size.height > size.width) {
                  playerGetxController.rotateScreenIng = true;
                  return Container();
                }
                playerGetxController.rotateScreenIng = false;
                Future.delayed(const Duration(microseconds: 60)).then((value) => playerGetxController.cancelAndRestartTimer());
                return Scaffold(
                  body: Center(
                    child: AspectRatio(
                      aspectRatio:
                      orientation == Orientation.landscape
                          ? playerGetxController
                          .playerParams.aspectRatio
                          : 1 /
                          playerGetxController
                              .playerParams.aspectRatio,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.grey,
                            width: double.infinity,
                            child: playerGetxController
                                .playerParams.playerView,
                          ),
                          GetBuilder<PlayerGetxController>(
                              id: GetxUpdateId.showDanmakuBtn,
                              builder: (_) {
                                return FractionallySizedBox(
                                  key: _.danmakuParams.danmakuKey,
                                  widthFactor: 1.0,
                                  heightFactor: _.danmakuParams.danmakuDisplayAreaList[_.danmakuParams.danmakuDisplayAreaIndex],
                                  child: _.danmakuParams.danmakuUI,
                                );
                              }),
                          if (playerGetxController.playerParams.fullScreenPlay && !playerGetxController.rotateScreenIng)
                            const Positioned.fill(child: PlayerUI())
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
