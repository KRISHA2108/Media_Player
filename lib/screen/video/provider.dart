import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProvider with ChangeNotifier {
  VideoPlayerController? videoController;
  ChewieController? chewieController;

  Future<void> initVideo() async {
    videoController = VideoPlayerController.asset('lib/assets/video/10.mp4')
      ..initialize();

    chewieController = ChewieController(
      videoPlayerController: videoController!,
      autoPlay: true,
      looping: true,
    );
    notifyListeners();
  }
}
