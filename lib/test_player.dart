
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class TestPlayer extends StatefulWidget {
  const TestPlayer({Key? key}) : super(key: key);

  @override
  State<TestPlayer> createState() => _TestPlayerState();
}

class _TestPlayerState extends State<TestPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VideoPlayerView(),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(color: Colors.cyanAccent, height: 100,),
          Text("其他内容")
        ],
      ),
    );
  }
}

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  bool fullScreen = false;
  @override
  Widget build(BuildContext context) {
    return Hero(tag: "videoPlayer", child: Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Colors.black,
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Container(
          color: Colors.yellowAccent,
          child: Center(
            child: TextButton(
              onPressed: toggleFullScreen,
              child: const Text("进入/退出"),
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> toggleFullScreen() async {
    if (fullScreen) {
      fullScreen = false;
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    } else {
      fullScreen = true;
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const VideoPlayerView();
        }),
      );
      /*showDialog(
        context: Get.context!,
        useSafeArea: false,
        builder: (context) => const Dialog.fullscreen(
            backgroundColor: Colors.black,
            child: VideoPlayerView(),
        )
      );*/
    }
  }
}

