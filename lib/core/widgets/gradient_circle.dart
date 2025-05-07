import 'package:flutter/material.dart';

class GradientCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide * 0.48); // 96% del tamaño para el radio
    const strokeWidth = 6.0;

    final gradient = LinearGradient(
      begin: Alignment(-0.008, 1.0),
      end: Alignment(-0.776, -0.616),
      colors: [Colors.white.withOpacity(0.35), Colors.white.withOpacity(0)],
      stops: const [0.0, 0.42247],
    );

    final paint =
        Paint()
          ..shader = gradient.createShader(
            Rect.fromLTWH(0, 0, size.width, size.height),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
