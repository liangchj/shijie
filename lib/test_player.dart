
import 'package:flutter/material.dart';
import 'package:jin_player/jin_video_player_view.dart';



class TestPlayer extends StatefulWidget {
  const TestPlayer({Key? key}) : super(key: key);

  @override
  State<TestPlayer> createState() => _TestPlayerState();
}

class _TestPlayerState extends State<TestPlayer> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.landscape) {
            return JinVideoPlayerView1();
          }
          return Scaffold(
            body: Container(
              margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .padding
                  .top),
              child: Column(
                children: [
                  const Text("头部内容"),
                  const JinVideoPlayerView1(),
                  Container(
                    color: Colors.cyanAccent,
                    child: const Text("后置内容"),
                  )
                ],
              ),
            ),
          );

        }
    );
  }
}
