import 'package:flutter/material.dart';
import 'package:blockin/utils/colors.dart';

/// Main interface for all Blockin semantic colors
///
/// This is the single interface that defines all colors needed for a theme.
/// It includes layout colors, content colors, theme colors, and readable colors.
abstract class SemanticColors {
  // Layout colors
  Color get background;
  MaterialColor get foreground;
  Color get divider;
  Color get focus;
  Color get overlay;

  // Content colors
  Color get content1;
  Color get content1Foreground;
  Color get content2;
  Color get content2Foreground;
  Color get content3;
  Color get content3Foreground;
  Color get content4;
  Color get content4Foreground;

  // Theme colors
  MaterialColor get defaultColor;
  MaterialColor get primary;
  MaterialColor get secondary;
  MaterialColor get success;
  MaterialColor get warning;
  MaterialColor get danger;

  // Readable colors (auto-calculated for text on colored backgrounds)
  Color get defaultReadableColor;
  Color get primaryReadableColor;
  Color get secondaryReadableColor;
  Color get successReadableColor;
  Color get warningReadableColor;
  Color get dangerReadableColor;

  Color get inputBorder;
}

/// Internal mixin that auto-calculates readable colors
///
/// This mixin automatically provides implementations for all readable color
/// getters by calculating them based on the theme colors using WCAG contrast.
mixin ReadableColorsMixin implements SemanticColors {
  @override
  Color get defaultReadableColor => ColorUtils.readableColor(defaultColor);

  @override
  Color get primaryReadableColor => ColorUtils.readableColor(primary);

  @override
  Color get secondaryReadableColor => ColorUtils.readableColor(secondary);

  @override
  Color get successReadableColor => ColorUtils.readableColor(success);

  @override
  Color get warningReadableColor => ColorUtils.readableColor(warning);

  @override
  Color get dangerReadableColor => ColorUtils.readableColor(danger);
}
