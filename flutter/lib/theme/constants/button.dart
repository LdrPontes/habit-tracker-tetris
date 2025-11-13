import 'package:flutter/material.dart';

/// Button size constants used in Blockin button system
///
/// These sizes define the height, padding, min-width, gap, and text sizes
/// for different button variants following the Blockin design system.
///
/// Example usage:
/// ```dart
/// BlockinButton(
///   size: BlockinButtonSize.medium,
///   child: Text('Click me'),
/// )
/// ```
class BlockinButtonSize {
  const BlockinButtonSize._();

  /// Small button dimensions
  /// Height: 32px, Horizontal padding: 12px, Min-width: 64px, Gap: 8px
  static const ButtonSizeConfig small = ButtonSizeConfig(
    height: 32.0,
    paddingHorizontal: 12.0,
    minWidth: 64.0,
    gap: 8.0,
    fontSize: 12.0, // text-xs
    iconSize: 16.0,
  );

  /// Medium button dimensions (default)
  /// Height: 40px, Horizontal padding: 16px, Min-width: 80px, Gap: 8px
  static const ButtonSizeConfig medium = ButtonSizeConfig(
    height: 40.0,
    paddingHorizontal: 16.0,
    minWidth: 80.0,
    gap: 8.0,
    fontSize: 14.0, // text-sm
    iconSize: 18.0,
  );

  /// Large button dimensions
  /// Height: 48px, Horizontal padding: 24px, Min-width: 96px, Gap: 12px
  static const ButtonSizeConfig large = ButtonSizeConfig(
    height: 48.0,
    paddingHorizontal: 24.0,
    minWidth: 96.0,
    gap: 12.0,
    fontSize: 16.0, // text-base
    iconSize: 20.0,
  );
}

/// Configuration class for button size properties
class ButtonSizeConfig {
  const ButtonSizeConfig({
    required this.height,
    required this.paddingHorizontal,
    required this.minWidth,
    required this.gap,
    required this.fontSize,
    required this.iconSize,
  });

  /// Button height
  final double height;

  /// Horizontal padding inside the button
  final double paddingHorizontal;

  /// Minimum width of the button
  final double minWidth;

  /// Gap between icon and text
  final double gap;

  /// Font size for button text
  final double fontSize;

  /// Size for icons inside buttons
  final double iconSize;

  /// Get square dimensions for icon-only buttons
  double get iconOnlySize => height;
}

/// Button variant types
enum BlockinButtonVariant {
  /// Solid background with contrasting text
  solid,

  /// Transparent background with colored border
  bordered,

  /// Transparent background with colored text
  light,

  /// Semi-transparent background with colored text
  flat,

  /// Light background with border and colored text
  faded,

  /// Solid background with drop shadow
  shadow,

  /// Transparent background with border, hover effects
  ghost,
}

/// Button color types
enum BlockinButtonColor {
  /// Neutral gray theme
  defaultColor,

  /// Primary brand color
  primary,

  /// Secondary brand color
  secondary,

  /// Green success color
  success,

  /// Orange/yellow warning color
  warning,

  /// Red danger color
  danger,
}

/// Button size types
enum BlockinButtonSizeType {
  /// Small button (32px height)
  small,

  /// Medium button (40px height, default)
  medium,

  /// Large button (48px height)
  large,
}

/// Button animation constants
class BlockinButtonAnimation {
  const BlockinButtonAnimation._();

  /// Scale factor when button is pressed
  static const double pressedScale = 0.97;

  /// Duration for press animation
  static const Duration pressDuration = Duration(milliseconds: 150);

  /// Duration for hover/focus transitions
  static const Duration hoverDuration = Duration(milliseconds: 200);

  /// Duration for color transitions
  static const Duration colorDuration = Duration(milliseconds: 150);

  /// Curve for press animation
  static const Curve pressCurve = Curves.easeInOut;

  /// Curve for hover transitions
  static const Curve hoverCurve = Curves.easeInOut;
}

/// Button opacity constants
class BlockinButtonOpacity {
  const BlockinButtonOpacity._();

  /// Opacity when button is disabled
  static const double disabled = 0.5;

  /// Opacity for hover effects on solid/shadow variants
  static const double hover = 0.8;

  /// Opacity for flat variant backgrounds
  static const double flatBackground = 0.2;

  /// Opacity for light variant hover backgrounds
  static const double lightHover = 0.2;

  /// Opacity for flat variant backgrounds (stronger)
  static const double flatBackgroundStrong = 0.4;

  /// Opacity for overlay/splash effects
  static const double overlay = 0.1;
}

/// Focus ring constants for buttons
class BlockinButtonFocus {
  const BlockinButtonFocus._();

  /// Width of focus ring
  static const double ringWidth = 2.0;

  /// Offset of focus ring from button edge
  static const double ringOffset = 2.0;

  /// Z-index for focused buttons
  static const int focusZIndex = 10;
}

/// Spinner placement for loading state buttons
enum BlockinButtonSpinnerPlacement {
  /// Spinner appears before the button content
  start,

  /// Spinner appears after the button content
  end,
}
