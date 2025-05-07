import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_section_title.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_type_chip.dart';

class PokemonInfoSection extends StatelessWidget {
  final Pokemon pokemon;
  final Color typeColor;

  const PokemonInfoSection({
    super.key,
    required this.pokemon,
    required this.typeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Información básica
        PokemonSectionTitle(title: AppTexts.infoBasicTitle, color: typeColor),
        const SizedBox(height: 16),
        _buildInfoRow(
          AppTexts.heightLabel,
          '${(pokemon.height / 10).toStringAsFixed(1)} m',
          Icons.straighten,
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          AppTexts.weightLabel,
          '${(pokemon.weight / 10).toStringAsFixed(1)} kg',
          Icons.fitness_center,
        ),
        const SizedBox(height: 20),
        PokemonSectionTitle(
          title: AppTexts.typesTitle,
          color: typeColor,
          fontSize: 18,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              pokemon.types.map((type) => PokemonTypeChip(type: type)).toList(),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: typeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 22, color: typeColor.withOpacity(0.8)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PokemonSectionTitle(
                title: label,
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              PokemonSectionTitle(
                title: value,
                fontSize: 18,
                color: Colors.grey.shade800,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
