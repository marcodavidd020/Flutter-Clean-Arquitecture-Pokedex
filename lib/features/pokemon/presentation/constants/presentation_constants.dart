// Constantes para la capa de presentación de la aplicación Pokédex
// Organizadas por componentes y categorías
import 'package:flutter/material.dart';

/// Constantes globales de presentación
class PresentationConstants {
  // Dimensiones comunes
  static const double paddingSmall = 10.0;
  static const double paddingMedium = 20.0;
  static const double paddingLarge = 30.0;
  static const double paddingXLarge = 40.0;
  static const double paddingXXLarge = 50.0;

  // Dimensiones de bordes
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 16.0;
  static const double borderRadiusLarge = 20.0;
  static const double borderRadiusXLarge = 30.0;

  // Dimensiones de elevación
  static const double elevationSmall = 1.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;

  // Opacidades
  static const double opacityLight = 0.1;
  static const double opacityMedium = 0.3;
  static const double opacityHigh = 0.6;
  static const double opacityFull = 1.0;

  // Duraciones de animaciones
  static const Duration animationShort = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 500);
  static const Duration animationLong = Duration(milliseconds: 1000);
  static const Duration animationXLong = Duration(milliseconds: 1500);
  static const Duration animationXXLong = Duration(milliseconds: 3000);
}

/// Constantes para las tarjetas de Pokémon
class PokemonCardConstants {
  // Aspect Ratio
  static const double cardAspectRatio = 3.3;

  static const int cardCrossAxisCount = 1;
  static const double cardCrossAxisSpacing = 25.0;
  static const double cardMainAxisSpacing = 35.0;

  // Información del Pokémon
  static const double informationPadding = 20.0;
  static const double informationPaddingTop = 16.0;
  static const double informationPaddingLeft = 20.0;
  static const double informationPaddingRight = 20.0;
  static const double informationPaddingBottom = 16.0;

  static const double numberFontSize = 8.0;
  static const double nameFontSize = 17.0;

  //color
  static Color numberColor = Colors.black.withOpacity(0.6);
  static const Color nameColor = Colors.white;

  // Animation
  static const double animationScaleEnd = 0.95;
  static const double animationScaleStart = 1.0;

  // Dimensiones y proporciones
  static const double borderRadius = 10.0;
  static const double borderRadiusType = 3.0;

  // Patrones de puntos
  static const int rowsPoints = 3;
  static const int columnsPoints = 6;
  static const double sizePoints = 5.0;
  static const double spaceBetweenPoints = 10.0;
  static const Color colorPoints = Colors.white;
  static const double opacityPoints = 0.3;
  static const double positionPointsLeft = 110.0;
  static const double positionPointsTop = 5.0;

  // Tamaños de texto

  // Image Pokeball fondo
  static const double pokeballSize = 155.0;
  static const double positionPokeballRight = -10.0;
  static const double positionPokeballBottom = -15.0;
  static const double positionPokeballOpacity = 0.3;
  static const double positionPokeballGradientOpacity = 0.0;
  static const Color pokeballColor = Colors.white;
}

/// Constantes para la página de detalle
class PokemonDetailConstants {
  // Dimensiones y proporciones
  static const double headerHeight = 340.0;
  static const double imageSize = 220.0;
  static const double infoCardBorderRadius = 20.0;
  static const double idBadgeBorderRadius = 20.0;
  static const double appBarHeight = 300.0;
  static const double pokemonImageSize = 135.0;
  static const double pokemonNumberFontSize = 11.0;
  static const double pokemonNameFontSize = 20.0;
  static const double sectionTitleFontSize = 20.0;
  static const double infoCardPadding = 12.0;
  static const double cardBorderRadius = 12.0;
  static const double infoCardIconSize = 18.0;
  static const double infoCardValueFontSize = 16.0;
  static const double infoCardLabelFontSize = 14.0;
  static const double sectionSpacing = 20.0;
  static const double itemSpacing = 4.0;
  static const double smallSpacing = 10.0;
  static const double tinySpacing = 6.0;
  static const double favoriteButtonSize = 24.0;
  static const double statBarHeight = 10.0;
  static const double statIconSize = 16.0;
  static const double statValueFontSize = 14.0;
  static const double statLabelFontSize = 13.0;

  // Opacidades
  static const double backgroundPatternOpacity = 0.2;
  static const double pokeballBackgroundOpacity = 1;
  static const double backButtonBackgroundOpacity = 0.9;
  static const double pokemonNumberOpacity = 0.6;
  static const double statBarBackgroundOpacity = 0.2;
  static const double favoriteButtonBackgroundOpacity = 0.9;

  // Tamaños de texto
  static const double titleFontSize = 28.0;
  static const double subtitleFontSize = 18.0;
  static const double bodyFontSize = 14.0;

  // Animaciones
  static const Duration rotationDuration = Duration(seconds: 20);
  static const double pokeballScale = 2.8;
  static const Duration loadingAnimationDuration = Duration(milliseconds: 1500);
  static const Duration pulseAnimationDuration = Duration(milliseconds: 800);
  static const Duration favoriteAnimationDuration = Duration(milliseconds: 300);
  static const Duration statBarAnimationDuration = Duration(milliseconds: 1000);
}

