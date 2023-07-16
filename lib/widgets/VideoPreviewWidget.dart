import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'VideoFullScreenWidget.dart';

class VideoPreviewWidget extends StatelessWidget {
  final String? videoUrl;

  VideoPreviewWidget({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    if (videoUrl == null) {
      // Mostrar placeholder
      return const Placeholder(
        fallbackHeight: 150,
      );
    } else {
      ChewieController chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(videoUrl!),
        autoPlay: false,
        looping: false,

      );

      return GestureDetector(
        onTap: () {
          Get.to(
            FullScreenVideoPage(videoUrl: videoUrl!),
            transition: Transition.fadeIn,
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Chewie(
            controller: chewieController,
          ),
        ),
      );
    }
  }
}