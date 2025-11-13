import 'package:flutter/material.dart';
import 'package:blockin/theme/constants/button.dart';
import 'package:blockin/theme/constants/radius.dart';
import 'package:blockin/theme/constants/spinner.dart';

/// Theme extension for Blockin button configurations
///
/// This allows global customization of button appearance and behavior
/// while maintaining consistency across the application.
///
/// Example usage:
/// ```dart
/// final theme = Theme.of(context).copyWith(
///   extensions: [
///     BlockinButtonThemeExtension(
///       defaultRadius: BlockinRadiusType.large,
///       disableAnimations: false,
///       defaultSpinnerVariant: BlockinSpinnerVariant.gradient,
///       defaultSpinnerPlacement: BlockinButtonSpinnerPlacement.end,
///       disableRipple: false,
///     ),
///   ],
/// );
/// ```
class BlockinButtonThemeExtension
    extends ThemeExtension<BlockinButtonThemeExtension> {
  /// Cached default instance for better performance
  static const BlockinButtonThemeExtension _default =
      BlockinButtonThemeExtension();

  /// Creates a button theme extension
  const BlockinButtonThemeExtension({
    this.defaultRadius = BlockinRadiusType.medium,
    this.disableAnimations = false,
    this.defaultSize = BlockinButtonSizeType.medium,
    this.defaultVariant = BlockinButtonVariant.solid,
    this.defaultColor = BlockinButtonColor.primary,
    this.scaleOnPress = true,
    this.pressedScale = BlockinButtonAnimation.pressedScale,
    this.animationDuration = BlockinButtonAnimation.pressDuration,
    this.defaultSpinnerVariant = BlockinSpinnerVariant.simple,
    this.defaultSpinnerPlacement = BlockinButtonSpinnerPlacement.start,
    this.disableRipple = false,
  });

  /// Default border radius type for all buttons
  final BlockinRadiusType defaultRadius;

  /// Whether to disable animations globally
  final bool disableAnimations;

  /// Default size for all buttons
  final BlockinButtonSizeType defaultSize;

  /// Default variant for all buttons
  final BlockinButtonVariant defaultVariant;

  /// Default color for all buttons
  final BlockinButtonColor defaultColor;

  /// Whether buttons should scale when pressed
  final bool scaleOnPress;

  /// Scale factor when button is pressed
  final double pressedScale;

  /// Duration for button animations
  final Duration animationDuration;

  /// Default spinner variant for loading buttons
  final BlockinSpinnerVariant defaultSpinnerVariant;

  /// Default spinner placement relative to button content
  final BlockinButtonSpinnerPlacement defaultSpinnerPlacement;

  /// Whether to disable ripple/splash effects globally
  final bool disableRipple;

  @override
  BlockinButtonThemeExtension copyWith({
    BlockinRadiusType? defaultRadius,
    bool? disableAnimations,
    BlockinButtonSizeType? defaultSize,
    BlockinButtonVariant? defaultVariant,
    BlockinButtonColor? defaultColor,
    bool? scaleOnPress,
    double? pressedScale,
    Duration? animationDuration,
    BlockinSpinnerVariant? defaultSpinnerVariant,
    BlockinButtonSpinnerPlacement? defaultSpinnerPlacement,
    bool? disableRipple,
  }) {
    return BlockinButtonThemeExtension(
      defaultRadius: defaultRadius ?? this.defaultRadius,
      disableAnimations: disableAnimations ?? this.disableAnimations,
      defaultSize: defaultSize ?? this.defaultSize,
      defaultVariant: defaultVariant ?? this.defaultVariant,
      defaultColor: defaultColor ?? this.defaultColor,
      scaleOnPress: scaleOnPress ?? this.scaleOnPress,
      pressedScale: pressedScale ?? this.pressedScale,
      animationDuration: animationDuration ?? this.animationDuration,
      defaultSpinnerVariant:
          defaultSpinnerVariant ?? this.defaultSpinnerVariant,
      defaultSpinnerPlacement:
          defaultSpinnerPlacement ?? this.defaultSpinnerPlacement,
      disableRipple: disableRipple ?? this.disableRipple,
    );
  }

  @override
  BlockinButtonThemeExtension lerp(
    ThemeExtension<BlockinButtonThemeExtension>? other,
    double t,
  ) {
    if (other is! BlockinButtonThemeExtension) {
      return this;
    }

    // Optimize lerp by checking if values are the same
    if (t <= 0.0) return this;
    if (t >= 1.0) return other;

    return BlockinButtonThemeExtension(
      defaultRadius: t < 0.5 ? defaultRadius : other.defaultRadius,
      disableAnimations: t < 0.5 ? disableAnimations : other.disableAnimations,
      defaultSize: t < 0.5 ? defaultSize : other.defaultSize,
      defaultVariant: t < 0.5 ? defaultVariant : other.defaultVariant,
      defaultColor: t < 0.5 ? defaultColor : other.defaultColor,
      scaleOnPress: t < 0.5 ? scaleOnPress : other.scaleOnPress,
      pressedScale: t < 0.5 ? pressedScale : other.pressedScale,
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      defaultSpinnerVariant: t < 0.5
          ? defaultSpinnerVariant
          : other.defaultSpinnerVariant,
      defaultSpinnerPlacement: t < 0.5
          ? defaultSpinnerPlacement
          : other.defaultSpinnerPlacement,
      disableRipple: t < 0.5 ? disableRipple : other.disableRipple,
    );
  }

  /// Get button theme extension from the current theme data
  static BlockinButtonThemeExtension of(BuildContext context) {
    final theme = Theme.of(context);
    final extension = theme.extension<BlockinButtonThemeExtension>();
    return extension ?? _default;
  }

  /// Try to get button theme extension from the current theme data
  /// Returns null if not found
  static BlockinButtonThemeExtension? maybeOf(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<BlockinButtonThemeExtension>();
  }
}

/// Extension on ThemeData to easily access button theme
extension BlockinButtonThemeDataExtension on ThemeData {
  /// Get Blockin button theme configuration
  ///
  /// Returns default configuration if extension is not found
  BlockinButtonThemeExtension get blockinButtonTheme {
    return extension<BlockinButtonThemeExtension>() ??
        BlockinButtonThemeExtension._default;
  }
}
