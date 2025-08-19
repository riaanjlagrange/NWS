import 'package:flutter/material.dart';
import 'package:nws/components/videos_card.dart';
import 'package:nws/models/videos_categories_model.dart';
import 'package:nws/models/videos_model.dart';

class VideosPage extends StatefulWidget {
  final VideosCategories category;

  const VideosPage({super.key, required this.category});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final List<VideosModel> videos = [
    VideosModel(
      id: '1',
      title: 'Beginner Workout',
      thumbnailUrl: 'https://via.placeholder.com/300x180.png?text=Workout+1',
      videoUrl: 'https://example.com/workout1.mp4',
      category: VideosCategories.basic,
      createdAt: DateTime.now(),
    ),
    VideosModel(
      id: '2',
      title: 'Flutter Tutorial',
      thumbnailUrl: 'https://via.placeholder.com/300x180.png?text=Tutorial+1',
      videoUrl: 'https://example.com/tutorial1.mp4',
      category: VideosCategories.advanced,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final categoryVideos = videos
        .where((video) => video.category == widget.category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.label),
        backgroundColor: widget.category.color,
      ),
      body: ListView.builder(
        itemCount: categoryVideos.length,
        itemBuilder: (context, index) {
          final video = categoryVideos[index];
          return VideosCard(video: video);
        },
      ),
    );
  }
}
