
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JinVideoPlayerView1 extends StatefulWidget {
  const JinVideoPlayerView1({Key? key}) : super(key: key);

  @override
  State<JinVideoPlayerView1> createState() => _JinVideoPlayerView1State();
}

class _JinVideoPlayerView1State extends State<JinVideoPlayerView1> {
  bool _fullScreen = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _fullScreen ?
        Material(

        type:MaterialType.transparency,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.yellowAccent.withOpacity(0.5),
          child: const Center(
              child:Text('哈哈')
          ),
        )
      )

        : Container(
      color: Colors.yellowAccent,
      child: AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Stack(
          children: [
            Container(
              color: Colors.deepOrangeAccent,
            ),
            TextButton(onPressed: _changeScreen, child: const Text("旋转屏幕"))
          ],
        ),
      ),
    );
  }

  void _changeScreen() {
    if (!_fullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      setState(() {
        _fullScreen = true;
      });
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      setState(() {
        _fullScreen = false;
      });
    }
  }
}
