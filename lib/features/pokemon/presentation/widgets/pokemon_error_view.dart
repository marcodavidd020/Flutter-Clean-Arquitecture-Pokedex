import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

class PokemonErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const PokemonErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PresentationConstants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: PresentationConstants.paddingLarge),
            Text(
              AppTexts.errorTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: PresentationConstants.paddingMedium),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: PresentationConstants.paddingXLarge),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(AppTexts.retryText),
            ),
          ],
        ),
      ),
    );
  }
}
