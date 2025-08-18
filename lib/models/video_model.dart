import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final String? description;
  final DateTime createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.videoUrl,
    this.description,
    required this.createdAt,
  });

  // convert Firestore doc to Video
  factory VideoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return VideoModel(
      id: doc.id,
      title: data['title'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      description: data['description'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // convert Video to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
