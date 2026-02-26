import 'package:flutter/material.dart';

class LaraLogo extends StatelessWidget {
  final double size;

  const LaraLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _LaraLogoPainter()),
    );
  }
}

class _LaraLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Paint para a forma principal (Digital Indigo)
    final paintIndigo = Paint()
      ..color = const Color(0xFF6366F1)
      ..style = PaintingStyle.fill;

    // Paint para a forma de destaque (Electric Cyan)
    final paintCyan = Paint()
      ..color = const Color(0xFF06B6D4)
      ..style = PaintingStyle.fill;

    // 1. Forma da Esquerda (A haste robusta do L)
    final pathLeft = Path()
      ..moveTo(w * 0.20, h * 0.35)
      ..lineTo(w * 0.45, h * 0.10)
      ..lineTo(w * 0.45, h * 0.65)
      ..lineTo(w * 0.20, h * 0.90)
      ..close();
    canvas.drawPath(pathLeft, paintIndigo);

    // 2. Forma do Topo Direita (O detalhe superior)
    final pathTopRight = Path()
      ..moveTo(w * 0.50, h * 0.10)
      ..lineTo(w * 0.65, h * 0.10)
      ..lineTo(w * 0.65, h * 0.55)
      ..lineTo(w * 0.50, h * 0.70)
      ..close();
    final paintCyanTransparent = Paint()
      ..color = const Color(0xFF06B6D4)
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF06B6D4).withValues(alpha: 0.8);
    canvas.drawPath(pathTopRight, paintCyanTransparent);

    // 3. Forma da Base (A perna do L que dá direção)
    final pathBottom = Path()
      ..moveTo(w * 0.50, h * 0.55)
      ..lineTo(w * 0.85, h * 0.90)
      ..lineTo(w * 0.60, h * 0.90)
      ..lineTo(w * 0.45, h * 0.75)
      ..close();
    canvas.drawPath(pathBottom, paintCyan);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
