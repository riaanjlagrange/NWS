import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws/components/videos_card.dart';
import 'package:nws/models/video_model.dart';
import 'package:nws/pages/nav_page.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_state.dart';
import 'package:nws/pages/videos/videos_add_page.dart';

class VideosPage extends StatefulWidget implements NavPage {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();

  @override
  String get title => 'Videos';

  @override
  List<Widget> get appBarActions => _VideosPageState.actions;
}

class _VideosPageState extends State<VideosPage> {
  static List<Widget> actions = [];

  final List<VideoModel> videos = [
    VideoModel(
      id: '1',
      title: 'Sample Video 1',
      thumbnailUrl: 'https://via.placeholder.com/300x180.png?text=Video+1',
      videoUrl: 'https://example.com/video1.mp4',
      createdAt: DateTime.now(),
    ),
    VideoModel(
      id: '2',
      title: 'Sample Video 2',
      thumbnailUrl: 'https://via.placeholder.com/300x180.png?text=Video+2',
      videoUrl: 'https://example.com/video2.mp4',
      createdAt: DateTime.now(),
    ),
  ];

  void _addVideo(VideoModel video) {
    // add the video to the array
    setState(() {
      videos.add(video);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check if user is admin via AuthBloc
    final state = context.read<AuthBloc>().state;
    if (state is AuthAuthenticated && state.user.role == "admin") {
      // if admin is authenticated, add add video action
      actions = [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VideosAddPage()),
            );
            if (result != null && result is VideoModel) {
              _addVideo(result);
            }
          },
        ),
      ];
    } else {
      actions = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return VideosCard(video: video);
      },
    );
  }
}
