import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
class PokemonAppBar extends StatelessWidget {
  const PokemonAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          PresentationConstants.paddingXLarge,
          48,
          PresentationConstants.paddingXLarge,
          PresentationConstants.paddingMedium,
        ),
        child: Center(
          child: Text(
            AppTexts.appTitle,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE74C3C),
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
