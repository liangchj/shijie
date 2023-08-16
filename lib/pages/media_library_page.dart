
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/route/app_routes.dart';
/// 媒体库资源
class MediaLibraryPage extends StatefulWidget {
  const MediaLibraryPage({Key? key}) : super(key: key);

  @override
  State<MediaLibraryPage> createState() => _MediaLibraryPageState();
}

class _MediaLibraryPageState extends State<MediaLibraryPage> with AutomaticKeepAliveClientMixin {
  final List<Widget> _libraryList = [
    InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.localVideoDirectory);
      },
      child: const ListTile(
        leading: Icon(Icons.phone_android_rounded),
        title: Text("本地媒体"),
      ),
    ),
    InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.playDirectoryList);
      },
      child: const ListTile(
        leading: Icon(Icons.playlist_play_rounded),
        title: Text("播放列表"),
      ),
    ),
    InkWell(
      onTap: () {
        // Get.to(const DanPage());
        //Get.to(const DirtPage());
      },
      child: const ListTile(
        leading: Icon(Icons.stream_rounded),
        title: Text("串流播放"),
      ),
    ),
    InkWell(
      onTap: () {
        // Get.to(const AKDanmakuTest());
        // Get.to(const DirPage());
      },
      child: const ListTile(
        leading: Icon(Icons.boy_outlined),
        title: Text("磁力播放"),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("媒体库"),
      ),
      body: ListView(
        children: _libraryList.map((e) => e).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        tooltip: 'getVideo',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
