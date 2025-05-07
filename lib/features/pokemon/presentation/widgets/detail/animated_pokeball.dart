import 'package:flutter/material.dart';

/// Widget que muestra una Pokebola animada con rotación
class AnimatedPokeball extends StatelessWidget {
  final double size;
  final AnimationController controller;
  final double opacity;

  const AnimatedPokeball({
    super.key,
    required this.size,
    required this.controller,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.value * 2 * 3.14159,
          child: Opacity(opacity: opacity, child: _buildPokeball(size)),
        );
      },
    );
  }

  Widget _buildPokeball(double size) {
    // En caso de que la imagen no se cargue correctamente, dibujamos una pokébola básica
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Center(
        child: CustomPaint(size: Size(size, size), painter: _PokeballPainter()),
      ),
    );
  }
}

/// Painter para dibujar una pokebola básica
class _PokeballPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2;

    // Pintura para el círculo exterior
    final paintRed =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;

    final paintWhite =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    // Pintura para la línea central
    final paintBlack =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.05;

    // Pintura para el círculo central
    final paintButton =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final paintButtonBorder =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.02;

    // Dibujar mitad superior (roja)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      0,
      3.14159,
      true,
      paintRed,
    );

    // Dibujar mitad inferior (blanca)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      3.14159,
      3.14159,
      true,
      paintWhite,
    );

    // Dibujar línea central
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      paintBlack,
    );

    // Dibujar círculo central (botón)
    canvas.drawCircle(Offset(centerX, centerY), radius * 0.2, paintButton);

    // Borde del círculo central
    canvas.drawCircle(
      Offset(centerX, centerY),
      radius * 0.2,
      paintButtonBorder,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
