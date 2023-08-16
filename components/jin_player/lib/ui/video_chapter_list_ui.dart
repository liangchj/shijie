import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jin_player/controller/player_controller.dart';

import '../config/getx_update_id.dart';
import 'player_ui.dart';


/// 视频章节列表
class VideoChapterListUI extends StatelessWidget {
  const VideoChapterListUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double boxWidth = width * 0.45;
    return GetBuilder<PlayerGetxController>(
        id: GetxUpdateId.videoChapterList,
        builder: (_) {
          List<Map<String, dynamic>> videoChapterList = _.videoInfoParams.videoChapterList;
          return Container(
            width: boxWidth,
            height: double.infinity,
            color: Colors.black38.withOpacity(0.6),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BuildTextWidget(
                      text: "选集（${videoChapterList.length}）",
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 20),
                      edgeInsets: const EdgeInsets.only(
                          left: 5, top: 10, right: 5, bottom: 10)),
                ),
                Expanded(
                    child: _.videoInfoParams.maxVideoNameLen > 4
                        ? _buildNormalLayout(videoChapterList)
                        : _buildGridViewLayout(videoChapterList))
              ],
            ),
          );
        });
  }

  /// 普通列表排版
  Widget _buildNormalLayout(videoChapterList) {
    double fontSize = 18;
    Color defaultFontColor = Colors.white;
    Color playFontColor = Colors.redAccent;
    return ListView.builder(
      prototypeItem: const ListTile(title: Text("章节")),
      itemCount: videoChapterList.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> videoModel = videoChapterList[index];
        return GetBuilder<PlayerGetxController>(
            id: GetxUpdateId.videoChapterNormalLayout,
            builder: (_) {
              bool isPlaying =
                  videoModel["path"] == _.videoInfoParams.playVideoChapter;
              double iconOpacity = isPlaying ? 1.0 : 0;
              Color fontColor = isPlaying ? playFontColor : defaultFontColor;
              return Container(
                color: Colors.white.withOpacity(0.3),
                margin:
                const EdgeInsets.only(left: 5, top: 6, right: 5, bottom: 6),
                child: InkWell(
                  onTap: () =>
                  _.videoInfoParams.playVideoChapter = videoModel["path"],
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow_rounded,
                        size: fontSize,
                        color: Colors.redAccent.withOpacity(iconOpacity),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            videoModel["name"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: fontSize,
                                color: fontColor,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  /// 网格排版
  Widget _buildGridViewLayout(videoChapterList) {
    double fontSize = 18;
    // 文字颜色
    Color defaultFontColor = Colors.white;
    Color playFontColor = Colors.redAccent;
    // 边框样式
    // 边框颜色
    Color borderColor = Colors.white38;
    Color playBorderColor = Colors.redAccent;
    // 边框宽度
    double borderWidth = 1.0;
    double playBorderWidth = borderWidth * 2;
    // 边框圆角
    double borderRadius = 6.0;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, //每行四列
          childAspectRatio: 1.0, //显示区域宽高相等
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemCount: videoChapterList.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> videoModel = videoChapterList[index];
        late ShapeBorder shape;
        late Color fontColor;
        return GetBuilder<PlayerGetxController>(
            id: GetxUpdateId.videoChapterGridViewLayout,
            builder: (_) {
              if (videoModel["path"] == _.videoInfoParams.playVideoChapter) {
                shape = RoundedRectangleBorder(
                  //边框颜色
                    side: BorderSide(
                      color: playBorderColor,
                      width: playBorderWidth,
                    ),
                    //边框圆角
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ));
                fontColor = playFontColor;
              } else {
                shape = RoundedRectangleBorder(
                  //边框颜色
                    side: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                    //边框圆角
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ));
                fontColor = defaultFontColor;
              }

              return MaterialButton(
                //边框样式
                shape: shape,
                onPressed: () {
                  _.videoInfoParams.playVideoChapter = videoModel["path"];
                },
                child: Text(
                  videoModel["name"],
                  style: TextStyle(fontSize: fontSize, color: fontColor),
                ),
              );
            });
      },
    );
  }
}
