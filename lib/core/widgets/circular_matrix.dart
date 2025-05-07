import 'package:flutter/material.dart';
import '../constants/pokedex_spacing.dart';

class CircularMatrix extends StatelessWidget {
  const CircularMatrix({
    super.key,
    this.rows = 1,
    this.columns = 1,
    this.size = PokedexSpacing.kS,
    this.spaceBetween = PokedexSpacing.kS,
    this.color = Colors.white,
  });

  final int rows;
  final int columns;
  final double size;
  final double spaceBetween;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: List.generate(
          10,
          (index) => color.withOpacity(index / 9),
        ),
      ).createShader(bounds),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          rows,
          (row) => Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              columns,
              (col) => Padding(
                padding: EdgeInsets.only(
                  right: spaceBetween,
                  bottom: spaceBetween,
                ),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
