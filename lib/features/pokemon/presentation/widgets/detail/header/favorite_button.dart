import 'package:flutter/material.dart';

/// Botón de favoritos con animación para la página de detalle
class FavoriteButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isFavorite;
  final Color backgroundColor;
  final Color iconColor;

  const FavoriteButton({
    super.key,
    required this.onPressed,
    this.isFavorite = false,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.red,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });

              if (_isFavorite) {
                _controller.forward(from: 0.0);
              }

              widget.onPressed();
            },
            customBorder: const CircleBorder(),
            splashColor: widget.iconColor.withOpacity(0.1),
            highlightColor: widget.iconColor.withOpacity(0.05),
            child: Ink(
              decoration: BoxDecoration(
                color: widget.backgroundColor.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.iconColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
