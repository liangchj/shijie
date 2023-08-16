
import 'package:flutter/material.dart';
import 'package:jin_player/config/getx_update_id.dart';
import 'package:video_player/video_player.dart';

import '../config/video_info_params.dart';
import '../control_method/abstract_player_method.dart';
import '../controller/player_controller.dart';
import '../ui/player_progress_bar.dart';


/// video_player方法（flutter官方提供的视频播放器）
class VideoPlayerMethod extends IVideoPlayerMethod {
  VideoPlayerMethod(this.playerGetxController);
  final PlayerGetxController playerGetxController;

  VideoPlayerController? _videoPlayerController; //video_player播放器Controller

  @override
  Future<void> onInitPlayer() async {
    //初始化播放器设置
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(playerGetxController.videoInfoParams.videoUrl));//..initialize();
    _videoPlayerController?.addListener(updateState);
    if (_videoPlayerController != null) {
      playerGetxController.playerParams.playerView = VideoPlayer(_videoPlayerController!);
    } else {
      playerGetxController.playerParams.playerView = Container();
    }
  }

  @override
  Future<void> onDisposePlayer() async {
    playerGetxController.playerParams.playerView = Container();
    _videoPlayerController?.removeListener(updateState);
    return await _videoPlayerController?.dispose();
  }

  @override
  Future<void> initialize() async {
    if (!_videoPlayerController!.value.isInitialized) {
      return await _videoPlayerController!.initialize();
    }
  }

  @override
  void changeVideoUrl({bool autoPlay = false}) {
    if (_videoPlayerController != null) {
      if (_videoPlayerController!.dataSource == playerGetxController.videoInfoParams.videoUrl) {
        return;
      }
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
      }
      playerGetxController.playerParams.playerView = Container();
      _videoPlayerController?.removeListener(updateState);
      _videoPlayerController?.dispose();
    }
    onInitPlayer();
    if (autoPlay) {
      _videoPlayerController?.initialize().then((value) => _videoPlayerController?.play());
    }
  }

  @override
  void updateState() {
    var value = _videoPlayerController!.value;
    // 视频是否加载错误
    if (value.hasError) {
      // 标记错误
      playerGetxController.loadError(value.errorDescription);
    } else {
      var buffered = value.buffered; // 缓冲信息
      List<BufferedDurationRange> bufferedDurationRange = [];
      if (buffered.isNotEmpty) {
        for (var element in buffered) {
          bufferedDurationRange.add(BufferedDurationRange(start: element.start, end: element.end));
        }
      }
      bool isFinished = false;
      // 监听是否播放完成
      if (value.position.compareTo(Duration.zero) > 0 &&
          value.duration.compareTo(Duration.zero) > 0 &&
          value.position.compareTo(value.duration) >= 0) {
        isFinished = true;
      } else {
        isFinished = false;
      }
      playerGetxController.updateVideoState(VideoPlayerInfo(
          isInitialized: value.isInitialized,
          isPlaying: value.isPlaying,
          duration: value.duration,
          positionDuration: value.position,
          bufferedDurationRange: bufferedDurationRange,
          isFinished: isFinished
      ));
    }
  }

  @override
  Future<void> play() async {
    if (!_videoPlayerController!.value.isInitialized) {
      return await _videoPlayerController!
          .initialize()
          .then((_) => _videoPlayerController!.play());
    } else {
      return await _videoPlayerController!.play();
    }
  }

  @override
  Future<void> pause() async {
    return await _videoPlayerController!.pause();
  }

  @override
  Future<void> entryFullScreen() async {
    return await pause();
  }

  @override
  Future<void> exitFullScreen() async {
    pause();
    //Get.back();
  }

  @override
  Future<void> seekTo(Duration position) async {
    return await _videoPlayerController!.seekTo(position);
  }

  @override
  Future<void> setPlaybackSpeed(double speed) async {
    return await _videoPlayerController!.setPlaybackSpeed(speed);
  }

  @override
  Future<void> setVolume(double volume) async {
    _videoPlayerController?.setVolume(volume);
  }

}