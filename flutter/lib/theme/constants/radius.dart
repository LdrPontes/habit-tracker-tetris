import 'package:flutter/material.dart';

/// Border radius constants used throughout the Blockin design system
///
/// These radius values provide consistent rounded corners across all components,
/// following modern design principles with smooth, accessible curves.
///
/// Example usage:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(BlockinRadius.medium),
///   ),
/// )
/// ```
class BlockinRadius {
  const BlockinRadius._();

  /// No border radius (0px)
  static const double none = 0.0;

  /// Small border radius (4px)
  /// Used for: small buttons, chips, small cards
  static const double small = 4.0;

  /// Medium border radius (8px) - Default
  /// Used for: buttons, inputs, medium cards
  static const double medium = 8.0;

  /// Large border radius (12px)
  /// Used for: large buttons, modals, large cards
  static const double large = 12.0;

  /// Extra large border radius (16px)
  /// Used for: hero cards, special containers
  static const double extraLarge = 16.0;

  /// Full border radius (999px)
  /// Creates fully rounded (pill-shaped) elements
  static const double full = 999.0;
}

/// Border radius configuration for different button states
class BlockinButtonRadius {
  const BlockinButtonRadius._();

  /// Get border radius based on radius type and button size
  static double getRadius(BlockinRadiusType type, {bool isIconOnly = false}) {
    switch (type) {
      case BlockinRadiusType.none:
        return BlockinRadius.none;
      case BlockinRadiusType.small:
        return BlockinRadius.small;
      case BlockinRadiusType.medium:
        return BlockinRadius.medium;
      case BlockinRadiusType.large:
        return BlockinRadius.large;
      case BlockinRadiusType.full:
        return isIconOnly ? BlockinRadius.full : BlockinRadius.full;
    }
  }

  /// Get border radius for button groups
  static BorderRadius getGroupRadius(
    BlockinRadiusType type, {
    required bool isFirst,
    required bool isLast,
    required bool isVertical,
  }) {
    final radius = getRadius(type);

    if (isVertical) {
      // Vertical button group
      if (isFirst && isLast) {
        // Single button
        return BorderRadius.circular(radius);
      } else if (isFirst) {
        // First button - rounded top
        return BorderRadius.vertical(top: Radius.circular(radius));
      } else if (isLast) {
        // Last button - rounded bottom
        return BorderRadius.vertical(bottom: Radius.circular(radius));
      } else {
        // Middle button - no rounding
        return BorderRadius.zero;
      }
    } else {
      // Horizontal button group
      if (isFirst && isLast) {
        // Single button
        return BorderRadius.circular(radius);
      } else if (isFirst) {
        // First button - rounded left
        return BorderRadius.horizontal(left: Radius.circular(radius));
      } else if (isLast) {
        // Last button - rounded right
        return BorderRadius.horizontal(right: Radius.circular(radius));
      } else {
        // Middle button - no rounding
        return BorderRadius.zero;
      }
    }
  }
}

/// Radius type enumeration
enum BlockinRadiusType {
  /// No border radius
  none,

  /// Small border radius (4px)
  small,

  /// Medium border radius (8px) - default
  medium,

  /// Large border radius (12px)
  large,

  /// Full border radius (pill shape)
  full,
}

/// Shadow constants for different elevation levels
class BlockinShadow {
  const BlockinShadow._();

  /// No shadow
  static const List<BoxShadow> none = [];

  /// Small shadow - subtle depth
  static const List<BoxShadow> small = [
    BoxShadow(
      color: Color(0x0F000000), // black with 6% opacity
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  /// Medium shadow - moderate depth (default)
  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x1A000000), // black with 10% opacity
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x0F000000), // black with 6% opacity
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  /// Large shadow - strong depth
  static const List<BoxShadow> large = [
    BoxShadow(
      color: Color(0x25000000), // black with 15% opacity
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x1A000000), // black with 10% opacity
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];

  /// Extra large shadow - dramatic depth
  static const List<BoxShadow> extraLarge = [
    BoxShadow(
      color: Color(0x25000000), // black with 15% opacity
      offset: Offset(0, 25),
      blurRadius: 25,
      spreadRadius: -5,
    ),
    BoxShadow(
      color: Color(0x1A000000), // black with 10% opacity
      offset: Offset(0, 10),
      blurRadius: 10,
      spreadRadius: -5,
    ),
  ];

  /// Get colored shadow for button shadow variant
  static List<BoxShadow> getColoredShadow(Color color, {double opacity = 0.4}) {
    return [
      BoxShadow(
        color: color.withAlpha((opacity * 255).round()),
        offset: const Offset(0, 4),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ];
  }
}
