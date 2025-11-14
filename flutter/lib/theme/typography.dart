import 'package:flutter/material.dart';
import 'package:blockin/theme/constants/fonts.dart';

/// Blockin Typography Theme Extension
///
/// This defines the typography scale and text styles for Blockin components.
class BlockinTypographyExtension
    extends ThemeExtension<BlockinTypographyExtension> {
  /// Display large text style - largest heading
  final TextStyle displayLarge;

  /// Display medium text style
  final TextStyle displayMedium;

  /// Display small text style
  final TextStyle displaySmall;

  /// Heading large text style
  final TextStyle headingLarge;

  /// Heading medium text style
  final TextStyle headingMedium;

  /// Heading small text style
  final TextStyle headingSmall;

  /// Title large text style
  final TextStyle titleLarge;

  /// Title medium text style
  final TextStyle titleMedium;

  /// Title small text style
  final TextStyle titleSmall;

  /// Body large text style
  final TextStyle bodyLarge;

  /// Body medium text style (default body text)
  final TextStyle bodyMedium;

  /// Body small text style
  final TextStyle bodySmall;

  /// Label large text style
  final TextStyle labelLarge;

  /// Label medium text style
  final TextStyle labelMedium;

  /// Label small text style
  final TextStyle labelSmall;

  /// Caption text style - smallest text
  final TextStyle caption;

  /// Link text style
  final TextStyle link;

  const BlockinTypographyExtension({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headingLarge,
    required this.headingMedium,
    required this.headingSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.caption,
    required this.link,
  });

  /// Create default typography theme
  factory BlockinTypographyExtension.defaultTheme({
    String? fontFamily,
    Color? color,
  }) {
    return BlockinTypographyExtension(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.displayLarge,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
        color: color,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.displayMedium,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
        color: color,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.displaySmall,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
        color: color,
      ),
      headingLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.headingLarge,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 1.25,
        color: color,
      ),
      headingMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.headingMedium,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 1.29,
        color: color,
      ),
      headingSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.headingSmall,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.33,
        color: color,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.titleLarge,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
        color: color,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.titleMedium,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.5,
        color: color,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.titleSmall,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: color,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.bodyLarge,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.bodyMedium,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
        color: color,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.bodySmall,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: color,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.labelLarge,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: color,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.labelMedium,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
        color: color,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.labelSmall,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
        color: color,
      ),
      caption: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.caption,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.4,
        color: color,
      ),
      link: TextStyle(
        fontFamily: fontFamily,
        fontSize: FontSize.bodySmall,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.1,
        height: 1.4,
        color: color,
        decoration: TextDecoration.underline,
        decorationColor: color,
        decorationThickness: 1.5,
      ),
    );
  }

  @override
  BlockinTypographyExtension copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headingLarge,
    TextStyle? headingMedium,
    TextStyle? headingSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? caption,
    TextStyle? link,
  }) {
    return BlockinTypographyExtension(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headingLarge: headingLarge ?? this.headingLarge,
      headingMedium: headingMedium ?? this.headingMedium,
      headingSmall: headingSmall ?? this.headingSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      caption: caption ?? this.caption,
      link: link ?? this.link,
    );
  }

  @override
  BlockinTypographyExtension lerp(
    ThemeExtension<BlockinTypographyExtension>? other,
    double t,
  ) {
    if (other is! BlockinTypographyExtension) {
      return this;
    }
    return BlockinTypographyExtension(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headingLarge: TextStyle.lerp(headingLarge, other.headingLarge, t)!,
      headingMedium: TextStyle.lerp(headingMedium, other.headingMedium, t)!,
      headingSmall: TextStyle.lerp(headingSmall, other.headingSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      link: TextStyle.lerp(link, other.link, t)!,
    );
  }

  /// Get Blockin typography extension from the current theme data
  static BlockinTypographyExtension of(ThemeData theme) {
    final extension = theme.extension<BlockinTypographyExtension>();
    if (extension == null) {
      throw StateError(
        'BlockinTypographyExtension not found in Theme. '
        'Make sure to add it using BlockinTheme.lightTheme() or BlockinTheme.darkTheme()',
      );
    }
    return extension;
  }

  /// Try to get Blockin typography extension from the current theme data
  /// Returns null if not found
  static BlockinTypographyExtension? maybeOf(ThemeData theme) {
    return theme.extension<BlockinTypographyExtension>();
  }
}

/// Extension on ThemeData to easily access Blockin typography
extension BlockinTypographyDataExtension on ThemeData {
  /// Get Blockin typography from this theme
  ///
  /// Example:
  /// ```dart
  /// final typography = Theme.of(context).blockinTypography;
  /// Text('Hello', style: typography.headingLarge);
  /// ```
  ///
  /// Throws if BlockinTypographyExtension is not found in theme.
  BlockinTypographyExtension get blockinTypography {
    return BlockinTypographyExtension.of(this);
  }

  /// Try to get Blockin typography from this theme
  ///
  /// Returns null if BlockinTypographyExtension is not found.
  BlockinTypographyExtension? get blockinTypographyOrNull {
    return BlockinTypographyExtension.maybeOf(this);
  }
}
