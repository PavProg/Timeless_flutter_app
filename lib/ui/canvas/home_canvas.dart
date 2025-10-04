import 'package:flutter/material.dart';
import 'home_painter.dart';

class HomeCanvas extends StatelessWidget {
  const HomeCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: HomePainter(),
    );
  }
}
