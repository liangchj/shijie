
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({Key? key}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  String videoUrl = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 48)),
          // JinVideoPlayerView(videoUrl: videoUrl, fullScreenPlay: false, autoPlay: false),
          Container(
            color: Colors.cyanAccent,
            padding: const EdgeInsets.only(top: 10.0),
            height: 50,
          ),

          TextButton(onPressed: () {
            Get.dialog(
              Stack(
                children: [
                  Align(
              alignment: Alignment.centerRight,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.cyanAccent,
                    ),
                  )
                ],
              )
            );
          }, child: Text("弹窗2")),
        ],
      ),
    );
  }


}
