import 'package:flutter/material.dart';
import 'package:blockin/theme/colors/app_colors.dart';
import 'package:blockin/utils/colors.dart';

/// Light theme semantic colors implementation
///
/// Provides the default light theme colors for Blockin with a clean white
/// background and dark text.
class LightSemanticColors extends IAppColors {
  const LightSemanticColors();

  @override
  Brightness get brightness => Brightness.light;

  // Layout colors
  @override
  Color get background => zinc.shade100;

  @override
  MaterialColor get foreground => ColorUtils.swapMaterialColorDefault(zinc);

  @override
  Color get divider => zinc.shade300;

  @override
  Color get focus => blue.shade500;

  @override
  Color get overlay => black;

  // Content colors
  @override
  Color get content1 => white;

  @override
  Color get content1Foreground => const Color(0xFF11181C);

  @override
  Color get content2 => zinc.shade100;

  @override
  Color get content2Foreground => zinc.shade800;

  @override
  Color get content3 => zinc.shade200;

  @override
  Color get content3Foreground => zinc.shade700;

  @override
  Color get content4 => zinc.shade300;

  @override
  Color get content4Foreground => zinc.shade600;

  // Theme colors
  @override
  MaterialColor get defaultColor => zinc;

  @override
  MaterialColor get primary => blue;

  @override
  MaterialColor get secondary => purple;

  @override
  MaterialColor get success => green;

  @override
  MaterialColor get warning => yellow;

  @override
  MaterialColor get danger => red;

  @override
  Color get inputBorder => zinc.shade300;

  // Readable colors are automatically provided by ReadableColorsMixin
}
