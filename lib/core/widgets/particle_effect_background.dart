import 'dart:math';

import 'package:flutter/material.dart';

/// Widget para crear un efecto de partículas animadas como fondo decorativo
class ParticleEffectBackground extends StatefulWidget {
  final int particleCount;
  final Color particleColor;
  final double maxParticleSize;
  final double particleOpacity;
  final int? seed;
  final Duration animationDuration;

  const ParticleEffectBackground({
    super.key,
    this.particleCount = 8,
    this.particleColor = Colors.white,
    this.maxParticleSize = 6.0,
    this.particleOpacity = 0.6,
    this.seed,
    this.animationDuration = const Duration(seconds: 30),
  });

  @override
  State<ParticleEffectBackground> createState() =>
      _ParticleEffectBackgroundState();
}

class _ParticleEffectBackgroundState extends State<ParticleEffectBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat();

    _initializeParticles();
  }

  @override
  void didUpdateWidget(ParticleEffectBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.particleCount != widget.particleCount ||
        oldWidget.seed != widget.seed) {
      _initializeParticles();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeParticles() {
    final random = widget.seed ?? DateTime.now().millisecondsSinceEpoch;
    _particles = List.generate(widget.particleCount, (index) {
      return Particle.generate(
        index: index,
        randomSeed: random,
        maxSize: widget.maxParticleSize,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: _buildAnimatedParticles(
                constraints.maxWidth,
                constraints.maxHeight,
                _controller.value,
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildAnimatedParticles(
    double maxWidth,
    double maxHeight,
    double animationValue,
  ) {
    return _particles.map((particle) {
      // Calcular posición animada
      final offsetX =
          particle.initialX +
          (maxWidth * particle.xSpeed * animationValue * 2) % maxWidth;
      final offsetY =
          particle.initialY +
          (maxHeight * particle.ySpeed * animationValue * 2) % maxHeight;

      return Positioned(
        left: offsetX,
        top: offsetY,
        child: Opacity(
          opacity: widget.particleOpacity * particle.opacityFactor,
          child: Container(
            width: particle.size,
            height: particle.size,
            decoration: BoxDecoration(
              color: widget.particleColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.particleColor.withOpacity(
                    widget.particleOpacity * particle.opacityFactor / 2,
                  ),
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}

class Particle {
  final double initialX;
  final double initialY;
  final double size;
  final double xSpeed;
  final double ySpeed;
  final double opacityFactor;

  Particle({
    required this.initialX,
    required this.initialY,
    required this.size,
    required this.xSpeed,
    required this.ySpeed,
    required this.opacityFactor,
  });

  factory Particle.generate({
    required int index,
    required int randomSeed,
    required double maxSize,
  }) {
    final random = Random(randomSeed + index);

    return Particle(
      initialX:
          random.nextDouble() *
          300, // Valor inicial será ajustado en el LayoutBuilder
      initialY: random.nextDouble() * 300,
      size: (random.nextDouble() * 0.5 + 0.5) * maxSize,
      xSpeed: (random.nextDouble() * 0.2 + 0.1) * (random.nextBool() ? 1 : -1),
      ySpeed: (random.nextDouble() * 0.2 + 0.1) * (random.nextBool() ? 1 : -1),
      opacityFactor: random.nextDouble() * 0.5 + 0.5,
    );
  }
}
