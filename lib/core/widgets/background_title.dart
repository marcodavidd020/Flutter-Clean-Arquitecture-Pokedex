import 'package:flutter/material.dart';

class BackgroundTitle extends StatelessWidget {
  final String text;

  const BackgroundTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: - MediaQuery.of(context).size.width * 0.25,
      top: 35,
      child: SizedBox(
        width: 900,
        height: 300,
        child: Stack(
          children: [
            // Contorno con degradado
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.0),
                  ],
                  stops: [0.0, 0.76],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 80,
                  height: 1.19,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2.5
                    ..color = Colors.white, // Esto será afectado por ShaderMask
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Relleno transparente (simula texto hueco)
            Text(
              text.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 80,
                height: 1.19,
                color: Colors.transparent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
