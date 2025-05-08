import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonAppBar extends StatelessWidget {
  const PokemonAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        AppTexts.appTitle,
        style: GoogleFonts.roboto(
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
