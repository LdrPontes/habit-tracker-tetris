import 'package:flutter/material.dart';
import 'package:blockin/theme/colors/common_colors.dart';
import 'package:blockin/theme/colors/dark_colors.dart';
import 'package:blockin/theme/colors/light_colors.dart';
import 'package:blockin/theme/colors/semantic_colors.dart';

abstract class IAppColors with CommonColorsMixin, ReadableColorsMixin {
  static const _dark = DarkSemanticColors();
  static const _light = LightSemanticColors();

  const IAppColors();

  Brightness get brightness;

  bool get _isDark => brightness == Brightness.dark;

  /// Theme colors
  @override
  MaterialColor get primary => _isDark ? _dark.primary : _light.primary;

  @override
  MaterialColor get secondary => _isDark ? _dark.secondary : _light.secondary;

  @override
  MaterialColor get success => _isDark ? _dark.success : _light.success;

  @override
  MaterialColor get warning => _isDark ? _dark.warning : _light.warning;

  @override
  MaterialColor get danger => _isDark ? _dark.danger : _light.danger;

  @override
  MaterialColor get defaultColor =>
      _isDark ? _dark.defaultColor : _light.defaultColor;

  /// Layout colors
  @override
  Color get background => _isDark ? _dark.background : _light.background;

  @override
  MaterialColor get foreground =>
      _isDark ? _dark.foreground : _light.foreground;

  @override
  Color get divider => _isDark ? _dark.divider : _light.divider;
  @override
  Color get focus => _isDark ? _dark.focus : _light.focus;

  /// Content colors
  @override
  Color get overlay => _isDark ? _dark.overlay : _light.overlay;

  @override
  Color get content1 => _isDark ? _dark.content1 : _light.content1;

  @override
  Color get content1Foreground =>
      _isDark ? _dark.content1Foreground : _light.content1Foreground;

  @override
  Color get content2 => _isDark ? _dark.content2 : _light.content2;

  @override
  Color get content2Foreground =>
      _isDark ? _dark.content2Foreground : _light.content2Foreground;

  @override
  Color get content3 => _isDark ? _dark.content3 : _light.content3;

  @override
  Color get content3Foreground =>
      _isDark ? _dark.content3Foreground : _light.content3Foreground;

  @override
  Color get content4 => _isDark ? _dark.content4 : _light.content4;

  @override
  Color get content4Foreground =>
      _isDark ? _dark.content4Foreground : _light.content4Foreground;

  @override
  Color get inputBorder => _isDark ? _dark.inputBorder : _light.inputBorder;
}
