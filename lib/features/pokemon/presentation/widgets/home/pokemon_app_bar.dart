import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonHomeTitle extends StatelessWidget {
  const PokemonHomeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        AppTexts.appTitle,
        style: GoogleFonts.poppins(
          fontSize: InitialContentConstants.titleFontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
