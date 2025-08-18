import 'package:flutter/material.dart';
import 'package:nws/models/video_model.dart';

class VideosAddPage extends StatefulWidget {
  const VideosAddPage({super.key});

  @override
  State<VideosAddPage> createState() => _VideosAddPageState();
}

class _VideosAddPageState extends State<VideosAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _thumbnailController = TextEditingController();
  final _videoUrlController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _thumbnailController.dispose();
    _videoUrlController.dispose();
    super.dispose();
  }

  void _saveVideo() {
    if (_formKey.currentState!.validate()) {
      final newVideo = VideoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // temp ID
        title: _titleController.text,
        thumbnailUrl: _thumbnailController.text,
        videoUrl: _videoUrlController.text,
        createdAt: DateTime.now(),
      );

      Navigator.pop(context, newVideo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Video')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Video Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                controller: _thumbnailController,
                decoration: const InputDecoration(labelText: 'Thumbnail URL'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter a thumbnail URL' : null,
              ),
              TextFormField(
                controller: _videoUrlController,
                decoration: const InputDecoration(labelText: 'Video URL'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter a video URL' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveVideo,
                child: const Text('Save Video'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
