import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jin_video_player/config/video_player_params.dart';
import 'package:jin_video_player/getx_controller/video_player_getx_controller.dart';
import 'package:jin_video_player/ui/video_player_ui.dart';
import 'package:jin_video_player/video_player_type/video_player_method.dart';

class JinVideoPlayerView extends StatefulWidget {
  const JinVideoPlayerView(
      {Key? key,
      required this.videoUrl,
      this.coverUrl,
      this.autoPlay,
      this.looping,
      this.aspectRatio,
      this.fullScreenPlay = true,
      this.videoPlayerType})
      : super(key: key);
  final String videoUrl;
  final String? coverUrl;
  final bool? autoPlay;
  final bool? looping;
  final double? aspectRatio;
  final bool fullScreenPlay;
  final VideoPlayerType? videoPlayerType;

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
    _videoPlayerController.setVideoInfo(
        videoUrl: widget.videoUrl,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        fullScreenPlay: widget.fullScreenPlay,
        aspectRatio: widget.aspectRatio);
    IVideoPlayerMethod videoPlayerMethod = VideoPlayerMethod(_videoPlayerController);
    _videoPlayerController.initPlayer(videoPlayerMethod);
/*    /// 全屏播放
    if (widget.fullScreenPlay) {
      /// 旋转屏幕
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      /// 隐藏状态栏
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }*/
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
        /*Positioned(
            bottom: 10,
            right: 10,
            child: TextButton(
              child: Text("全屏"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const HorizontalScreenVideoPlayerView();
                }));
              },
            ))*/
      ]
    );
  }


}


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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.grey,
              child: Hero(
                tag: "videoPlayer",
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.videoPlayerParams.aspectRatio,
                  // child: _videoPlayerController.videoPlayerParams.videoPlayerView
                ),
              ),
            ),
          ),
          // ui
          const Positioned.fill(child: VideoPlayerUI())
        ],
      ),
    );
  }
}
