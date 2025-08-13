import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nws/core/constants.dart';

// Loading screen
class LoaderPage extends StatelessWidget {
  final Color color;
  final double size;

  const LoaderPage({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBGColor,
      child: Center(
        child: SpinKitFoldingCube(color: color, size: size),
      ),
    );
  }
}