/// Constantes para los tipos de Pokémon
class PokemonTypeConstants {
  // Dimensiones de chips
  static const double chipPaddingHorizontalSmall = 8.0;
  static const double chipPaddingHorizontalLarge = 16.0;
  static const double chipPaddingVerticalSmall = 4.0;
  static const double chipPaddingVerticalLarge = 8.0;
  static const double chipBorderRadiusSmall = 12.0;
  static const double chipBorderRadiusLarge = 20.0;

  // Tamaños de texto e iconos
  static const double iconSizeSmall = 12.0;
  static const double iconSizeLarge = 16.0;
  static const double textSizeSmall = 10.0;
  static const double textSizeLarge = 14.0;
}

/// Constantes para la cadena evolutiva
class EvolutionChainConstants {
  static const double cardBorderRadius = 16.0;
  static const double spacing = 16.0;
  static const double smallSpacing = 8.0;
  static const double tinySpacing = 4.0;
  static const double pokemonImageSize = 70.0;
  static const double pokemonImageBackground = 86.0;
  static const double arrowSize = 24.0;
  static const double pillBorderRadius = 12.0;
  static const double backgroundOpacity = 0.2;
  static const double borderOpacity = 0.3;
}

/// Textos constantes de la aplicación
class AppTexts {
  // Textos de la página principal
  static const String appTitle = 'Pokédex';
  static const String searchHint = '¿Qué Pokémon estás buscando?';
  static const String searchDescription =
      'Busca un Pokémon por nombre o por su número en la Pokédex Nacional.';

  // Textos de la página de detalle
  static const String infoBasicTitle = 'Información básica';
  static const String statsTitle = 'Estadísticas';
  static const String weaknessesTitle = 'Debilidades';
  static const String evolutionsTitle = 'Evoluciones';
  static const String evolutionTriggerText = 'Evoluciona';
  static const String heightLabel = 'Altura';
  static const String weightLabel = 'Peso';
  static const String typesTitle = 'Tipos';
  static const String noEvolutionsMessage = 'Este Pokémon no tiene evoluciones';
  static const String noEvolutionsErrorMessage =
      'No se pudieron cargar las evoluciones';
  static const String loadingText = 'Cargando...';
  static const String tradeTriggerText = 'Intercambio';
  static const String highHappinessTriggerText = 'Felicidad alta';
  static const String dayTriggerText = 'Durante el día';
  static const String nightTriggerText = 'Durante la noche';
  // Descripciones
  static const String bulbasaurDescription =
      'Este Pokémon puede ser visto durmiendo bajo la luz brillante del sol. Hay una semilla en su lomo. Al absorber los rayos del sol, la semilla crece progresivamente más grande.';
  static const String defaultDescription =
      'Este Pokémon tiene características únicas que lo hacen especial en su tipo. Los entrenadores lo valoran por sus habilidades en combate y su lealtad.';

  // Mensajes de error
  static const String retryText = 'Reintentar';
  static const String errorTitle = 'Ha ocurrido un error';
  static const String connectionErrorMessage =
      'Parece que hay un problema de conexión. Por favor, verifica tu conexión a internet e intenta nuevamente.';

  // imagenes
  static const String pokeballImage = 'assets/images/pokeball.png';
}

/// Constantes para el placeholder de carga de imágenes
class ImagePlaceholderConstants {
  static const double pokeballSize = 100.0;
  static const double glowSize = 70.0;
  static const double pokeballOpacity = 0.7;
  static const double glowInitialOpacity = 0.5;
  static const double glowFinalOpacity = 1.0;
}

/// Constantes para las estadísticas de Pokémon
class PokemonStatConstants {
  // Valores máximos de referencia
  static const int maxStatValue = 255;
  static const int lowStatThreshold = 50;
  static const int mediumStatThreshold = 80;
  static const int highStatThreshold = 100;
  static const int veryHighStatThreshold = 150;

  // Visualización
  static const double barHeight = 10.0;
  static const double barBorderRadius = 5.0;
  static const double verticalPadding = 8.0;
  static const double iconTextSpacing = 10.0;
  static const double valueIconSize = 18.0;
  static const double valueBadgeRadius = 10.0;
  static const double shimmerHeight = 14.0;

  // Colores para cada nivel de estadística
  static const Color lowStatColor = Colors.redAccent;
  static const Color mediumStatColor = Colors.orangeAccent;
  static const Color highStatColor = Color(0xFFFFD740); // amberAccent[700]
  static const Color veryHighStatColor = Colors.lightGreen;
  static const Color maxStatColor = Colors.green;
}

/// Constantes para el efecto de partículas
class ParticleEffectConstants {
  static const double particleSize = 8.0;
  static const double particleOpacity = 0.8;
  static const int particleCount = 20;
  static const int particleSeed = 1234567890;
  static const Color particleColor = Colors.white;
}

//Contantes contenido inicial
class InitialContentConstants {
  static const double titleFontSize = 20.0;
}
