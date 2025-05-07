import 'package:flutter/material.dart';

class PokemonDetailSectionCard extends StatelessWidget {
  const PokemonDetailSectionCard({
    super.key,
    required this.mainType,
    required this.child,
    required this.backgroundColor,
  });

  final Color mainType;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Fondo con patrón de burbujas o círculos
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.6),
                      mainType.withOpacity(0.05),
                    ],
                  ),
                ),
                child: CustomPaint(
                  painter: DotPatternPainter(
                    dotColor: mainType.withOpacity(0.07),
                    dotSize: 6,
                    spacing: 30,
                  ),
                ),
              ),
            ),

            // Contenido real
            Padding(padding: const EdgeInsets.all(20), child: child),
          ],
        ),
      ),
    );
  }
}

// Clase para crear un patrón de puntos en el fondo
class DotPatternPainter extends CustomPainter {
  final Color dotColor;
  final double dotSize;
  final double spacing;

  DotPatternPainter({
    required this.dotColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize / 2, Paint()..color = dotColor);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
