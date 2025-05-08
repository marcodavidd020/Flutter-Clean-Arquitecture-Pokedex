import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

BoxDecoration cardBoxDecoration(Color bgColor) {
  return BoxDecoration(
    color: bgColor,
    borderRadius: BorderRadius.circular(PokemonCardConstants.borderRadius),
    boxShadow: [
      BoxShadow(
        color: bgColor.withOpacity(0.4),
        spreadRadius: 0,
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
