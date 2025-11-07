import 'package:flutter/material.dart';

/// Represents the visual of a piece.
/// Can be a solid color or a custom SVG.
class PieceSkin {
  final Color? color;
  final String? svgAssetPath;
  final int rotationDegrees; // Rotation in degrees (0, 90, 180, 270)

  const PieceSkin.color(this.color, [this.rotationDegrees = 0])
    : svgAssetPath = null;
  const PieceSkin.svg(this.svgAssetPath, [this.rotationDegrees = 0])
    : color = null;

  bool get isSvg => svgAssetPath != null;

  /// Rotates the skin 90° clockwise
  PieceSkin rotate() {
    final newRotation = (rotationDegrees + 90) % 360;
    return color != null
        ? PieceSkin.color(color!, newRotation)
        : PieceSkin.svg(svgAssetPath!, newRotation);
  }

  PieceSkin copyWith({
    Color? color,
    String? svgAssetPath,
    int? rotationDegrees,
  }) {
    final newRotation = rotationDegrees ?? this.rotationDegrees;
    if (color != null) {
      return PieceSkin.color(color, newRotation);
    } else if (svgAssetPath != null) {
      return PieceSkin.svg(svgAssetPath, newRotation);
    } else if (this.svgAssetPath != null) {
      return PieceSkin.svg(this.svgAssetPath!, newRotation);
    } else {
      return PieceSkin.color(this.color!, newRotation);
    }
  }
}
