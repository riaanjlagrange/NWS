import 'package:flutter/material.dart';
import 'package:nws/models/videos_categories_model.dart';
import 'package:nws/models/videos_model.dart';

class VideosDetailPage extends StatelessWidget {
  final VideosModel video;

  const VideosDetailPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(video.title)),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // TODO: replace thumnail with actual video
            Container(
              width: double.infinity,
              child: Center(child: Image.network(video.thumbnailUrl)),
            ),
            const SizedBox(height: 20),
            Text(
              video.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Chip(
              label: Text(
                video.category.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: video.category.color,
              labelStyle: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
