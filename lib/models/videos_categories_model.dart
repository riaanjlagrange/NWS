import 'package:flutter/material.dart';

enum VideosCategories { basic, intermediate, advanced, expert, bonus }

extension VideosCategoriesExtension on VideosCategories {
  String get label {
    switch (this) {
      case VideosCategories.basic:
        return 'Basic';
      case VideosCategories.intermediate:
        return 'Intermediate';
      case VideosCategories.advanced:
        return 'Advanced';
      case VideosCategories.expert:
        return 'Expert';
      case VideosCategories.bonus:
        return 'Bonus';
    }
  }

  Color get color {
    switch (this) {
      case VideosCategories.basic:
        return Colors.blueAccent;
      case VideosCategories.intermediate:
        return Colors.redAccent;
      case VideosCategories.advanced:
        return Colors.greenAccent;
      case VideosCategories.expert:
        return Colors.orangeAccent;
      case VideosCategories.bonus:
        return Colors.purpleAccent;
    }
  }
}
