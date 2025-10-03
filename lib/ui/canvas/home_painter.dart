import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class HomePainter extends CustomPainter {
  ui.Image? logoImage;  // Загрузка Лого
  bool _imagesLoaded = false;

  HomePainter(){
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      await _loadLogo();
      _imagesLoaded = true;
    } catch (e) {
      print('Error loading image: $e');
    }
  }

  Future<void> _loadLogo() async {
    try {
      final ByteData data = await rootBundle.load('AppMaterial/TimilessLogo.png');
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      logoImage = frame.image;
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();


    // Фон с градиентом
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF212226), Color(0xFF1A1A1D)],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Центральный логотип
    if (logoImage != null) {
      final imageSize = Size(363, 240);
      final imageOffset = Offset(
        (size.width - imageSize.width) / 2,
        (size.height - imageSize.height) / 2 - 50,
      );
      canvas.drawImageRect(
        logoImage!,
        Rect.fromLTWH(0, 0, logoImage!.width.toDouble(), logoImage!.height.toDouble()),
        Rect.fromLTWH(imageOffset.dx, imageOffset.dy, imageSize.width, imageSize.height),
        Paint(),
      );
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}