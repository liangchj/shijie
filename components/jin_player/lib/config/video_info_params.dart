
import '../ui/player_progress_bar.dart';

/// 视频基本信息
class VideoInfoParams {
  String videoUrl = ""; // 视频播放路径
  String? cover; // 视频封面

  Duration duration = Duration.zero; // 总时长


  // 视频章节列表
  var videoChapterList = <Map<String, dynamic>>[];
  var maxVideoNameLen = 0;
  var playVideoChapter = "";

}

class VideoPlayerInfo {
  const VideoPlayerInfo(
      {required this.isInitialized,
        required this.isPlaying,
        required this.duration,
        required this.positionDuration,
        required this.bufferedDurationRange,
        required this.isFinished});
  final bool isInitialized;
  final bool isPlaying;
  final Duration duration;
  final Duration positionDuration;
  final List<BufferedDurationRange> bufferedDurationRange;
  final bool isFinished;
}
