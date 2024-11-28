import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:midea_playar/screen/video/provider.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    context.read<VideoProvider>().initVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
          height: 250,
          child: Chewie(
              controller: context.read<VideoProvider>().chewieController!)),
    );
  }
}
