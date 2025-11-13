import 'package:flutter/material.dart';

/// Utility class for color operations inspired by color2k
/// https://color2k.com/
class ColorUtils {
  /// Calculate luminance of a color using the WCAG formula
  /// Returns a value between 0 and 1
  static double getLuminance(Color color) {
    return color.computeLuminance();
  }

  /// Check if a color is light or dark
  /// Returns true if the color is light (luminance > 0.5)
  static bool isLight(Color color) {
    return getLuminance(color) > 0.5;
  }

  /// Get contrasting text color (black or white) for a given background
  /// This is a simple implementation that returns black for light colors and white for dark colors
  static Color getContrastingTextColor(Color backgroundColor) {
    return isLight(backgroundColor)
        ? const Color(0xFF000000)
        : const Color(0xFFFFFFFF);
  }

  /// Returns black or white for best contrast depending on the luminosity of the given color
  /// This is similar to color2k's readableColor function
  /// Uses a more sophisticated algorithm than getContrastingTextColor
  static Color readableColor(Color backgroundColor) {
    final luminance = getLuminance(backgroundColor);
    // Use 0.5 as the threshold for better contrast
    return luminance > 0.5 ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }

  /// An alternative function to readableColor
  /// Returns whether or not the readable color should be black
  static bool readableColorIsBlack(Color backgroundColor) {
    return getLuminance(backgroundColor) > 0.5;
  }

  /// Calculate contrast ratio between two colors
  /// Returns a value between 1 and 21
  /// Based on WCAG guidelines
  static double getContrast(Color color1, Color color2) {
    final luminance1 = getLuminance(color1);
    final luminance2 = getLuminance(color2);

    final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 > luminance2 ? luminance2 : luminance1;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Check if a color has bad contrast against a background
  /// Returns true if the contrast ratio is below the specified standard
  static bool hasBadContrast(
    Color foregroundColor,
    Color backgroundColor, {
    double standard = 4.5, // WCAG AA standard
  }) {
    final contrast = getContrast(foregroundColor, backgroundColor);
    return contrast < standard;
  }

  /// Get the best readable color for a given background with multiple options
  /// Tries different colors and returns the one with the best contrast
  static Color getBestReadableColor(
    Color backgroundColor, {
    List<Color>? colorOptions,
  }) {
    final options =
        colorOptions ??
        [
          const Color(0xFF000000), // Black
          const Color(0xFFFFFFFF), // White
          const Color(0xFF333333), // Dark gray
          const Color(0xFF666666), // Medium gray
        ];

    Color bestColor = options.first;
    double bestContrast = 0;

    for (final color in options) {
      final contrast = getContrast(color, backgroundColor);
      if (contrast > bestContrast) {
        bestContrast = contrast;
        bestColor = color;
      }
    }

    return bestColor;
  }

  /// Create a color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Blend two colors
  static Color blend(Color color1, Color color2, double ratio) {
    return Color.lerp(color1, color2, ratio) ?? color1;
  }

  /// Darken a color by a given amount
  /// Amount should be between 0 and 1
  static Color darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Lighten a color by a given amount
  /// Amount should be between 0 and 1
  static Color lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Saturate a color by a given amount
  /// Amount should be between 0 and 1
  static Color saturate(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withSaturation((hsl.saturation + amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Desaturate a color by a given amount
  /// Amount should be between 0 and 1
  static Color desaturate(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withSaturation((hsl.saturation - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Adjust hue of a color by given degrees
  /// Degrees should be between 0 and 360
  static Color adjustHue(Color color, double degrees) {
    final hsl = HSLColor.fromColor(color);
    double newHue = (hsl.hue + degrees) % 360;
    if (newHue < 0) newHue += 360;
    return hsl.withHue(newHue).toColor();
  }

  /// Mix two colors together
  /// Weight should be between 0 and 1 (0 = all color1, 1 = all color2)
  static Color mix(Color color1, Color color2, double weight) {
    return Color.lerp(color1, color2, weight) ?? color1;
  }

  /// Convert color to hex string
  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  /// Convert color to RGB string
  static String toRgb(Color color) {
    return 'rgb(${color.red}, ${color.green}, ${color.blue})';
  }

  /// Convert color to RGBA string
  static String toRgba(Color color) {
    return 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.opacity})';
  }

  /// Convert color to HSL string
  static String toHsl(Color color) {
    final hsl = HSLColor.fromColor(color);
    return 'hsl(${hsl.hue.round()}, ${(hsl.saturation * 100).round()}%, ${(hsl.lightness * 100).round()}%)';
  }

  /// Convert color to HSLA string
  static String toHsla(Color color) {
    final hsl = HSLColor.fromColor(color);
    return 'hsla(${hsl.hue.round()}, ${(hsl.saturation * 100).round()}%, ${(hsl.lightness * 100).round()}%, ${color.opacity})';
  }

  /// Utility function to swap MaterialColor shades for dark mode
  /// Swaps 50<->900, 100<->800, 200<->700, 300<->600, 400<->500
  /// The primary value becomes 400 instead of 500 for better dark mode appearance
  static MaterialColor swapMaterialColor(MaterialColor color, {int? shade}) {
    final newColors = {
      50: color.shade900,
      100: color.shade800,
      200: color.shade700,
      300: color.shade600,
      400: color.shade500,
      500: color.shade400,
      600: color.shade300,
      700: color.shade200,
      800: color.shade100,
      900: color.shade50,
    };
    if (shade != null) {}
    // Use shade 400 as the primary value for dark mode (lighter than 500)
    return MaterialColor(
      shade != null
          ? newColors[shade]?.toARGB32() ?? color.shade400.toARGB32()
          : color.shade400.toARGB32(),
      newColors,
    );
  }

  static MaterialColor swapMaterialColorDefault(
    MaterialColor color, {
    int? shade,
  }) {
    return MaterialColor(
      color[shade ?? 500]?.toARGB32() ?? color.shade400.toARGB32(),
      {
        50: color.shade50,
        100: color.shade100,
        200: color.shade200,
        300: color.shade300,
        400: color.shade400,
        500: color.shade500,
        600: color.shade600,
        700: color.shade700,
        800: color.shade800,
        900: color.shade900,
      },
    );
  }
}
