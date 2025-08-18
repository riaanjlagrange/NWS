import 'package:flutter/material.dart';
import 'package:nws/models/video_model.dart';

class VideosDetailPage extends StatelessWidget {
  final VideoModel video;

  const VideosDetailPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(video.title)),
      body: Column(
        children: [
          Image.network(video.thumbnailUrl),
          const SizedBox(height: 20),
          Text(
            video.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
