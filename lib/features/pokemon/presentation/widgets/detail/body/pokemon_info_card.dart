import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

/// Widget para mostrar una tarjeta de información en la página de detalle
class PokemonInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const PokemonInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PokemonDetailConstants.infoCardPadding),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(
          PokemonDetailConstants.cardBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: PokemonDetailConstants.infoCardIconSize,
                color: Colors.grey.shade700,
              ),
              SizedBox(width: PokemonDetailConstants.tinySpacing),
              Text(
                title,
                style: TextStyle(
                  fontSize: PokemonDetailConstants.infoCardLabelFontSize,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: PokemonDetailConstants.tinySpacing),
          Text(
            value,
            style: TextStyle(
              fontSize: PokemonDetailConstants.infoCardValueFontSize,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
