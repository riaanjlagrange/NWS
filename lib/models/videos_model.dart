import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nws/models/videos_categories_model.dart';

class VideosModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final VideosCategories category;
  final String? description;
  final String? uploaderId;
  final DateTime createdAt;

  VideosModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.category,
    this.description,
    this.uploaderId,
    required this.createdAt,
  });

  factory VideosModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return VideosModel(
      id: doc.id,
      title: data['title'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      category: VideosCategories.values.firstWhere(
        (c) => c.toString() == 'VideoCategory.${data['category']}',
        orElse: () => VideosCategories.bonus,
      ),
      description: data['description'],
      uploaderId: data['uploaderId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'category': category.name,
      'description': description,
      'uploaderId': uploaderId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
