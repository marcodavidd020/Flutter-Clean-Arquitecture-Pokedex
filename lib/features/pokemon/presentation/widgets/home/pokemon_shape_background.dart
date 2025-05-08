import 'package:flutter/material.dart';

class ShapeBackground extends StatelessWidget {
  const ShapeBackground({super.key, required this.bgColor});

  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
      ),
    );
  }
}
