import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  final Color color;
  final double size;

  const Loader({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSquareCircle(color: color, size: size),
    );
  }
}
