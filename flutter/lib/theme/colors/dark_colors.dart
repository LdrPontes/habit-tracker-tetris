import 'package:flutter/material.dart';
import 'package:blockin/theme/colors/app_colors.dart';
import 'package:blockin/utils/colors.dart';

/// Dark theme semantic colors implementation
///
/// Provides the default dark theme colors for Blockin with a black background
/// and light text. Color scales are automatically swapped for proper contrast.
class DarkSemanticColors extends IAppColors {
  const DarkSemanticColors();

  @override
  Brightness get brightness => Brightness.dark;

  // Layout colors
  @override
  Color get background => const Color(0xFF000000);

  @override
  MaterialColor get foreground =>
      ColorUtils.swapMaterialColor(zinc, shade: 800);

  @override
  Color get divider => const Color(0x26FFFFFF); // rgba(255, 255, 255, 0.15)

  @override
  Color get focus => blue.shade500;

  @override
  Color get overlay => const Color(0xFF000000);

  // Content colors
  @override
  Color get content1 => zinc.shade900;

  @override
  Color get content1Foreground => zinc.shade50;

  @override
  Color get content2 => zinc.shade800;

  @override
  Color get content2Foreground => zinc.shade100;

  @override
  Color get content3 => zinc.shade700;

  @override
  Color get content3Foreground => zinc.shade200;

  @override
  Color get content4 => zinc.shade600;

  @override
  Color get content4Foreground => zinc.shade300;

  // Theme colors with swapped values for dark mode
  @override
  MaterialColor get defaultColor =>
      ColorUtils.swapMaterialColor(zinc, shade: 200);

  @override
  MaterialColor get primary => ColorUtils.swapMaterialColor(blue, shade: 400);

  @override
  MaterialColor get secondary =>
      ColorUtils.swapMaterialColor(purple, shade: 500);

  @override
  MaterialColor get success => ColorUtils.swapMaterialColor(green, shade: 400);

  @override
  MaterialColor get warning => ColorUtils.swapMaterialColor(yellow, shade: 400);

  @override
  MaterialColor get danger => ColorUtils.swapMaterialColor(red, shade: 400);

  // Readable colors are automatically provided by ReadableColorsMixin
}
