import 'package:flutter/material.dart';

class PokemonHeaderBackButton extends StatelessWidget {
  const PokemonHeaderBackButton({
    super.key,
    required this.onBackPressed,
    required this.context,
    // required this.dominantColor,
  });

  final VoidCallback onBackPressed;
  final BuildContext context;
  // final Color dominantColor;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white.withOpacity(0.9),
        elevation: 4,
        shadowColor: Colors.black26,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onBackPressed,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back, color: Colors.black87, size: 20),
          ),
        ),
      ),
    );
  }
}

