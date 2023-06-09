import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'config/video_player_params.dart';
import 'getx_controller/video_player_getx_controller.dart';
import 'ui/video_player_ui.dart';
import 'video_player_type/video_player_method.dart';


class JinVideoPlayerView extends StatefulWidget {
  const JinVideoPlayerView(
      {Key? key,
      required this.videoUrl,
      this.coverUrl,
      this.autoPlay,
      this.looping,
      this.aspectRatio,
      this.fullScreenPlay = true,
      this.videoPlayerType, this.danmakuUI})
      : super(key: key);
  final String videoUrl;
  final String? coverUrl;
  final bool? autoPlay;
  final bool? looping;
  final double? aspectRatio;
  final bool fullScreenPlay;
  final VideoPlayerType? videoPlayerType;
  final Widget? danmakuUI;

  @override
  State<JinVideoPlayerView> createState() => _JinVideoPlayerViewState();
}

class _JinVideoPlayerViewState extends State<JinVideoPlayerView> {
  late VideoPlayerGetxController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = Get.put(VideoPlayerGetxController());
    _videoPlayerController.canChangeFullScreenState = !widget.fullScreenPlay;
    _videoPlayerController.videoPlayerParams.danmakuUI = widget.danmakuUI;
    _videoPlayerController.setVideoInfo(
        videoUrl: widget.videoUrl,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        fullScreenPlay: widget.fullScreenPlay,
        aspectRatio: widget.aspectRatio);
    IVideoPlayerMethod videoPlayerMethod = VideoPlayerMethod(_videoPlayerController);
    _videoPlayerController.initPlayer(videoPlayerMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.grey,
          child: _videoPlayerController.videoPlayerParams.fullScreenPlay ? const HorizontalScreenVideoPlayerView() : Hero(
              tag: "videoPlayer",
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _videoPlayerController.videoPlayerParams.aspectRatio,
                    // child: _videoPlayerController.videoPlayerParams.videoPlayerView,
                  ),
                  const Positioned.fill(child: VideoPlayerUI())
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
  final VideoPlayerGetxController _videoPlayerController = Get.find<VideoPlayerGetxController>();
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
    return OrientationBuilder(
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
                        aspectRatio: orientation == Orientation.landscape ? _videoPlayerController.videoPlayerParams.aspectRatio : 1 / _videoPlayerController.videoPlayerParams.aspectRatio,
                      ),
                    ),
                  ),
                ),
                // ui
                orientation == Orientation.landscape ? const Positioned.fill(child: VideoPlayerUI()) : Container()
              ],
            ),
          );
        },

    );
  }
}
