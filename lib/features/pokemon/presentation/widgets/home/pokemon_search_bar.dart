import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

class PokemonSearchBar extends StatelessWidget {
  const PokemonSearchBar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.searchDescription,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(
                PresentationConstants.borderRadiusMedium,
              ),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            // padding: const EdgeInsets.symmetric(
            //   horizontal: PresentationConstants.paddingMedium,
            // ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey.shade600),
                // const SizedBox(width: PresentationConstants.paddingMedium),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: AppTexts.searchHint,
                      border: InputBorder.none,
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}