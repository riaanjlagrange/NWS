import 'package:flutter/material.dart';
import 'package:nws/pages/videos/videos_card.dart';
import 'package:nws/models/videos_categories_model.dart';
import 'package:nws/models/videos_model.dart';

class VideosPage extends StatefulWidget {
  final VideosCategories category;

  const VideosPage({super.key, required this.category});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  // list of placeholder videos until firebase storage integration
  final List<VideosModel> videos = [
    VideosModel(
      id: '1',
      title: 'Basics sample 1',
      thumbnailUrl: 'https://placehold.co/300x180.png',
      videoUrl: 'https://example.com/workout1.mp4',
      category: VideosCategories.basic,
      createdAt: DateTime.now(),
    ),
    VideosModel(
      id: '2',
      title: 'Basics sample 2',
      thumbnailUrl: 'https://placehold.co/300x180.png',
      videoUrl: 'https://example.com/tutorial1.mp4',
      category: VideosCategories.basic,
      createdAt: DateTime.now(),
    ),
    VideosModel(
      id: '3',
      title: 'Intermediate sample 1',
      thumbnailUrl: 'https://placehold.co/300x180.png',
      videoUrl: 'https://example.com/tutorial1.mp4',
      category: VideosCategories.intermediate,
      createdAt: DateTime.now(),
    ),
    VideosModel(
      id: '4',
      title: 'Intermediate sample 2',
      thumbnailUrl: 'https://placehold.co/300x180.png',
      videoUrl: 'https://example.com/tutorial1.mp4',
      category: VideosCategories.intermediate,
      createdAt: DateTime.now(),
    ),
    VideosModel(
      id: '5',
      title: 'Advanced sample 1',
      thumbnailUrl: 'https://placehold.co/300x180.png',
      videoUrl: 'https://example.com/tutorial1.mp4',
      category: VideosCategories.advanced,
      createdAt: DateTime.now(),
    ),
    VideosModel(
      id: '6',
      title: 'Advanced sample 2',
      thumbnailUrl: 'https://placehold.co/300x180.png',
      videoUrl: 'https://example.com/tutorial1.mp4',
      category: VideosCategories.advanced,
      createdAt: DateTime.now(),
    ),
    VideosModel(
      id: '7',
      title: 'Advanced sample 3',
      thumbnailUrl: 'https://placehold.co/300x180.png',
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
