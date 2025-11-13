import 'package:blockin/theme/button_theme.dart';
import 'package:blockin/theme/colors/app_colors.dart';
import 'package:blockin/theme/colors/dark_colors.dart';
import 'package:blockin/theme/colors/light_colors.dart';
import 'package:blockin/theme/typography.dart';
import 'package:flutter/material.dart';

/// Theme Extension for Flutter's ThemeData
/// This integrates semantic colors with Flutter's theme system
class BlockinThemeExtension extends ThemeExtension<BlockinThemeExtension> {
  /// The semantic colors for this theme
  final IAppColors colors;

  const BlockinThemeExtension({required this.colors});

  @override
  BlockinThemeExtension copyWith({IAppColors? colors}) {
    return BlockinThemeExtension(colors: colors ?? this.colors);
  }

  @override
  BlockinThemeExtension lerp(
    ThemeExtension<BlockinThemeExtension>? other,
    double t,
  ) {
    if (other is! BlockinThemeExtension) {
      return this;
    }
    // For now, we'll just switch between themes at t = 0.5
    // In a more advanced implementation, you could interpolate colors
    return t < 0.5 ? this : other;
  }

  /// Get Blockin theme extension from the current theme data
  static BlockinThemeExtension of(ThemeData theme) {
    final extension = theme.extension<BlockinThemeExtension>();
    if (extension == null) {
      throw StateError(
        'BlockinThemeExtension not found in Theme. '
        'Make sure to add it using  BlockinTheme.lightTheme() or BlockinTheme.darkTheme()',
      );
    }
    return extension;
  }

  /// Try to get Blockin theme extension from the current theme data
  /// Returns null if not found
  static BlockinThemeExtension? maybeOf(ThemeData theme) {
    return theme.extension<BlockinThemeExtension>();
  }
}

/// Extension on ThemeData to easily access Blockin colors
extension BlockinThemeDataExtension on ThemeData {
  /// Get Blockin semantic colors from this theme
  ///
  /// Example:
  /// ```dart
  /// final colors = Theme.of(context).colors;
  /// Container(color: colors.primary);
  /// ```
  ///
  /// Throws if BlockinThemeExtension is not found in theme.
  IAppColors get colors {
    return BlockinThemeExtension.of(this).colors;
  }

  /// Try to get Blockin semantic colors from this theme
  ///
  /// Returns null if BlockinThemeExtension is not found.
  IAppColors? get colorsOrNull {
    return BlockinThemeExtension.maybeOf(this)?.colors;
  }
}

/// Main Blockin Theme class for creating Flutter themes
class BlockinTheme {
  const BlockinTheme._();

  /// Create a light theme with Blockin colors
  ///
  /// You can optionally provide a [baseTheme] to extend, [typography] to customize typography,
  /// [fontFamily] to change the default font family, or [buttonTheme] to customize button defaults.
  ///
  /// Example:
  /// ```dart
  /// // Default light theme
  /// final theme = BlockinTheme.lightTheme();
  ///
  /// // Custom font family
  /// final theme = BlockinTheme.lightTheme(
  ///   fontFamily: 'Roboto',
  /// );
  ///
  /// // Custom typography
  /// final theme = BlockinTheme.lightTheme(
  ///   typography: MyCustomTypography(),
  /// );
  ///
  /// // Custom button theme
  /// final theme = BlockinTheme.lightTheme(
  ///   buttonTheme: BlockinButtonThemeExtension(defaultRadius: BlockinRadiusType.large),
  /// );
  /// ```
  static ThemeData lightTheme({
    ThemeData? baseTheme,
    BlockinTypographyExtension? typography,
    String? fontFamily,
    BlockinButtonThemeExtension? buttonTheme,
  }) {
    final base = baseTheme ?? ThemeData.light();
    return _buildTheme(
      colors: const LightSemanticColors(),
      base: base,
      brightness: Brightness.light,
      typography: typography,
      fontFamily: fontFamily,
      buttonTheme: buttonTheme,
    );
  }

  /// Create a dark theme with Blockin colors
  ///
  /// You can optionally provide a [baseTheme] to extend, [typography] to customize typography,
  /// [fontFamily] to change the default font family, or [buttonTheme] to customize button defaults.
  ///
  /// Example:
  /// ```dart
  /// // Default dark theme
  /// final theme = BlockinTheme.darkTheme();
  ///
  /// // Custom font family
  /// final theme = BlockinTheme.darkTheme(
  ///   fontFamily: 'Roboto',
  /// );
  ///
  /// // Custom typography
  /// final theme = BlockinTheme.darkTheme(
  ///   typography: MyCustomTypography(),
  /// );
  ///
  /// // Custom button theme
  /// final theme = BlockinTheme.darkTheme(
  ///   buttonTheme: BlockinButtonThemeExtension(defaultRadius: BlockinRadiusType.large),
  /// );
  /// ```
  static ThemeData darkTheme({
    ThemeData? baseTheme,
    BlockinTypographyExtension? typography,
    String? fontFamily,
    BlockinButtonThemeExtension? buttonTheme,
  }) {
    return _buildTheme(
      colors: const DarkSemanticColors(),
      base: baseTheme ?? ThemeData.dark(),
      brightness: Brightness.dark,
      typography: typography,
      fontFamily: fontFamily,
      buttonTheme: buttonTheme,
    );
  }

  /// Internal helper to build theme with Blockin colors
  static ThemeData _buildTheme({
    required IAppColors colors,
    required ThemeData base,
    Brightness? brightness,
    BlockinTypographyExtension? typography,
    String? fontFamily,
    BlockinButtonThemeExtension? buttonTheme,
  }) {
    final effectiveTypography =
        typography ??
        BlockinTypographyExtension.defaultTheme(
          color: colors.foreground,
          fontFamily: fontFamily,
        );

    return base.copyWith(
      brightness: brightness,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      dividerColor: colors.divider,
      focusColor: colors.focus,

      extensions: [
        BlockinThemeExtension(colors: colors),
        effectiveTypography,
        buttonTheme ?? const BlockinButtonThemeExtension(),
        ...base.extensions.values,
      ],

      colorScheme: base.colorScheme.copyWith(
        brightness: brightness,
        primary: colors.primary,
        secondary: colors.secondary,
        error: colors.danger,
        surface: colors.background,
        onSurface: colors.foreground,
        onPrimary: colors.primaryReadableColor,
        onSecondary: colors.secondaryReadableColor,
        onError: colors.dangerReadableColor,
      ),

      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: colors.background,
        foregroundColor: colors.foreground,
      ),

      cardTheme: base.cardTheme.copyWith(color: colors.content1),
    );
  }

  /// Create a custom theme with your own colors
  ///
  /// You can optionally provide a [baseTheme] to extend, [typography] to customize typography,
  /// [fontFamily] to change the default font family, or [buttonTheme] to customize button defaults.
  ///
  /// Example:
  /// ```dart
  /// final theme = BlockinTheme.custom(
  ///   colors: MyCustomColors(),
  ///   fontFamily: 'Poppins',
  ///   buttonTheme: BlockinButtonThemeExtension(defaultRadius: BlockinRadiusType.large),
  /// );
  /// ```
  static ThemeData custom({
    required IAppColors colors,
    ThemeData? baseTheme,
    BlockinTypographyExtension? typography,
    String? fontFamily,
    BlockinButtonThemeExtension? buttonTheme,
  }) {
    final base = baseTheme ?? ThemeData.light();
    return _buildTheme(
      colors: colors,
      base: base,
      brightness: colors.brightness,
      typography: typography,
      fontFamily: fontFamily,
      buttonTheme: buttonTheme,
    );
  }
}
