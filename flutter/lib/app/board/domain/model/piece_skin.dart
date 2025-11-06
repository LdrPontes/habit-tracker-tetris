import 'package:flutter/material.dart';

/// Represents the visual of a piece.
/// Can be a solid color or a custom SVG.
class PieceSkin {
  final Color? color;
  final String? svgAssetPath;

  const PieceSkin.color(this.color) : svgAssetPath = null;
  const PieceSkin.svg(this.svgAssetPath) : color = null;

  bool get isSvg => svgAssetPath != null;

  PieceSkin copyWith({Color? color, String? svgAssetPath}) {
    return color != null
        ? PieceSkin.color(color)
        : svgAssetPath != null
        ? PieceSkin.svg(svgAssetPath)
        : this;
  }
}
