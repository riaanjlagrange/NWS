import 'package:flutter/material.dart';

abstract class NavPage extends Widget {
  const NavPage({super.key});
  String get title;
  List<Widget> get appBarActions => [];
}
