import 'package:flutter/material.dart';
import 'package:nws/models/videos_categories_model.dart';
import 'package:nws/pages/nav_page.dart';
import 'package:nws/pages/videos/videos_page.dart';

class VideosCategoriesPage extends StatelessWidget implements NavPage {
  const VideosCategoriesPage({super.key});

  @override
  String get title => 'Video Categories';

  @override
  List<Widget> get appBarActions => [];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: VideosCategories.values.map((category) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => VideosPage(category: category)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: category.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                category.label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
