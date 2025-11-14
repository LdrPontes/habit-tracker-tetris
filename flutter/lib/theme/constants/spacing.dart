import 'package:flutter/material.dart';

/// Spacing constants used throughout the Blockin design system
///
/// These spacing values provide consistent margins, padding, and gaps
/// across all components, following a systematic scale.
///
/// Example usage:
/// ```dart
/// Container(
///   padding: EdgeInsets.all(BlockinSpacing.medium),
///   margin: EdgeInsets.symmetric(horizontal: BlockinSpacing.large),
/// )
/// ```
class Spacing {
  const Spacing._();

  /// No spacing (0px)
  static const double none = 0.0;

  /// Extra small spacing (2px)
  static const double extraSmall = 2.0;

  /// Small spacing (4px)
  static const double small = 4.0;

  /// Medium spacing (8px) - Default
  static const double medium = 8.0;

  /// Large spacing (12px)
  static const double large = 12.0;

  /// Extra large spacing (16px)
  static const double extraLarge = 16.0;

  /// 2x large spacing (20px)
  static const double xxLarge = 20.0;

  /// 3x large spacing (24px)
  static const double xxxLarge = 24.0;

  /// 4x large spacing (32px)
  static const double xxxxLarge = 32.0;

  /// 5x large spacing (40px)
  static const double xxxxxLarge = 40.0;

  static const double big = 48.0;

  static const double xbig = 56.0;

  static const double xxbig = 64.0;
}

/// Spacing configuration for different button layouts
class ButtonSpacing {
  const ButtonSpacing._();

  /// Default gap between icon and text
  static const double iconTextGap = Spacing.medium;

  /// Gap for small buttons
  static const double smallGap = Spacing.medium;

  /// Gap for large buttons
  static const double largeGap = Spacing.large;

  /// Minimum tap target size (accessibility)
  static const double minTapTarget = 44.0;

  /// Border width for bordered/ghost/faded button variants
  static const double borderWidth = 1.5;

  /// Focus ring spacing
  static const double focusRingSpacing = 2.0;
}

extension SpacingExtension on num {
  Widget get w => SizedBox(width: toDouble());
  Widget get h => SizedBox(height: toDouble());
}
