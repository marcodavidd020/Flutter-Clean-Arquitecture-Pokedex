/// Utilidades para manipulación de strings
extension StringUtils on String {
  /// Convierte la primera letra a mayúscula
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
} 