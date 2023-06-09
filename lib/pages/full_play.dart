
import 'package:flutter/material.dart';
import 'package:shijie/jin_video_player/jin_video_player_view.dart';

class FullPlay extends StatefulWidget {
  const FullPlay({Key? key}) : super(key: key);

  @override
  State<FullPlay> createState() => _FullPlayState();
}

class _FullPlayState extends State<FullPlay> {
  String videoUrl = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JinVideoPlayerView(videoUrl: videoUrl, fullScreenPlay: true, autoPlay: false),
    );
  }
}
