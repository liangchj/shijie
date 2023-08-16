
import 'package:flutter/material.dart';
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
          child: JinPlayerView(videoUrl: videoUrl, fullScreenPlay: false, autoPlay: false)),
    );
  }
}
