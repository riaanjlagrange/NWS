import 'package:flutter/material.dart';
import 'package:nws/models/videos_model.dart';
import 'package:nws/pages/videos/videos_detail_page.dart';

class VideosCard extends StatelessWidget {
  final VideosModel video;

  const VideosCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => VideosDetailPage(video: video)),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              video.thumbnailUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                video.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
